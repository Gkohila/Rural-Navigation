import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart';
import '../services/osrm_service.dart';
import '../../../services/geocoding_service.dart';

class FloatingRouteSearchBar extends StatefulWidget {
  const FloatingRouteSearchBar({super.key});

  @override
  State<FloatingRouteSearchBar> createState() =>
      _FloatingRouteSearchBarState();
}

class _FloatingRouteSearchBarState
    extends State<FloatingRouteSearchBar> {
       final TextEditingController sourceController =
      TextEditingController();

  final TextEditingController destinationController =
      TextEditingController();

  SpeechToText speech = SpeechToText();

  bool isListening = false;
  Map<String, double>? sourceLocation;
Map<String, double>? destinationLocation;

double? sourceLat;
double? sourceLng;
double? destinationLat;
double? destinationLng;
      
     @override
  void dispose() {
    sourceController.dispose();
    destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(

      clipBehavior: Clip.none,

      children: [

        /// ================= MAIN SEARCH BOX =================
        Container(

          /// 🔥 MORE GAP FOR FLOATING BACK BUTTON
          margin: const EdgeInsets.only(
            left: 58,
          ),

          padding: const EdgeInsets.only(
            left: 16,
            right: 12,
            top: 10,
            bottom: 10,
          ),

          decoration: BoxDecoration(

            color:
      Colors.white.withOpacity(0.88),

            borderRadius:
                BorderRadius.circular(22),

            boxShadow: [

              BoxShadow(

                color:
                    Colors.black.withOpacity(
                  0.06,
                ),

                blurRadius: 18,

                offset:
                    const Offset(0, 6),
              ),
            ],
          ),

          child: Row(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              /// ================= LEFT SIDE ICONS =================
              Column(

                children: [

                  const SizedBox(height: 8),

                  Icon(

                    Icons.radio_button_checked,

                    color:
                        const Color(0xFF0B5D1E),

                    size: 15,
                  ),

                  Column(

                    children: List.generate(
                      5,

                      (_) => Container(

                        margin:
                            const EdgeInsets.symmetric(
                          vertical: 1.5,
                        ),

                        width: 2,
                        height: 4,

                        decoration:
                            BoxDecoration(

                          color:
                              Colors.grey.shade400,

                          borderRadius:
                              BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Icon(

                    Icons.location_on,

                    color:
                        Colors.red.shade500,

                    size: 21,
                  ),
                ],
              ),

              const SizedBox(width: 10),

              /// ================= TEXT FIELDS =================
              Expanded(

                child: Column(

                  children: [

                    /// SOURCE
                    Container(

                      height: 44,

                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 14,
                      ),

                      decoration: BoxDecoration(

                        color: Colors.white,

                        border:
                            Border.all(
                          color:
                              Colors.grey.shade300,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),
                      ),

                      child:  Align(

                        alignment:
                            Alignment.centerLeft,

                        child: TextField(
  controller: sourceController,

  decoration: InputDecoration(
    hintText: 'Your location',

    hintStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color(0xFF0B5D1E),
    ),

    border: InputBorder.none,

    isCollapsed: true,
  ),
),
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// DESTINATION
                    Container(

                      height: 44,

                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 14,
                      ),

                      decoration: BoxDecoration(

                        color: Colors.white,

                        border:
                            Border.all(
                          color:
                              Colors.grey.shade300,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),
                      ),

                      child:  Align(

                        alignment:
                            Alignment.centerLeft,

                       child: TextField(

  controller: destinationController,

  onSubmitted: (value) async {
    print("SOURCE = ${sourceController.text}");
    print("DESTINATION = ${destinationController.text}");
    sourceLocation = await GeocodingService.getCoordinates(
  sourceController.text,
);

destinationLocation = await GeocodingService.getCoordinates(
  destinationController.text,
);

if (sourceLocation != null && destinationLocation != null) {

  sourceLat = sourceLocation!["lat"];
  sourceLng = sourceLocation!["lng"];

  destinationLat = destinationLocation!["lat"];
  destinationLng = destinationLocation!["lng"];

  print("SOURCE LAT = $sourceLat");
  print("SOURCE LNG = $sourceLng");

  print("DEST LAT = $destinationLat");
  print("DEST LNG = $destinationLng");
}
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("user_id");

print("USER ID = $userId");
    final now = TimeOfDay.now();
    final hour =
    now.hourOfPeriod == 0
        ? 12
        : now.hourOfPeriod;

final period =
    now.period == DayPeriod.am
        ? "AM"
        : "PM";
final time =
"$hour:${now.minute.toString().padLeft(2, '0')} $period";

final searches =
    prefs.getStringList("search_history") ?? [];

searches.insert(
  0,
  "${sourceController.text} -> ${destinationController.text}|$time",
);

await prefs.setStringList(
  "search_history",
  searches,
);
await http.post(
  Uri.parse("http://localhost:8081/api/history"),
  headers: {
    "Content-Type": "application/json",
  },
  body: jsonEncode({
    "userId": userId,
    "source": sourceController.text,
    "destination": destinationController.text,
    "transportType": "BUS",
  }),
);

print("HISTORY SAVED TO DATABASE");
await prefs.setString(
  "last_search_time",
  time,
);

print("HISTORY SAVED");
String? history = prefs.getString("last_search");
print("HISTORY READ = $history");
  },

  decoration: InputDecoration(
    hintText: 'Choose destination',

                            hintStyle:
                                TextStyle(

                              fontSize: 16,

                              fontWeight:
                                  FontWeight.w500,

                              color:
                                  Colors.black54,
                            ),

                            border:
                                InputBorder.none,

                            isCollapsed:
                                true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              /// ================= RIGHT SIDE ICONS =================
              Column(

                children: [

                  const SizedBox(height: 4),

                  /// SWAP ICON
GestureDetector(
  onTap: () {
    setState(() {
      final temp = sourceController.text;
      sourceController.text = destinationController.text;
      destinationController.text = temp;
    });
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
      size: 22,
      color: Colors.black87,
    ),
  ),
),

                  const SizedBox(height: 12),

                  /// MIC ICON
                 GestureDetector(
  onTap: () async {

    bool available = await speech.initialize();

    if (available) {

      setState(() {
        isListening = true;
      });

      speech.listen(
        onResult: (result) {

          String text = result.recognizedWords;

          print("VOICE = $text");
          if (text.toLowerCase().contains("to")) {

  List<String> places = text.split("to");

  if (places.length == 2) {

    setState(() {

      sourceController.text = places[0].trim();

      destinationController.text = places[1].trim();

    });

  }

}

        },
      );

    }

  },

  child: Container(
    width: 40,
    height: 40,

    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      shape: BoxShape.circle,
    ),

    child: Icon(
      isListening
          ? Icons.mic
          : Icons.mic_none_rounded,
      size: 22,
      color: Colors.black87,
    ),
  ),
),
                ],
              ),
            ],
          ),
        ),

        /// ================= FLOATING BACK BUTTON =================
        Positioned(

          left: 0,
          top: 34,

          child: GestureDetector(

            onTap: () {

              Navigator.of(context)
                  .maybePop();
            },

            child: Container(

              width: 42,
              height: 42,

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  14,
                ),

                boxShadow: [

                  BoxShadow(

                    color:
                        Colors.black.withOpacity(
                      0.06,
                    ),

                    blurRadius: 10,

                    offset:
                        const Offset(0, 4),
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