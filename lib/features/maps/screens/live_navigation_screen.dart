import 'package:flutter/material.dart';

class LiveNavigationScreen extends StatefulWidget {

  const LiveNavigationScreen({
    super.key,
  });

  @override
  State<LiveNavigationScreen> createState() =>
      _LiveNavigationScreenState();
}

class _LiveNavigationScreenState
    extends State<LiveNavigationScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      appBar: AppBar(

        title: const Text(
          'Live Navigation',
        ),
      ),

      body: const Center(

        child: Text(

          'Live Navigation Running',

          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}