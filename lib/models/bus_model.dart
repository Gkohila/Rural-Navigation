import 'package:smartnav/features/maps/models/route_card_data.dart';

class BusModel {

  final String vehicleNumber;

  BusModel({
    required this.vehicleNumber,
  });

  RouteCardData toRouteCardData() {

    return RouteCardData(
      type: RouteCardType.busOnly,
      duration: "31 min",
      timeRange: "5:24 pm - 5:55 pm",
      scheduleInfo: "Scheduled",
      price: "₹15",
      busBadges: [vehicleNumber],
    );

  }

}