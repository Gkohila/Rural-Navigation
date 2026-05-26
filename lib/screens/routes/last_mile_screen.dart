import 'package:flutter/material.dart';

class LastMileScreen extends StatelessWidget {
  const LastMileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            const Icon(
              Icons.location_on,
              size: 80,
              color: Colors.green,
            ),

            const SizedBox(height: 20),

            const Text(
              "Last Mile Screen",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}