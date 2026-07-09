import '../models/bus_model.dart';

class BusService {
  static Future<List<BusModel>> getAllBuses() async {
    return [
      BusModel(vehicleNumber: "147C"),

      BusModel(vehicleNumber: "23A"),

      BusModel(vehicleNumber: "41B"),
    ];
  }
}
