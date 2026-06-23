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

import 'dart:convert';
import 'package:http/http.dart' as http;

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

  List<dynamic> buses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadBuses();
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

  /// DYNAMIC ROUTE CARDS
  List<Widget> _buildRouteCards() {

    /// CAR
    if (_selectedTransportIndex == 0) {

      return [

        RouteCard(
          data: StaticRouteData.routeCards[0],

          animationDelay: Duration.zero,

          onTap: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RouteDetailsScreen(
                  vehicleNumber: "",
                  busName: "",
                  source: "",
                  destination: "",
                  status: "",
                ),
              ),
            );

          },
        ),

        const SizedBox(
          height: 18,
        ),

        RouteCard(
          data: StaticRouteData.routeCards[1],

          animationDelay: const Duration(
            milliseconds: 60,
          ),

          onTap: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RouteDetailsScreen(
                  vehicleNumber: "",
                  busName: "",
                  source: "",
                  destination: "",
                  status: "",
                ),
              ),
            );

          },
        ),
      ];
    }

    
    /// BIKE
if (_selectedTransportIndex == 1) {

  return [

    RouteCard(
      data: StaticRouteData.routeCards[2],

      animationDelay: Duration.zero,

      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RouteDetailsScreen(
              vehicleNumber: "",
              busName: "",
              source: "",
              destination: "",
              status: "",
            ),
          ),
        );

      },
    ),

    const SizedBox(
      height: 18,
    ),

    RouteCard(
      data: StaticRouteData.routeCards[0],

      animationDelay: const Duration(
        milliseconds: 60,
      ),

      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RouteDetailsScreen(
              vehicleNumber: "",
              busName: "",
              source: "",
              destination: "",
              status: "",
            ),
          ),
        );

      },
    ),
  ];
}

    
    /// BUS
    if (_selectedTransportIndex == 2) {
      print(buses);
  return buses.map<Widget>((bus) {

    return Column(
  children: [

    RouteCard(
  data: RouteCardData(
    type: RouteCardType.busOnly,

    busBadges: [
      bus['busNumber'],
    ],

    routeName: bus['busName'],

    duration: "32 min",

    timeRange: "10:34 am - 11:05 am",

    scheduleInfo:
        "${bus['source']} → ${bus['destination']}",

    price: "₹9",
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
      ),
    ),
  );

}
),

    const SizedBox(height: 18),

  ],
);

  }).toList();

}

    /// WALK
return [

  RouteCard(
    data: StaticRouteData.routeCards[2],

    animationDelay: Duration.zero,

    onTap: () {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RouteDetailsScreen(
            vehicleNumber: "",
            busName: "",
            source: "",
            destination: "",
            status: "",
          ),
        ),
      );

    },
  ),
];
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

  child: const SizedBox(),
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
                                Padding(

                                  padding:
                                      const EdgeInsets.symmetric(
                                    horizontal:
                                        20,
                                  ),

                                  child:
                                      SingleChildScrollView(

                                    scrollDirection:
                                        Axis.horizontal,

                                    child: Row(

                                      children: [

                                        _InteractiveFilterChip(

                                          label:
                                              'Leave 4:50 PM',

                                          onTap:
                                              () async {

                                            await showDepartureTimeDialog(
                                              context,
                                              DateTime.now(),
                                            );
                                          },
                                        ),

                                        const SizedBox(
                                          width: 10,
                                        ),

                                        _InteractiveFilterChip(

                                          label:
                                              'Preferred modes',

                                          onTap:
                                              () async {

                                            await showTransportPreferencesDialog(
                                              context,
                                              [],
                                            );
                                          },
                                        ),

                                        const SizedBox(
                                          width: 10,
                                        ),

                                        _InteractiveFilterChip(

                                          label:
                                              'Filter by',

                                          onTap:
                                              () async {

                                            await showFilterOptionsDialog(
                                              context,
                                            );
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
class _InteractiveFilterChip
    extends StatelessWidget {

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

        borderRadius:
            BorderRadius.circular(12),

        onTap: onTap,

        child: Container(

          padding:
              const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 7,
          ),

          decoration:
              BoxDecoration(

            color:
                SmartNavColors.surfaceContainer,

            borderRadius:
                BorderRadius.circular(
              12,
            ),

            border: Border.all(
              color:
                  SmartNavColors.outlineVariant,
            ),
          ),

          child: Row(

            mainAxisSize:
                MainAxisSize.min,

            children: [

              Text(

                label,

                style:
                    SmartNavTextStyles.labelLg
                        .copyWith(
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
class _SheetIconButton
    extends StatelessWidget {

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

      color:
          SmartNavColors.surfaceContainer,

      shape:
          const CircleBorder(),

      child: InkWell(

        customBorder:
            const CircleBorder(),

        onTap: onTap,

        child: SizedBox(

          width: 38,
          height: 38,

          child: Icon(

            icon,

            size: 22,

            color:
                SmartNavColors
                    .onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}