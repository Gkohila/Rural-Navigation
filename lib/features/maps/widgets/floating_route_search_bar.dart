import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../../services/geocoding_service.dart';
import '../../../services/local_geocoding_service.dart';

class FloatingRouteSearchBar extends StatefulWidget {
  final String source;
  final String destination;
  final Function(String source, String destination)? onSearch;

  const FloatingRouteSearchBar({
    super.key,
    required this.source,
    required this.destination,
    this.onSearch,
  });

  @override
  State<FloatingRouteSearchBar> createState() => _FloatingRouteSearchBarState();
}

class _FloatingRouteSearchBarState extends State<FloatingRouteSearchBar> {
  late TextEditingController sourceController;
  late TextEditingController destinationController;

  late stt.SpeechToText speech;

  bool isListening = false;
  List<String> suggestions = [];
  bool showSuggestions = false;
  bool isSourceFocused = false;
  Map<String, double>? sourceLocation;
  Map<String, double>? destinationLocation;

  double? sourceLat;
  double? sourceLng;
  double? destinationLat;
  double? destinationLng;

  @override
  void initState() {
    super.initState();

    speech = stt.SpeechToText();

    sourceController = TextEditingController(text: widget.source);

    destinationController = TextEditingController(text: widget.destination);
  }

  @override
  void dispose() {
    sourceController.dispose();
    destinationController.dispose();
    super.dispose();
  }

  Future<void> saveSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();

    final userId = prefs.getInt("user_id");

    final now = TimeOfDay.now();

    final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;

    final period = now.period == DayPeriod.am ? "AM" : "PM";

    final time = "$hour:${now.minute.toString().padLeft(2, '0')} $period";

    final history = prefs.getStringList("search_history") ?? [];

    history.insert(
      0,
      "${sourceController.text} -> ${destinationController.text}|$time",
    );

    await prefs.setStringList("search_history", history);

    await prefs.setString("last_search_time", time);

    if (userId != null) {
      await http.post(
        Uri.parse("http://localhost:8081/api/history"),

        headers: {"Content-Type": "application/json"},

        body: jsonEncode({
          "userId": userId,

          "source": sourceController.text,

          "destination": destinationController.text,

          "transportType": "BUS",
        }),
      );
    }

    debugPrint("History Saved");
  }

  Future<void> startVoiceSearch() async {
    print("MIC BUTTON PRESSED");

    if (isListening) return;

    bool available = await speech.initialize(
      onStatus: (status) {
        print("SPEECH STATUS = $status");
      },
      onError: (error) {
        print("SPEECH ERROR = $error");
      },
    );

    print("SPEECH AVAILABLE = $available");

    if (!available) {
      print("Speech not available");
      return;
    }

    setState(() {
      isListening = true;
    });

    print("START LISTENING...");
    speech.listen(
      listenFor: const Duration(seconds: 8),
      pauseFor: const Duration(seconds: 2),
      onResult: (result) {
        String text = result.recognizedWords.toLowerCase().trim();

        print("TEXT = '$text'");
        print("FINAL = ${result.finalResult}");
        print("TEXT = ${result.recognizedWords}");

        if (!result.finalResult) {
          return;
        }

        speech.stop();

        setState(() {
          isListening = false;
        });

        final places = text.split(RegExp(r"\s+to\s+"));

        if (places.length == 2) {
          sourceController.text = places[0].trim();
          destinationController.text = places[1].trim();
          print("SOURCE FILLED = ${sourceController.text}");
          print("DESTINATION FILLED = ${destinationController.text}");
          Future.delayed(const Duration(milliseconds: 300), () {
            widget.onSearch?.call(
              sourceController.text.trim(),
              destinationController.text.trim(),
            );

            saveSearchHistory();
          });
        }
      },
    );
  }

  void updateSuggestions(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        suggestions = [];
        showSuggestions = false;
      });
      return;
    }

    final q = query.toLowerCase();

    final matches = LocalGeocodingService.places.keys
        .where((place) => place.contains(q))
        .take(8)
        .toList();

    setState(() {
      suggestions = matches;
      showSuggestions = matches.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,

      children: [
        Container(
          margin: const EdgeInsets.only(left: 58),

          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),

            borderRadius: BorderRadius.circular(22),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),

                blurRadius: 18,

                offset: const Offset(0, 6),
              ),
            ],
          ),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              /// LEFT ICONS
              Column(
                children: [
                  const SizedBox(height: 8),

                  const Icon(
                    Icons.radio_button_checked,

                    size: 15,

                    color: Color(0xFF0B5D1E),
                  ),

                  Column(
                    children: List.generate(
                      5,

                      (_) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 1.5),

                        width: 2,

                        height: 4,

                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,

                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),

                  Icon(Icons.location_on, color: Colors.red.shade500, size: 20),
                ],
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  children: [
                    /// SOURCE
                    Container(
                      height: 44,

                      padding: const EdgeInsets.symmetric(horizontal: 14),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        border: Border.all(color: Colors.grey.shade300),

                        borderRadius: BorderRadius.circular(14),
                      ),

                      child: Align(
                        alignment: Alignment.centerLeft,

                        child: TextField(
                          controller: sourceController,

                          onTap: () {
                            print("SUGGESTION CLICKED");
                            isSourceFocused = true;
                          },

                          onChanged: updateSuggestions,

                          decoration: const InputDecoration(
                            hintText: "Your location",
                            border: InputBorder.none,
                            isCollapsed: true,
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0B5D1E),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// DESTINATION
                    Container(
                      height: 44,

                      padding: const EdgeInsets.symmetric(horizontal: 14),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        border: Border.all(color: Colors.grey.shade300),

                        borderRadius: BorderRadius.circular(14),
                      ),

                      child: Align(
                        alignment: Alignment.centerLeft,

                        child: TextField(
                          controller: destinationController,

                          onTap: () {
                            print("SUGGESTION CLICKED");
                            isSourceFocused = false;
                          },

                          onChanged: updateSuggestions,

                          onSubmitted: (_) async {
                            sourceLocation =
                                await GeocodingService.getCoordinates(
                                  sourceController.text,
                                );

                            destinationLocation =
                                await GeocodingService.getCoordinates(
                                  destinationController.text,
                                );

                            if (sourceLocation != null &&
                                destinationLocation != null) {
                              sourceLat = sourceLocation!["lat"];
                              sourceLng = sourceLocation!["lng"];

                              destinationLat = destinationLocation!["lat"];
                              destinationLng = destinationLocation!["lng"];
                            }

                            await saveSearchHistory();

                            widget.onSearch?.call(
                              sourceController.text.trim(),
                              destinationController.text.trim(),
                            );
                          },

                          decoration: const InputDecoration(
                            hintText: "Choose destination",
                            border: InputBorder.none,
                            isCollapsed: true,
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              /// RIGHT SIDE
              Column(
                children: [
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {
                      final temp = sourceController.text;
                      sourceController.text = destinationController.text;
                      destinationController.text = temp;
                      setState(() {});
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.swap_vert_rounded,
                        color: Colors.black87,
                        size: 22,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  GestureDetector(
                    onTap: startVoiceSearch,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isListening ? Icons.mic : Icons.mic_none_rounded,
                        color: Colors.black87,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        if (showSuggestions)
          Positioned(
            top: 130,
            left: 58,
            right: 0,
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                constraints: const BoxConstraints(maxHeight: 220),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final place = suggestions[index];

                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          if (isSourceFocused) {
                            sourceController.text = place;
                          } else {
                            destinationController.text = place;
                          }

                          setState(() {
                            showSuggestions = false;
                          });

                          FocusManager.instance.primaryFocus?.unfocus();

                          // Auto search only when both fields have values
                          if (sourceController.text.isNotEmpty &&
                              destinationController.text.isNotEmpty) {
                            sourceLocation =
                                await GeocodingService.getCoordinates(
                                  sourceController.text,
                                );

                            destinationLocation =
                                await GeocodingService.getCoordinates(
                                  destinationController.text,
                                );

                            await saveSearchHistory();

                            widget.onSearch?.call(
                              sourceController.text.trim(),
                              destinationController.text.trim(),
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.red),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  place,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

        /// BACK BUTTON
        Positioned(
          left: 0,

          top: 34,

          child: GestureDetector(
            onTap: () {
              Navigator.of(context).maybePop();
            },

            child: Container(
              width: 42,

              height: 42,

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(14),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.06),

                    blurRadius: 10,

                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: const Icon(
                Icons.arrow_back,

                size: 24,

                color: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
