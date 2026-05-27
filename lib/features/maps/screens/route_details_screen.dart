/// ===============================================================
/// GOOGLE MAPS STYLE ROUTE DETAILS SCREEN
/// PREMIUM START ↔ END BUTTON VERSION
/// ===============================================================

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:smartnav/features/maps/services/notification_service.dart';
class RouteDetailsScreen extends StatefulWidget {

  const RouteDetailsScreen({super.key});

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

  static const Color green =
  Color(0xFF008000);

  static const Color googleMapRed =
  Color(0xFFE94235);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: Stack(
        children: [

          /// =====================================================
          /// MAP BACKGROUND
          /// =====================================================
          Positioned.fill(
            child: FlutterMap(

              options: const MapOptions(

                initialCenter: LatLng(
                  8.9595,
                  77.3152,
                ),

                initialZoom: 13,
              ),

              children: [

                TileLayer(
                  urlTemplate:
                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',

                  userAgentPackageName:
                  'com.smartnav.app',
                ),
              ],
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
                          "147C",

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
            minChildSize: .14,
            maxChildSize: .92,

            snap: true,
            snapSizes: const [.78, .92],

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
                        "Tenkasi Junction",
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
                            "New Bus Stand",
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
                                  "147C",

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
                                "To Shencottah",

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
                            "Scheduled",

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
                    timelineRow(
                      icon: stopDot(),

                      lineAfter:
                      greenLine(36),

                      child: stopTile(
                        "Anna Bus Stop",
                        "5:27 pm",
                      ),
                    ),

                    timelineRow(
                      icon: stopDot(),

                      lineAfter:
                      greenLine(36),

                      child: stopTile(
                        "Market Stop",
                        "5:31 pm",
                      ),
                    ),

                    timelineRow(
                      icon: stopDot(),

                      lineAfter:
                      dottedLine(34),

                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          stopTile(
                            "Thirumalai Nagar Stop",
                            "5:34 pm",
                          ),

                          const SizedBox(height: 12),

                          Text(
                            "and 9 more stops",

                            style:
                            GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

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
                        "Thirumalai Kovil",
                        "Tenkasi, Tamil Nadu",
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
                            Icons.bookmark_border,
                            "Save",
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: bottomButton(
                            Icons.share,
                            "Share",
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
                  "31 min",

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
                        text: "5:55 pm",

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

  setState(() {

    isNavigationStarted =
    !isNavigationStarted;
  });

  await NotificationService
      .showTestNotification();
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
      ) {

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

  Widget rideTitle() {

    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,

      children: [

        Text(
          "Ride 12 stops (15 min)",

          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight:
            FontWeight.w600,
            color: green,
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
) {

  return Material(

    color: Colors.transparent,

    borderRadius:
    BorderRadius.circular(20),

    child: InkWell(

      borderRadius:
      BorderRadius.circular(20),

      splashColor:
      const Color(0xFFE8F5E9),

      highlightColor:
      const Color(0xFFE8F5E9),

      onTap: () {

        ScaffoldMessenger.of(context)
            .showSnackBar(

          SnackBar(

            backgroundColor: green,

            behavior:
            SnackBarBehavior.floating,

            content: Text(

              text == "Save"
                  ? "Saved"
                  : "Shared",

              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight:
                FontWeight.w500,
              ),
            ),

            duration:
            const Duration(seconds: 1),
          ),
        );
      },

      child: Ink(

        height: 50,

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
          BorderRadius.circular(20),

          border: Border.all(
            color:
            const Color(0xFFE8E8E8),
          ),
        ),

        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Icon(
              icon,
              color: green,
              size: 16,
            ),

            const SizedBox(width: 6),

            Text(
              text,

              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight:
                FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
    }