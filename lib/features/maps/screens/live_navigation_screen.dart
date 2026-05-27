import 'package:flutter/material.dart';

import '../widgets/arrival_alert_dialog.dart';

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
  void initState() {

    super.initState();

    /// TESTING
    /// 10 seconds after opening
    /// popup will appear
    Future.delayed(

      const Duration(
        seconds: 10,
      ),

      () {

        if (!mounted) return;

        showArrivalAlertDialog(
          context,
        );
      },
    );
  }

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