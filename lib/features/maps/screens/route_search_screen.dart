  import 'package:flutter/material.dart';

  import 'package:smartnav/features/maps/data/static_route_data.dart';

  import 'package:smartnav/features/maps/widgets/bottom_nav_bar.dart';

  import 'package:smartnav/features/maps/widgets/departure_time_dialog.dart';

  import 'package:smartnav/features/maps/widgets/filter_options_dialog.dart';

  import 'package:smartnav/features/maps/widgets/floating_route_search_bar.dart';

  import 'package:smartnav/features/maps/widgets/route_card.dart';

  import 'package:smartnav/features/maps/models/route_card_data.dart';

  import 'package:smartnav/features/maps/widgets/transport_button.dart';

  import 'package:smartnav/features/maps/widgets/transport_preferences_dialog.dart';

  import 'package:smartnav/features/maps/screens/route_details_screen.dart';

  import 'package:smartnav/theme/smart_nav_theme.dart';

  import 'package:smartnav/screens/routes/widgets/trip_map_preview.dart';

  import 'package:smartnav/features/maps/widgets/direction_preview_card.dart';

  import 'dart:convert';
  import 'package:http/http.dart' as http;
  import 'package:intl/intl.dart';
  import 'package:smartnav/features/maps/services/osrm_service.dart';
  import 'package:smartnav/features/maps/models/direction_data.dart';

  class RouteSearchScreen extends StatefulWidget {
    const RouteSearchScreen({super.key});

    @override
    State<RouteSearchScreen> createState() =>
        _RouteSearchScreenState();
  }

  class _RouteSearchScreenState
      extends State<RouteSearchScreen> {

    int _bottomNavIndex = 1;

    /// 0 = Car
    /// 1 = Bike
    /// 2 = Bus
    /// 3 = Walk
    int _selectedTransportIndex = 2;
    String selectedFilter = "Best route";
    List<String> selectedModes = [];

    List<dynamic> buses = [];
    bool isLoading = true;
    String selectedLeaveTime = "4:50 PM";
    bool isArriveSelected = false;
    String sourceLocation = "Tenkasi";
    String destinationLocation = "Tirunelveli";
    DirectionData? directionData;
    bool isLoadingRoute = false;

    @override
    void initState() {
      super.initState();
      loadBuses();
      loadDirection();
    }

    Future<void> loadBuses() async {

      final response = await http.get(
        Uri.parse('http://127.0.0.1:8081/api/buses'),
      );

      print("STATUS CODE = ${response.statusCode}");
      print("BODY = ${response.body}");

      if (response.statusCode == 200) {

        setState(() {

          buses = jsonDecode(response.body);
          print("TOTAL BUSES = ${buses.length}");
          isLoading = false;

        });

      }

    }

    Future<void> loadDirection() async {

    setState(() {

      isLoadingRoute = true;

    });

    try {

      directionData =
          await OsrmService().getRoute(

        8.9598,
        77.3152,

        8.7139,
        77.7567,

      );

    } catch (e, stackTrace) {
      print("OSRM ERROR: $e");
      print(stackTrace);
    }

    setState(() {

      isLoadingRoute = false;

    });

  }

    /// DYNAMIC ROUTE CARDS
    List<Widget> _buildRouteCards() {

  //     /// CAR / BIKE / WALK
  if (_selectedTransportIndex != 2 && isLoadingRoute) {

    return const [

      Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: CircularProgressIndicator(),
        ),
      ),

    ];

  }

  /// CAR
  if (_selectedTransportIndex == 0) {

    return [

      DirectionPreviewCard(
        transportIndex: 0,
        source: sourceLocation,
        destination: destinationLocation,
        directionData: directionData,
      ),

    ];

  }

  /// BIKE
  if (_selectedTransportIndex == 1) {

    return [

      DirectionPreviewCard(
        transportIndex: 1,
        source: sourceLocation,
        destination: destinationLocation,
        directionData: directionData,
      ),

    ];

  }

      
      /// BUS
  if (_selectedTransportIndex == 2) {

    print(buses);
    print("SELECTED FILTER = $selectedFilter");

    List<dynamic> filteredBuses = [...buses];

  /// Preferred modes filter
  if (selectedModes.isNotEmpty) {

    filteredBuses = filteredBuses.where((bus) {

      String mode = bus['transportMode'] ?? "Bus";

      return selectedModes.contains(mode);

    }).toList();

  }

  /// Leave time filter
  filteredBuses = filteredBuses.where((bus) {

    final busTime = DateFormat(
    "hh:mm a",
  ).parse(

    isArriveSelected
        ? bus['arrivalTime']
        : bus['departureTime'],

  );

    final selectedTime = DateFormat(
      "hh:mm a",
    ).parse(
      selectedLeaveTime,
    );

    return !busTime.isBefore(
      selectedTime,
    );

  }).toList();

    // Best route
    if (selectedFilter == "Best route") {
      print("BEST ROUTE");

    filteredBuses.sort(
      (a, b) =>
          (a['duration'] ?? 0)
              .compareTo(
                b['duration'] ?? 0,
              ),
    );

  }

    // Fewer transfers
    if (selectedFilter == "Fewer transfers") {
      print("FEWER TRANSFERS");
      //filteredBuses = filteredBuses.reversed.toList();

    filteredBuses.sort(
      (a, b) =>
          (a['transferCount'] ?? 0)
              .compareTo(
                b['transferCount'] ?? 0,
              ),
    );

  }

    // Less walking
  if (selectedFilter == "Less walking") {
    print("LESS WALKING");
    //filteredBuses.shuffle();

    filteredBuses.sort(
      (a, b) =>
          (a['walkingDistance'] ?? 0)
              .compareTo(
                b['walkingDistance'] ?? 0,
              ),
    );

  }

    return filteredBuses.map<Widget>((bus) {

      return Column(
        children: [

          RouteCard(
            data: RouteCardData(
              type: RouteCardType.busOnly,

              busBadges: [
                bus['busNumber'],
              ],

              routeName: bus['busName'],

              duration: "${bus['duration']} min",

              timeRange: "${bus['departureTime']} - ${bus['arrivalTime']}",

              scheduleInfo:
                  "${bus['source']} → ${bus['destination']}",

              price: "₹${bus['fare']}",
            ),
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RouteDetailsScreen(
                    vehicleNumber: bus['busNumber'],
                    busName: bus['busName'],
                    source: bus['source'],
                    destination: bus['destination'],
                    status: bus['status'],
                    departureTime: bus['departureTime'],
                    arrivalTime: bus['arrivalTime'],
                    duration: bus['duration'],
                    fare: bus['fare'],
                    transferCount: bus['transferCount'],
                    walkingDistance: bus['walkingDistance'],
                    transportMode: bus['transportMode'],
                  ),
                ),
              );

            },
          ),

          const SizedBox(height: 18),

        ],
      );

    }).toList();
  }

  /// WALK
  if (_selectedTransportIndex == 3) {

    return [

      DirectionPreviewCard(
        transportIndex: 3,
        source: sourceLocation,
        destination: destinationLocation,
        directionData: directionData,
      ),

    ];

  }
      return [];
    }

    @override
    Widget build(BuildContext context) {

      return Theme(

        data: SmartNavTheme.light,

        child: Scaffold(
          

          backgroundColor:
              SmartNavColors.background,

          
          body: Stack(

            fit: StackFit.expand,

            children: [

              /// MAP

  Positioned.fill(
            child: TripMapPreview(
              vehicleNumber: "147",
            ),
          ),

  /// SEARCH BAR
              
              /// SEARCH BAR
              Positioned(

                top:
                    MediaQuery.of(context)
                            .padding
                            .top +
                        12,

                left: 14,
                right: 14,

                child:
                    const FloatingRouteSearchBar(),
              ),

              /// DRAGGABLE SHEET
              DraggableScrollableSheet(

                initialChildSize: 0.36,

                minChildSize: 0.27,

                maxChildSize: 0.78,

                expand: true,
                snap: true,
                snapSizes: const [0.45, 0.78],

            

                shouldCloseOnMinExtent:
                    false,

                builder:
                    (context, scrollController) {

                  return Container(

                    decoration:
                        BoxDecoration(

                      color:
                          SmartNavColors.surface,

                      borderRadius:
                          const BorderRadius.vertical(
                        top: Radius.circular(28),
                      ),

                      boxShadow: [

    BoxShadow(

      color:
          Colors.black.withOpacity(
        0.05,
      ),

      blurRadius: 10,

      offset:
          const Offset(0, 4),
    ),
  ],
                        ),
                    child:
                        CustomScrollView(
                          keyboardDismissBehavior:
      ScrollViewKeyboardDismissBehavior.onDrag,

                      controller:
                          scrollController,
  physics:
      const ClampingScrollPhysics(),                 
      slivers: [

                        /// HANDLE
                        SliverToBoxAdapter(

                          child: Column(

                            children: [

                              const SizedBox(
                                height: 8,
                              ),

                              Center(
                                child: Container(

                                  width: 42,
                                  height: 5,

                                  decoration:
                                      BoxDecoration(
                                    color: Colors.grey.shade300,

                                    borderRadius:
                                        BorderRadius.circular(
                                      999,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        ),

                        /// HEADER
                        SliverToBoxAdapter(

                          child: Padding(

                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),

                            child: Row(

                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,

                              children: [

                                Text(

                                  'Public transport',

                                  style:
                                      SmartNavTextStyles
                                          .headlineMd,
                                ),

                                Row(

                                  children: [

                                    /// SHARE
                                    _SheetIconButton(

                                      icon:
                                          Icons.share,

                                      onTap: () {

                                        ScaffoldMessenger.of(
                                                context)
                                            .showSnackBar(

                                          const SnackBar(
                                            content: Text(
                                              'Share clicked',
                                            ),
                                          ),
                                        );
                                      },
                                    ),

                                    const SizedBox(
                                      width: 8,
                                    ),

                                    /// CLOSE
                                    _SheetIconButton(

                                      icon:
                                          Icons.close,

                                      onTap: () {

                                        if (Navigator.canPop(
                                            context)) {

                                          Navigator.pop(
                                              context);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SliverToBoxAdapter(

                          child: SizedBox(
                            height: 14,
                          ),
                        ),

                        /// STICKY HEADER
                        SliverPersistentHeader(

                          pinned: true,

                          delegate:
                              _StickyHeaderDelegate(

                            child: Container(

                              color:
                                  SmartNavColors
                                      .surface,

                              child: Column(

                                children: [

                                  /// TRANSPORT BUTTONS
                                  SizedBox(

                                    height: 86,

                                    child:
                                        ListView.separated(

                                      padding:
                                          const EdgeInsets.symmetric(
                                        horizontal:
                                            20,
                                      ),

                                      scrollDirection:
                                          Axis.horizontal,

                                      itemCount:
                                          StaticRouteData
                                              .transportModes
                                              .length,

                                      separatorBuilder:
                                          (_, __) =>
                                              const SizedBox(
                                        width: 14,
                                      ),

                                      itemBuilder:
                                          (context, i) {

                                        return TransportButton(

                                          icon:
                                              StaticRouteData
                                                  .transportModes[i]
                                                  .icon,

                                          label:
                                              StaticRouteData
                                                  .transportModes[i]
                                                  .label,

                                          isSelected:
                                              i ==
                                                  _selectedTransportIndex,

                                          iconFilled:
                                              StaticRouteData
                                                  .transportModes[i]
                                                  .iconFilled,

                                          onTap: () {

                                            setState(() {

                                              _selectedTransportIndex = i;

                                            });

                                          },
                                        );
                                      },
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 8,
                                  ),

                                  /// FILTER CHIPS
                                  if (_selectedTransportIndex == 2)
                                  Padding(

                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),

                                    child: SingleChildScrollView(

                                      scrollDirection: Axis.horizontal,

                                      child: Row(

                                        children: [
                                          _InteractiveFilterChip(
    label: isArriveSelected
      ? 'Arrive $selectedLeaveTime'
      : 'Leave $selectedLeaveTime',
    onTap: () async {

      final result = await showDepartureTimeDialog(
        context,
        DateTime.now(),
      );

      if (result != null) {

        setState(() {

          selectedLeaveTime = DateFormat(
            "hh:mm a",
          ).format(
            result["time"],
          );

          isArriveSelected =
              result["isArrive"];

        });

      }

    },
  ),

  const SizedBox(
    width: 10,
  ),

  _InteractiveFilterChip(
    label: selectedModes.isEmpty
      ? 'Preferred modes'
      : selectedModes.join(", "),

    onTap: () async {

      final result =
          await showTransportPreferencesDialog(
        context,
        selectedModes,
      );

      if (result != null) {

        setState(() {

          selectedModes = result;

        });

      }

    },
  ),

  const SizedBox(
    width: 10,
  ),

  _InteractiveFilterChip(
    label: selectedFilter,

    onTap: () async {

      final result =
          await showFilterOptionsDialog(
        context,
      );

      if (result != null) {

        setState(() {

          selectedFilter = result;

        });

      }

    },
  ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 14,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        /// ROUTE LIST
                        SliverPadding(

                          padding:
                              const EdgeInsets.fromLTRB(
                            20,
                            16,
                            20,
                            140,
                          ),

                          sliver:
                              SliverList(

                            delegate:
                                SliverChildListDelegate(
                              _buildRouteCards(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              /// BOTTOM NAV
              Positioned(

                left: 0,
                right: 0,

                bottom:
                    MediaQuery.of(context)
                        .padding
                        .bottom,

                child:
                    SmartNavBottomBar(

                  selectedIndex:
                      _bottomNavIndex,

                  onItemSelected:
                      (index) {

                    setState(() {

                      _bottomNavIndex =
                          index;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        
      );
    }
  }

  /// STICKY HEADER
  class _StickyHeaderDelegate
      extends SliverPersistentHeaderDelegate {

    final Widget child;

    _StickyHeaderDelegate({
      required this.child,
    });

    @override
    double get minExtent => 145;

    @override
    double get maxExtent => 145;

    @override
    Widget build(

      BuildContext context,

      double shrinkOffset,

      bool overlapsContent,
    ) {

      return child;
    }

    @override
    bool shouldRebuild(
      covariant
      SliverPersistentHeaderDelegate
          oldDelegate,
    ) {

      return true;
    }
  }

  /// FILTER CHIP
  class _InteractiveFilterChip extends StatelessWidget {

    const _InteractiveFilterChip({
      required this.label,
      required this.onTap,
      super.key,
    });

    final String label;
    final VoidCallback onTap;

    @override
    Widget build(BuildContext context) {

      return Material(

        color: Colors.transparent,

        child: InkWell(

          borderRadius: BorderRadius.circular(12),

          onTap: onTap,

          child: Container(

            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 7,
            ),

            decoration: BoxDecoration(

              color: SmartNavColors.surfaceContainer,

              borderRadius: BorderRadius.circular(
                12,
              ),

              border: Border.all(
                color: SmartNavColors.outlineVariant,
              ),
            ),

            child: Row(

              mainAxisSize: MainAxisSize.min,

              children: [

                Text(

                  label,

                  style: SmartNavTextStyles.labelLg.copyWith(
                    fontSize: 12,
                  ),
                ),

                const SizedBox(
                  width: 2,
                ),

                const Icon(
                  Icons.arrow_drop_down,
                  size: 17,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  /// ICON BUTTON
  class _SheetIconButton extends StatelessWidget {

    final IconData icon;

    final VoidCallback onTap;

    const _SheetIconButton({

      required this.icon,

      required this.onTap,

      super.key,
    });

    @override
    Widget build(BuildContext context) {

      return Material(

        color: SmartNavColors.surfaceContainer,

        shape: const CircleBorder(),

        child: InkWell(

          customBorder: const CircleBorder(),

          onTap: onTap,

          child: SizedBox(

            width: 38,
            height: 38,

            child: Icon(

              icon,

              size: 22,

              color: SmartNavColors.onSurfaceVariant,

            ),
          ),
        ),
      );
    }
  }