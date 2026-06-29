class DirectionData {

  final String duration;

  final String distance;

  final String arrivalTime;

  final List<Map<String, dynamic>> directions;

  final List<dynamic> polyline;

  DirectionData({

    required this.duration,

    required this.distance,

    required this.arrivalTime,

    required this.directions,

    required this.polyline,

  });

}