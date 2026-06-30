import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:smartnav/features/maps/models/direction_data.dart';

class OsrmService {
  Future<DirectionData> getRoute(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) async {
    final url = Uri.parse(
      "https://router.project-osrm.org/route/v1/driving/"
      "$startLng,$startLat;"
      "$endLng,$endLat"
      "?overview=full"
      "&steps=true"
      "&geometries=geojson",
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Unable to fetch route");
    }

    final data = jsonDecode(response.body);

    final route = data["routes"][0];

    final distanceKm =
        (route["distance"] / 1000).toStringAsFixed(1);

    final durationMin =
        (route["duration"] / 60).round();

    final polyline =
        route["geometry"]["coordinates"];

    List<Map<String, dynamic>> steps = [];

    for (var step in route["legs"][0]["steps"]) {
      IconData icon = Icons.north;

      final maneuver = step["maneuver"]["type"] ?? "";
      final modifier = step["maneuver"]["modifier"] ?? "";

      if (maneuver == "turn") {
        if (modifier == "right") {
          icon = Icons.turn_right;
        } else if (modifier == "left") {
          icon = Icons.turn_left;
        }
      } else if (maneuver == "depart") {
        icon = Icons.navigation;
      } else if (maneuver == "arrive") {
        icon = Icons.location_on;
      }

      final distance =
          (step["distance"] as num).toDouble();

      steps.add({
        "icon": icon,
        "title": step["name"] == ""
            ? maneuver.toString().toUpperCase()
            : "${maneuver.toString().toUpperCase()} on ${step["name"]}",
        "distance": "${distance.toStringAsFixed(0)} m",
      });
    }

    final arrivalTime =
        DateTime.now().add(Duration(minutes: durationMin));

    return DirectionData(
      duration: "$durationMin min",
      distance: "$distanceKm km",
      arrivalTime:
          "${arrivalTime.hour.toString().padLeft(2, '0')}:${arrivalTime.minute.toString().padLeft(2, '0')}",
      directions: steps,
      polyline: polyline,
    );
  }
}