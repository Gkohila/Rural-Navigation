class AlertModel {

  final int id;
  final String alertType;
  final String message;
  final String vehicleNumber;
  final bool isRead;
  final String priority;
  final String createdTime;

  AlertModel({
    required this.id,
    required this.alertType,
    required this.message,
    required this.vehicleNumber,
    required this.isRead,
    required this.priority,
    required this.createdTime,
  });

  factory AlertModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return AlertModel(
      id: json['id'],
      alertType: json['alertType'],
      message: json['message'],
      vehicleNumber: json['vehicleNumber'],
      isRead: json['isRead'],
      priority: json['priority'] ?? "LOW",
      createdTime: json['createdTime'],
    );
  }
}