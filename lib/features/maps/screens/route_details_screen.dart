/// ===============================================================
/// GOOGLE MAPS STYLE ROUTE DETAILS SCREEN
/// PREMIUM START ↔ END BUTTON VERSION
/// ===============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:smartnav/screens/routes/widgets/trip_map_preview.dart';
import 'package:smartnav/features/maps/widgets/arrival_alert_dialog.dart';
import 'package:smartnav/screens/navigation/last_mile_screen.dart';
import 'package:smartnav/features/maps/widgets/start_trip_dialog.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:smartnav/models/route_progress_model.dart';
import 'package:smartnav/services/route_progress_service.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/saved_route_model.dart';
import '../../../services/saved_route_api_service.dart';

class RouteDetailsScreen extends StatefulWidget {

  final String vehicleNumber;
  final String busName;
  final String source;
  final String destination;
  final String status;
  final String departureTime;
  final String arrivalTime;
  final int duration;
final double fare;
final int transferCount;
final double walkingDistance;
  final String transportMode;
  final bool isFromSavedRoute;

  const RouteDetailsScreen({
    super.key,
    required this.vehicleNumber,
    required this.busName,
    required this.source,
    required this.destination,
    required this.status,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.fare,
    required this.transferCount,
    required this.walkingDistance,
    required this.transportMode,
    this.isFromSavedRoute = false,
  });

  @override
  State<RouteDetailsScreen> createState() =>
      _RouteDetailsScreenState();
}

class _RouteDetailsScreenState
    extends State<RouteDetailsScreen> {

  /// ===============================================================
  /// START / END STATE
  /// ===============================================================

  bool isNavigationStarted = false;

  /// ===============================================================
  /// COLORS
  /// ===============================================================

  static const Color green = Color(0xFF008000);
  static const Color googleMapRed = Color(0xFFE94235);
  
  List<dynamic> stops = [];
  bool isLoadingStops = true;

  Timer? timer;

  int currentStopIndex = -1;

  bool arrivalAlertShown = false;

  bool destinationReached = false;

  int remainingMinutes = 15;
  RouteProgressModel? progress;

  final RouteProgressService routeProgressService = RouteProgressService();

  bool isSaved = false;

  @override
void initState() {
  super.initState();

  loadStops();
  loadProgress();

  isSaved = false;
}
  Future<void> loadStops() async {

    print("LOAD STOPS CALLED");
    final response = await http.get(

      Uri.parse(
        "http://127.0.0.1:8081/api/bus-stops/${widget.vehicleNumber}"
      ),

    );

    print("STATUS = ${response.statusCode}");
    print("BODY = ${response.body}");

    if (response.statusCode == 200) {

      setState(() {

        stops = jsonDecode(response.body);
        isLoadingStops = false;

      });

    }
  }

  Future<void> loadProgress() async {


    progress = await routeProgressService.getProgress(widget.vehicleNumber);
    print("ETA = ${progress?.etaMinutes}");
    print("Current Stop = ${progress?.currentStop}");
    print("Remaining Stops = ${progress?.stopsRemaining}");
    if (!mounted) return;

    setState(() {

      bool isLoadingProgress = false;

    });
  } 


  @override
  Widget build(BuildContext context) {
    print(widget.vehicleNumber);
    return Scaffold(
      backgroundColor: Colors.white,

      body: Stack(
        children: [

          /// =====================================================
          /// MAP BACKGROUND
          /// =====================================================
        Positioned.fill(
          child: TripMapPreview(
            vehicleNumber: widget.vehicleNumber,
          ),
        ),

          /// =====================================================
          /// TOP BAR
          /// =====================================================
          SafeArea(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),

              child: Row(
                children: [

                  /// BACK BUTTON
                  GestureDetector(

                    onTap: () {
                      Navigator.pop(context);
                    },

                    child: floatingButton(
                      const Icon(
                        Icons.arrow_back,
                        size: 18,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  /// BUS CHIP
                  Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius:
                      BorderRadius.circular(40),

                      boxShadow: [
                        BoxShadow(
                          color:
                          Colors.black.withOpacity(.06),

                          blurRadius: 18,
                        ),
                      ],
                    ),

                    child: Row(
                      children: [

                        const Icon(
                          Icons.directions_bus,
                          color: green,
                          size: 15,
                        ),

                        const SizedBox(width: 8),

                        Text(
                          widget.vehicleNumber,

                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// =====================================================
          /// DRAGGABLE SHEET
          /// =====================================================
          DraggableScrollableSheet(

            initialChildSize: .78,
            minChildSize: .11,
            maxChildSize: .87,

            snap: true,
            snapSizes: const [.78, .87],

            builder: (context, controller) {

              return Container(

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                  const BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),

                  boxShadow: [
                    BoxShadow(
                      color:
                      Colors.black.withOpacity(.10),

                      blurRadius: 20,
                    ),
                  ],
                ),

                child: ListView(

                  controller: controller,

                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 10,
                    bottom: 24,
                  ),

                  children: [

                    /// HANDLE
                    Center(
                      child: Container(
                        width: 48,
                        height: 5,

                        decoration: BoxDecoration(
                          color:
                          Colors.grey.shade300,

                          borderRadius:
                          BorderRadius.circular(30),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// =====================================================
                    /// START LOCATION
                    /// =====================================================
                    timelineRow(
                      icon: const Icon(
                        Icons.location_on,
                        color: green,
                        size: 24,
                      ),

                      lineAfter:
                      dottedLine(40),

                      child: routeTitle(
                        widget.source,
                        "Tamil Nadu, India",
                        "5:24 pm",
                      ),
                    ),

                    /// =====================================================
                    /// WALK
                    /// =====================================================
                    timelineRow(
                      icon: walkNode(),

                      lineAfter:
                      dottedLine(40),

                      child: walkTile(
                        "Walk 2 min (120 m)",
                      ),
                    ),

                    /// =====================================================
                    /// BUS
                    /// =====================================================
                    timelineRow(
                      icon: busNode(),

                      lineAfter:
                      greenLine(90),

                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          routeHeader(
                            widget.busName,
                            "5:25 pm",
                          ),

                          const SizedBox(height: 14),

                          Row(
                            children: [

                              Container(
                                padding:
                                const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),

                                decoration: BoxDecoration(
                                  color:
                                  const Color(0xFFEAF6EE),

                                  borderRadius:
                                  BorderRadius.circular(12),
                                ),

                                child: Text(
                                  widget.vehicleNumber,

                                  style:
                                  GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight:
                                    FontWeight.w600,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              Text(
                                "To ${widget.destination}",

                                style:
                                GoogleFonts.inter(
                                  fontSize: 14,
                                  color:
                                  const Color(0xFF6F6F6F),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          Text(
                            widget.status,

                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: green,
                              fontWeight:
                              FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 20),

                          floatingCrowdCard(),

                          const SizedBox(height: 22),
                        ],
                      ),
                    ),

                    /// =====================================================
                    /// RIDE TITLE
                    /// =====================================================
                    timelineRow(
                      icon: stopDot(),

                      lineAfter:
                      greenLine(36),

                      child: rideTitle(),
                    ),

                    /// =====================================================
                    /// STOPS
                    /// =====================================================
                    if (isLoadingStops)
  const Center(
    child: CircularProgressIndicator(),
  )
else
  ...stops.asMap().entries.map((entry) {

    int index = entry.key;
    var stop = entry.value;

    return timelineRow(

      icon:
        index < currentStopIndex
          ? completedStopNode()
          : index == currentStopIndex
            ? busNode()
            : stopDot(),

      lineAfter: greenLine(36),

      child: stopTile(
        stop['stopName'],
        stop['arrivalTime'],
        index < currentStopIndex,
      ),

    );

}).toList(),

                    /// =====================================================
                    /// FINAL WALK
                    /// =====================================================
                    timelineRow(
                      icon: walkNode(),

                      lineAfter:
                      dottedLine(26),

                      child: Padding(
                        padding:
                        const EdgeInsets.only(
                          bottom: 14,
                        ),

                        child:
                        walkTimeTile(),
                      ),
                    ),

                    /// =====================================================
                    /// DESTINATION
                    /// =====================================================
                    timelineRow(
                      icon: const Icon(
                        Icons.location_on,
                        color: googleMapRed,
                        size: 22,
                      ),

                      child: routeTitle(
                        widget.destination,
                         "Tamil Nadu, India",
                        "5:40 pm",
                      ),
                    ),

                    const SizedBox(height: 22),

                    /// =====================================================
                    /// ARRIVAL CARD
                    /// =====================================================
                    arrivalCard(),

                    const SizedBox(height: 14),

/// =====================================================
/// SAVE SHARE
/// =====================================================
Row(
  children: [

    Expanded(
      child: bottomButton(
        isSaved
            ? Icons.bookmark
            : Icons.bookmark_border,
        isSaved
            ? "Saved"
            : "Save",
        () async {

          final prefs =
              await SharedPreferences.getInstance();

          final userId =
              prefs.getInt("userId");

          if (userId == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Color(0xFF0B5D1E),
                content: Text(
                  "User not found",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
            return;
          }

          final route = SavedRouteModel(
            userId: userId,
            vehicleNumber: widget.vehicleNumber,
            busName: widget.busName,
            source: widget.source,
            destination: widget.destination,
            departureTime: widget.departureTime,
            arrivalTime: widget.arrivalTime,
            duration: widget.duration,
            fare: widget.fare,
            transportMode: widget.transportMode,
          );

          final success =
              await SavedRouteApiService.saveRoute(route);

          if (success) {

  setState(() {
    isSaved = true;
  });

  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    backgroundColor: const Color(0xFF0B5D1E),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    content: const Row(
      children: [
        Icon(
          Icons.check_circle,
          color: Colors.white,
        ),
        SizedBox(width: 10),
        Text(
          "Route saved successfully",
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  ),
);

          } else {

            ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    backgroundColor: Colors.orange.shade700,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    content: const Row(
      children: [
        Icon(
          Icons.info_outline,
          color: Colors.white,
        ),
        SizedBox(width: 10),
        Text(
          "Route already exists",
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  ),
);

          }
        },
      ),
    ),

    const SizedBox(width: 12),

    Expanded(
      child: bottomButton(
        Icons.share,
        "Share",
        () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Color(0xFF0B5D1E),
              content: Text(
                "Share Clicked",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    ),

  ],
),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void startJourney() {

  timer = Timer.periodic(
    const Duration(seconds: 5),
    (_) {

      if (currentStopIndex < stops.length - 1) {

        setState(() {
          currentStopIndex++;
          remainingMinutes = ((stops.length-1)-currentStopIndex)*3;
        });

        /// Final stop-ku munnaadi alert
        if(remainingMinutes <= 5 && !arrivalAlertShown){

          arrivalAlertShown = true;

          showArrivalAlertDialog(context);

        }

      }

      else {

  timer?.cancel();

  if (!destinationReached) {

    destinationReached = true;

    Future.delayed(
      const Duration(seconds: 2),
      () {

        if (!mounted) return;

        showDialog(
  context: context,
  barrierDismissible: false,
  builder: (_) => Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(28),
    ),
    child: Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          const Text(
            "🎉",
            style: TextStyle(fontSize: 42),
          ),

          const SizedBox(height: 18),

          Text(
            "You have arrived at",
            style: GoogleFonts.inter(
              fontSize: 18,
              color: Colors.grey.shade700,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            widget.destination,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {

                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LastMileScreen(),
                  ),
                );

              },
              child: Text(
                "Continue",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

        ],
      ),
    ),
  ),
);

      },

    );

  }
  else {

  timer?.cancel();

  setState(() {
    isNavigationStarted = false;
  });

}

}

    },

  );

}

  @override
void dispose() {

  timer?.cancel();

  super.dispose();

}

  /// ===============================================================
  /// ARRIVAL CARD
  /// ===============================================================

  Widget arrivalCard() {

    return Container(
      width: double.infinity,

      padding:
      const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 14,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(24),

        border: Border.all(
          color:
          const Color(0xFFE8E8E8),
        ),
      ),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.center,

        children: [

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              mainAxisSize:
              MainAxisSize.min,

              children: [

                Text(
                  "$remainingMinutes min",

                  style:
                  GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.w700,
                    color: green,
                  ),
                ),

                const SizedBox(height: 4),

                RichText(
                  text: TextSpan(
                    children: [

                      TextSpan(
                        text: "Arrive at ",

                        style:
                        GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),

                      TextSpan(
                        text: remainingMinutes == 0 ? "Reached"
                          : "${DateTime.now().hour}:${DateTime.now().minute}",

                        style:
                        GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight:
                          FontWeight.w600,

                          color:
                          googleMapRed,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// =====================================================
          /// START ↔ END BUTTON
          /// =====================================================
          GestureDetector(

           onTap: () async {

  if (!isNavigationStarted) {

    final shouldStart =
        await showStartTripDialog(context);

    if (shouldStart == true) {

  setState(() {
    isNavigationStarted = true;
  });

  startJourney();

}
  }

  else {
    timer?.cancel();
    setState(() {
      isNavigationStarted = false;
    });

    showDialog(

  context: context,

  builder: (_) => AlertDialog(

    title: const Text(
      "Destination Reached 🎉",
    ),

    content: Text(
      "You have arrived at ${widget.destination}",
    ),

    actions: [

      TextButton(

        onPressed: () {

          Navigator.pop(context);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const LastMileScreen(),
            ),
          );

        },

        child: const Text(
          "Continue",
        ),

      ),

    ],

  ),

);
  }
},

            child: Container(

              height: 46,
              width: 112,

              decoration: BoxDecoration(

                borderRadius:
                BorderRadius.circular(24),

                gradient: LinearGradient(

                  colors: isNavigationStarted

                      ? [
                    const Color(0xFFC62828),
                    const Color(0xFFE94235),
                  ]

                      : [
                    const Color(0xFF006400),
                    const Color(0xFF008000),
                  ],
                ),

                boxShadow: [

                  BoxShadow(
                    color:
                    Colors.black.withOpacity(.10),

                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [

                  Container(

                    width: 18,
                    height: 18,

                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),

                    child: Center(

                      child: Icon(
                        isNavigationStarted
                            ? Icons.stop
                            : Icons.navigation,

                        size: 10,

                        color: isNavigationStarted
                            ? Colors.red
                            : green,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Text(

                    isNavigationStarted
                        ? "End"
                        : "Start",

                    style:
                    GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight:
                      FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget timelineRow({
    required Widget icon,
    required Widget child,
    Widget? lineAfter,
  }) {

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          SizedBox(
            width: 34,

            child: Column(
              children: [

                SizedBox(
                  width: 34,
                  child: Center(
                    child: icon,
                  ),
                ),

                if (lineAfter != null)
                  lineAfter,
              ],
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }

  Widget greenLine(double height) {

    return Container(
      width: 3,
      height: height,
      color: green,
    );
  }

  Widget dottedLine(double height) {

    return SizedBox(
      height: height,

      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.spaceEvenly,

        children: List.generate(
          6,

              (_) => Container(
            width: 4,
            height: 4,

            decoration: BoxDecoration(
              color: Colors.grey,

              borderRadius:
              BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }

  Widget stopDot() {

    return Container(
      width: 16,
      height: 16,

      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,

        border: Border.all(
          color: green,
          width: 3,
        ),
      ),
    );
  }

  Widget walkNode() {

    return Container(
      width: 32,
      height: 32,

      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,

        border: Border.all(
          color:
          const Color(0xFFE2E2E2),
        ),
      ),

      child: const Center(
        child: Icon(
          Icons.directions_walk,
          size: 15,
        ),
      ),
    );
  }

  Widget busNode() {

    return Container(
      width: 44,
      height: 44,

      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,

        border: Border.all(
          color: green,
          width: 2,
        ),
      ),

      child: const Center(
        child: Icon(
          Icons.directions_bus,
          color: green,
          size: 18,
        ),
      ),
    );
  }

  Widget completedStopNode() {

  return Container(
    width: 22,
    height: 22,

    decoration: const BoxDecoration(
      color: green,
      shape: BoxShape.circle,
    ),

    child: const Icon(
      Icons.check,
      size: 14,
      color: Colors.white,
    ),
  );
}

  Widget floatingButton(Widget child) {

    return Container(
      width: 46,
      height: 46,

      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,

        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withOpacity(.06),

            blurRadius: 18,
          ),
        ],
      ),

      child: child,
    );
  }

  Widget routeTitle(
      String title,
      String subtitle,
      String time,
      ) {

    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,

      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              Text(
                title,

                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight:
                  FontWeight.w600,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                subtitle,

                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),

        Text(
          time,

          style: GoogleFonts.inter(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget routeHeader(
      String title,
      String time,
      ) {

    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,

      children: [

        Text(
          title,

          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight:
            FontWeight.w600,
          ),
        ),

        Text(
          time,

          style: GoogleFonts.inter(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget walkTile(String title) {

    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,

      children: [

        Text(
          title,

          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight:
            FontWeight.w500,
          ),
        ),

        const Icon(
          Icons.chevron_right,
          color: Colors.grey,
          size: 18,
        ),
      ],
    );
  }

  Widget walkTimeTile() {

    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,

      children: [

        Text(
          "Walk 1 min (50 m)",

          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight:
            FontWeight.w500,
          ),
        ),

        Row(
          children: [

            Text(
              "5:35 pm",

              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),

            const SizedBox(width: 4),

            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
              size: 18,
            ),
          ],
        ),
      ],
    );
  }

  Widget stopTile(
  String title,
  String time,
  bool completed,
) {

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,

    children: [

      Text(
        title,

        style: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: completed
              ? Colors.grey
              : Colors.black,
        ),
      ),

      Text(
        time,

        style: GoogleFonts.inter(
          fontSize: 12,
          color: completed
              ? Colors.grey
              : Colors.black54,
        ),
      ),
    ],
  );
}

  Widget rideTitle() {

  return Row(

    mainAxisAlignment: MainAxisAlignment.spaceBetween,

    children: [

      Text(

        destinationReached
            ? "Destination reached"
            : "${(stops.length - 1) - currentStopIndex} stops left • $remainingMinutes min",

        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF188038),
        ),
      ),

      const Icon(
        Icons.keyboard_arrow_up,
        size: 18,
        color: Colors.grey,
      ),

    ],
  );
}

  Widget floatingCrowdCard() {

    return Container(

      padding:
      const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color:
        const Color(0xFFF8F8F8),

        borderRadius:
        BorderRadius.circular(24),

        border: Border.all(
          color:
          const Color(0xFFEDEDED),
        ),
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Text(
            "WHAT'S IT LIKE ON BOARD?",

            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight:
              FontWeight.w600,
              color:
              Colors.grey.shade700,
            ),
          ),

          const SizedBox(height: 14),

          Row(
            children: [

              Expanded(
                child: infoChip(
                  Icons.groups,
                  "Crowded",
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: infoChip(
                  Icons.thermostat,
                  "Warm",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget infoChip(
      IconData icon,
      String text,
      ) {

    return Container(
      padding:
      const EdgeInsets.symmetric(
        vertical: 12,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        border: Border.all(
          color:
          const Color(0xFFD8EFD9),
        ),

        borderRadius:
        BorderRadius.circular(18),
      ),

      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.center,

        children: [

          Icon(
            icon,
            size: 14,
            color: green,
          ),

          const SizedBox(width: 5),

          Text(
            text,

            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight:
              FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomButton(
  IconData icon,
  String text,
  VoidCallback onTap,
) {

  return Material(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(20),

    child: InkWell(
      borderRadius: BorderRadius.circular(20),

      splashColor: const Color(0xFFE8F5E9),
      highlightColor: const Color(0xFFE8F5E9),

      onTap: onTap,

      child: Ink(
        height: 50,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE8E8E8),
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

           Icon(
  icon,
  color: text == "Saved"
      ? green
      : green,
),

            const SizedBox(width: 6),

           Text(
  text,
  style: GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: text == "Saved"
        ? green
        : Colors.black,
  ),
),
          ],
        ),
      ),
    ),
  );
}
    }