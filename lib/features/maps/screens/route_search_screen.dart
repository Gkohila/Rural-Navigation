import 'package:flutter/material.dart';
import 'package:smartnav/features/maps/data/static_route_data.dart';
import 'package:smartnav/features/maps/widgets/bottom_nav_bar.dart';
import 'package:smartnav/features/maps/widgets/free_live_map.dart';
import 'package:smartnav/features/maps/widgets/route_card.dart';
import 'package:smartnav/features/maps/widgets/transport_button.dart';
import 'package:smartnav/theme/smart_nav_theme.dart';
import '../widgets/floating_route_search_bar.dart';

class RouteSearchScreen extends StatefulWidget {
  const RouteSearchScreen({super.key});

  @override
  State<RouteSearchScreen> createState() =>
      _RouteSearchScreenState();
}

class _RouteSearchScreenState
    extends State<RouteSearchScreen> {

  int _bottomNavIndex = 1;
  int _selectedTransportIndex = 2;

  @override
  Widget build(BuildContext context) {

    return Theme(
      data: SmartNavTheme.light,

      child: Scaffold(
        backgroundColor:
            SmartNavColors.background,

        body: SafeArea(
          top: true,
          bottom: false,

          child: Stack(
            fit: StackFit.expand,

            children: [

              /// MAP
              const Positioned.fill(
                child: FreeLiveMap(),
              ),

              /// SEARCH BAR
              Positioned(
                top: 14,
                left: 14,
                right: 14,

                child:
                    const FloatingRouteSearchBar(),
              ),

              /// GOOGLE MAPS STYLE SHEET
              DraggableScrollableSheet(
                initialChildSize: 0.58,
                minChildSize: 0.18,
                maxChildSize: 0.94,

                expand: false,

                snap: true,

                snapSizes: const [
                  0.18,
                  0.58,
                  0.94,
                ],

                builder:
                    (context, scrollController) {

                  return Container(
                    decoration: BoxDecoration(
                      color:
                          SmartNavColors.surface,

                      borderRadius:
                          const BorderRadius.vertical(
                        top: Radius.circular(28),
                      ),

                      boxShadow:
                          SmartNavElevation.sheet,
                    ),

                    child:
                        NestedScrollView(

                      controller:
                          scrollController,

                      physics:
                          const BouncingScrollPhysics(
                        parent:
                            AlwaysScrollableScrollPhysics(),
                      ),

                      headerSliverBuilder:
                          (context,
                              innerBoxIsScrolled) {

                        return [

                          /// HANDLE + TITLE
                          SliverToBoxAdapter(
                            child:
                                Column(
                              children: [

                                /// HANDLE
                                const SizedBox(
                                  height:
                                      8,
                                ),

                                Center(
                                  child:
                                      Container(
                                    width:
                                        48,
                                    height:
                                        5,

                                    decoration:
                                        BoxDecoration(
                                      color:
                                          SmartNavColors.surfaceVariant,

                                      borderRadius:
                                          BorderRadius.circular(
                                        999,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height:
                                      12,
                                ),

                                /// TITLE
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(
                                    horizontal:
                                        20,
                                  ),

                                  child:
                                      Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,

                                    children: [

                                      Text(
                                        'Public transport',

                                        style:
                                            SmartNavTextStyles.headlineMd,
                                      ),

                                      Row(
                                        children: const [

                                          _SheetIconButton(
                                            icon:
                                                Icons.close,
                                          ),

                                          SizedBox(
                                            width:
                                                8,
                                          ),

                                          _SheetIconButton(
                                            icon:
                                                Icons.share,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                  height:
                                      10,
                                ),
                              ],
                            ),
                          ),

                          /// STICKY TRANSPORT SECTION
                          SliverPersistentHeader(
                            pinned:
                                true,

                            delegate:
                                _TransportStickyHeader(
                              child:
                                  Container(
                                color:
                                    SmartNavColors.surface,

                                child:
                                    Column(
                                  children: [

                                    /// TRANSPORT BUTTONS
                                    SizedBox(
                                      height:
                                          82,

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
                                            StaticRouteData.transportModes.length,

                                        separatorBuilder:
                                            (_, __) =>
                                                const SizedBox(
                                          width:
                                              14,
                                        ),

                                        itemBuilder:
                                            (context,
                                                i) {

                                          return TransportButton(
                                            icon:
                                                StaticRouteData.transportModes[i].icon,

                                            label:
                                                StaticRouteData.transportModes[i].label,

                                            isSelected:
                                                i ==
                                                    _selectedTransportIndex,

                                            iconFilled:
                                                StaticRouteData.transportModes[i].iconFilled,

                                            onTap:
                                                () {

                                              setState(
                                                () {

                                                  _selectedTransportIndex =
                                                      i;
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),

                                    const SizedBox(
                                      height:
                                          6,
                                    ),

                                    /// FILTER CHIPS
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(
                                        20,
                                        0,
                                        20,
                                        0,
                                      ),

                                      child:
                                          SingleChildScrollView(
                                        scrollDirection:
                                            Axis.horizontal,

                                        child:
                                            Row(
                                          children: [

                                            _FilterChip(
                                              label:
                                                  'Leave 4:50 PM',
                                            ),

                                            const SizedBox(
                                              width:
                                                  10,
                                            ),

                                            _FilterChip(
                                              label:
                                                  'Preferred modes',
                                            ),

                                            const SizedBox(
                                              width:
                                                  10,
                                            ),

                                            _FilterChip(
                                              label:
                                                  'Filter by',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      height:
                                          6,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ];
                      },

                      /// ROUTE BODY
                      body:
                          ListView(
                        padding:
                            const EdgeInsets.fromLTRB(
                          20,
                          0,
                          20,
                          0,
                        ),

                        children: [

                          const SizedBox(
                            height:
                                4,
                          ),

                          const _RouteResultsList(),

                          SizedBox(
                            height:
                                MediaQuery.of(
                                                context)
                                            .padding
                                            .bottom +
                                        140,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              /// BOTTOM NAV BAR
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
      ),
    );
  }
}

/// STICKY HEADER
class _TransportStickyHeader
    extends SliverPersistentHeaderDelegate {

  final Widget child;

  _TransportStickyHeader({
    required this.child,
  });

  @override
  double get minExtent => 128;

  @override
  double get maxExtent => 128;

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

/// ICON BUTTON
class _SheetIconButton
    extends StatelessWidget {

  const _SheetIconButton({
    required this.icon,
  });

  final IconData icon;

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

        onTap: () {},

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

/// FILTER CHIP
class _FilterChip
    extends StatelessWidget {

  const _FilterChip({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {

    return Container(
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
              fontSize:
                  12,
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
    );
  }
}

/// ROUTE RESULTS
class _RouteResultsList
    extends StatelessWidget {

  const _RouteResultsList();

  @override
  Widget build(BuildContext context) {

    final cards =
        StaticRouteData.routeCards;

    return Column(
      children: [

        RouteCard(
          data:
              cards[0],
          animationDelay:
              Duration.zero,
        ),

        const SizedBox(
          height: 14,
        ),

        RouteCard(
          data:
              cards[1],
          animationDelay:
              const Duration(
            milliseconds:
                60,
          ),
        ),

        const SizedBox(
          height: 14,
        ),

        RouteCard(
          data:
              cards[2],
          animationDelay:
              const Duration(
            milliseconds:
                120,
          ),
        ),

        const SizedBox(
          height: 14,
        ),

        RouteCard(
          data:
              cards[0],
          animationDelay:
              const Duration(
            milliseconds:
                180,
          ),
        ),

        const SizedBox(
          height: 14,
        ),

        RouteCard(
          data:
              cards[1],
          animationDelay:
              const Duration(
            milliseconds:
                240,
          ),
        ),

        const SizedBox(
          height: 14,
        ),

        RouteCard(
          data:
              cards[2],
          animationDelay:
              const Duration(
            milliseconds:
                300,
          ),
        ),
      ],
    );
  }
}