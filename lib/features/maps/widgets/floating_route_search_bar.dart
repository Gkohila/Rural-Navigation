import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FloatingRouteSearchBar extends StatefulWidget {
  final String source;
  final String destination;

  const FloatingRouteSearchBar({
    super.key,
    required this.source,
    required this.destination,
  });

  @override
  State<FloatingRouteSearchBar> createState() => _FloatingRouteSearchBarState();
}

class _FloatingRouteSearchBarState extends State<FloatingRouteSearchBar> {
  late final TextEditingController sourceController;
  late final TextEditingController destinationController;
  final FocusNode _destinationFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    sourceController = TextEditingController(text: widget.source);
    destinationController = TextEditingController(text: widget.destination);
  }

  @override
  void didUpdateWidget(covariant FloatingRouteSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.source != widget.source &&
        sourceController.text != widget.source) {
      sourceController.text = widget.source;
    }

    if (oldWidget.destination != widget.destination &&
        destinationController.text != widget.destination) {
      destinationController.text = widget.destination;
    }
  }

  @override
  void dispose() {
    sourceController.dispose();
    destinationController.dispose();
    _destinationFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submitSearch() async {
    final source = sourceController.text.trim();
    final destination = destinationController.text.trim();

    if (source.isEmpty || destination.isEmpty) {
      return;
    }

    await _geocodeLocations(source, destination);
    await _saveSearchHistory(source, destination);
  }

  Future<void> _geocodeLocations(String source, String destination) async {
    try {
      await locationFromAddress(source);
    } catch (_) {}

    try {
      await locationFromAddress(destination);
    } catch (_) {}
  }

  Future<void> _saveSearchHistory(String source, String destination) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');

    final now = TimeOfDay.now();
    final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    final period = now.period == DayPeriod.am ? 'AM' : 'PM';
    final time = '$hour:${now.minute.toString().padLeft(2, '0')} $period';

    final searches = prefs.getStringList('search_history') ?? <String>[];
    searches.insert(0, '$source -> $destination|$time');

    await prefs.setStringList('search_history', searches);
    await prefs.setString('last_search', '$source -> $destination');
    await prefs.setString('last_search_time', time);

    try {
      await http.post(
        Uri.parse('http://localhost:8081/api/history'),
        headers: const {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'source': source,
          'destination': destination,
          'transportType': 'BUS',
        }),
      );
    } catch (_) {}
  }

  void _swapLocations() {
    setState(() {
      final currentSource = sourceController.text;
      sourceController.text = destinationController.text;
      destinationController.text = currentSource;
    });
  }

  Future<void> _handleVoiceSearch() async {
    final String? voiceResult = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        final TextEditingController voiceController = TextEditingController();

        return AlertDialog(
          title: const Text('Voice search'),
          content: TextField(
            controller: voiceController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Speak or enter destination',
            ),
            onSubmitted: (value) {
              Navigator.of(dialogContext).pop(value.trim());
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(voiceController.text.trim());
              },
              child: const Text('Use'),
            ),
          ],
        );
      },
    );

    if (!mounted || voiceResult == null || voiceResult.isEmpty) {
      return;
    }

    setState(() {
      destinationController.text = voiceResult;
    });

    await _submitSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 58),
          padding: const EdgeInsets.only(
            left: 16,
            right: 12,
            top: 10,
            bottom: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.88),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const SizedBox(height: 8),
                  const Icon(
                    Icons.radio_button_checked,
                    color: Color(0xFF0B5D1E),
                    size: 15,
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.location_on,
                    color: Colors.red.shade500,
                    size: 21,
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
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
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) {
                            _destinationFocusNode.requestFocus();
                          },
                          decoration: const InputDecoration(
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
                          focusNode: _destinationFocusNode,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (_) async {
                            await _submitSearch();
                          },
                          decoration: const InputDecoration(
                            hintText: 'Choose destination',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                            border: InputBorder.none,
                            isCollapsed: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: _swapLocations,
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
                  GestureDetector(
                    onTap: _handleVoiceSearch,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.mic_none_rounded,
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
                    color: Colors.black.withOpacity(0.06),
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