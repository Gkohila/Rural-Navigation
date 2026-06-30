class SavedRouteModel {
  final int? id;
  final int userId;
  final String vehicleNumber;
  final String busName;
  final String source;
  final String destination;
  final String departureTime;
  final String arrivalTime;
  final int duration;
  final double fare;
  final String transportMode;

  SavedRouteModel({
    this.id,
    required this.userId,
    required this.vehicleNumber,
    required this.busName,
    required this.source,
    required this.destination,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.fare,
    required this.transportMode,
  });

  factory SavedRouteModel.fromJson(
      Map<String, dynamic> json) {

    return SavedRouteModel(
      id: json["id"],
      userId: json["userId"],
      vehicleNumber: json["vehicleNumber"],
      busName: json["busName"],
      source: json["source"],
      destination: json["destination"],
      departureTime: json["departureTime"],
      arrivalTime: json["arrivalTime"],
      duration: json["duration"],
      fare: (json["fare"] as num).toDouble(),
      transportMode: json["transportMode"],
    );
  }

  Map<String, dynamic> toJson() {

    return {
      "userId": userId,
      "vehicleNumber": vehicleNumber,
      "busName": busName,
      "source": source,
      "destination": destination,
      "departureTime": departureTime,
      "arrivalTime": arrivalTime,
      "duration": duration,
      "fare": fare,
      "transportMode": transportMode,
    };
  }
}