import 'package:flutter/material.dart';

import 'screens/routes/trip_planner_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: const TripPlannerScreen(
        transportName: 'Lion Travels',
        routeNumber: '147C',
        departureTime: '5:25 pm',
        arrivalTime: '5:55 pm',
      ),
    );
  }
}