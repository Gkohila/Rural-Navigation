import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../navigation/live_navigation_screen.dart';
import '../home/home_screen.dart';
import '../../widgets/home/bottom_navbar.dart';

class LastMileScreen extends StatelessWidget {
  const LastMileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: AppColors.background,

      bottomNavigationBar: HomeBottomNavbar(

        selectedItem: HomeNavItem.routes,

        onItemSelected: (item) {

          if (item == HomeNavItem.home) {

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const HomeScreen(),
              ),
              (route) => false,
            );
          }
        },
      ),

      body: SafeArea(
        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              
              /// TOP HEADER
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),

                child: Row(
                  mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                  children: [

                    Row(
                      children: [

                        const CircleAvatar(
                          radius: 22,
                          backgroundImage: AssetImage(
                            'assets/images/profile.jpg',
                          ),
                        ),

                        const SizedBox(width: 12),

                        Text(
                          'Tenkasi SmartNav',

                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// TOP BANNER
              Container(
                margin: const EdgeInsets.all(16),

                height: 240,

                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(28),

                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/courtallam.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),

                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(28),

                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,

                      colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),

                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [

                      Container(
                        width: 88,
                        height: 88,

                        decoration: const BoxDecoration(
                          color: Color(0xFFB8F397),
                          shape: BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.check,
                          size: 52,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 26),

                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                        ),

                        child: Text(
                         "You're close to your destination",

                          textAlign: TextAlign.center,

                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// TITLE
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 18,
                ),

                child: Text(
                  "Nearby Help",

                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurface,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// BUS STAND CARD
              _buildBusStandCard(),

              const SizedBox(height: 26),

              /// AUTO CARD
              _buildAutoCard(context),

              const SizedBox(height: 26),

              /// TAXI CARD
              _buildTaxiCard(context),

              const SizedBox(height: 26),

              /// WALK CARD
              _buildWalkCard(context),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  /// BUS STAND
  Widget _buildBusStandCard() {

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,

        borderRadius:
            BorderRadius.circular(26),

        border: Border.all(
          color: Colors.blue.shade300,
          width: 2,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              Container(
                width: 64,
                height: 64,

                decoration: BoxDecoration(
                  color: Colors.blue.shade400,

                  borderRadius:
                      BorderRadius.circular(18),
                ),

                child: const Icon(
                  Icons.directions_bus,
                  color: Colors.white,
                  size: 34,
                ),
              ),

              const SizedBox(width: 18),

              const Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(
                      "Main Bus Stand",

                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text(
                      "450m Away",

                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [

              const Expanded(
                child: Text(
                  "Next Bus to Tenkasi Junction",

                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),

                decoration: BoxDecoration(
                  color: Colors.blue.shade100,

                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: const Text(
                  "Courtallam 7 Mins",

                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// AUTO
  Widget _buildAutoCard(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),

      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(28),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [

              const Text(
                "Auto Rickshaws",

                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Icon(
                Icons.electric_rickshaw,
                color: Colors.green.shade800,
                size: 34,
              ),
            ],
          ),

          const SizedBox(height: 28),

          Row(
            children: List.generate(
              4,
              (index) {

                return Container(
                  margin: const EdgeInsets.only(
                    right: 10,
                  ),

                  width: 52,
                  height: 52,

                  decoration: BoxDecoration(
                    color: index == 3
                        ? Colors.lightGreen.shade200
                        : Colors.grey.shade300,

                    shape: BoxShape.circle,
                  ),

                  child: Center(
                    child: Text(
                      index == 3 ? '+8' : '',
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,

            child: ElevatedButton(

              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.green.shade800,

                foregroundColor: Colors.white,

                padding:
                    const EdgeInsets.symmetric(
                  vertical: 18,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(40),
                ),
              ),

              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const LiveNavigationScreen(),
                  ),
                );
              },

              child: const Text(
                "Way to the Nearest Auto",

                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// TAXI
  Widget _buildTaxiCard(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),

      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(28),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [

              const Text(
                "Private Taxis",

                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Icon(
                Icons.local_taxi,
                color: Colors.blue.shade700,
                size: 34,
              ),
            ],
          ),

          const SizedBox(height: 30),

          const Text(
            "Available for long distance and site seeing tours around Tenkasi.",

            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 36),

          SizedBox(
            width: double.infinity,

            child: OutlinedButton(

              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 18,
                ),

                side: BorderSide(
                  color: Colors.brown.shade800,
                  width: 2,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(40),
                ),
              ),

              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const LiveNavigationScreen(),
                  ),
                );
              },

              child: const Text(
                "View Rates",

                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// WALK
  Widget _buildWalkCard(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),

      height: 220,

      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(30),

        image: const DecorationImage(
          image: AssetImage(
            'assets/images/walk_bg.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),

      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(30),

          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            colors: [
              Colors.green.withOpacity(0.2),
              Colors.green.withOpacity(0.75),
            ],
          ),
        ),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            const Icon(
              Icons.directions_walk,
              color: Colors.white,
              size: 62,
            ),

            const SizedBox(height: 26),

            ElevatedButton.icon(

              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFFB8F397),

                foregroundColor: Colors.black,

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 18,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(40),
                ),
              ),

              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const LiveNavigationScreen(),
                  ),
                );
              },

              icon: const Icon(
                Icons.arrow_forward,
              ),

              label: const Text(
                "Start Walking Directions",

                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}