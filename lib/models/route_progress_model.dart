class RouteProgressModel {

  final String vehicleNumber;
  final String currentStop;
  final String nextStop;
  final int stopsRemaining;
  final double progressPercentage;
  final int etaMinutes;
  final bool routeDeviation;
  final double deviationDistanceMeters;
  final bool destinationReached;
  final String destinationStop;

  RouteProgressModel({
    required this.vehicleNumber,
    required this.currentStop,
    required this.nextStop,
    required this.stopsRemaining,
    required this.progressPercentage,
    required this.etaMinutes,
    required this.routeDeviation,
    required this.deviationDistanceMeters,
    required this.destinationReached,
    required this.destinationStop,
  });

  factory RouteProgressModel.fromJson(
      Map<String, dynamic> json) {

    return RouteProgressModel(

      vehicleNumber:
          json['vehicleNumber'] ?? "",

      currentStop:
          json['currentStop'] ?? "",

      nextStop:
          json['nextStop'] ?? "",

      stopsRemaining:
          json['stopsRemaining'] ?? 0,

      progressPercentage:
          (json['progressPercentage'] ?? 0)
              .toDouble(),

      etaMinutes:
          json['etaMinutes'] ?? 0,

      routeDeviation:
          json['routeDeviation'] ?? false,

      deviationDistanceMeters:
          (json['deviationDistanceMeters'] ?? 0)
              .toDouble(),

      destinationReached:
          json['destinationReached'] ?? false,

      destinationStop:
          json['destinationStop'] ?? "",
    );
  }
}