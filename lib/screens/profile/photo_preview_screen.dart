import 'dart:typed_data';
import 'package:flutter/material.dart';

class PhotoPreviewScreen extends StatelessWidget {
  final Uint8List imageBytes;

  const PhotoPreviewScreen({
  required this.imageBytes,
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.memory(
              imageBytes,
              fit: BoxFit.contain,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Retake"),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        imageBytes,
                      );
                    },
                    child: const Text("Use Photo"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}