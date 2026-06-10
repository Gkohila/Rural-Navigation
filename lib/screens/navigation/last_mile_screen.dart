import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../navigation/live_navigation_screen.dart';
import '../home/home_screen.dart';
import '../../widgets/home/bottom_navbar.dart';
import 'package:provider/provider.dart';

import '../../localization/app_localizations.dart';
import '../../localization/language_provider.dart';

class LastMileScreen extends StatefulWidget {

  const LastMileScreen({super.key});

  @override
  State<LastMileScreen> createState() =>
      _LastMileScreenState();
}

class _LastMileScreenState
    extends State<LastMileScreen> {

      @override
void initState() {

  super.initState();

  Future.delayed(

    const Duration(minutes: 1),

    () {

      if (mounted) {

        showArrivalPopup();
      }
    },
  );
}

void showArrivalPopup() {

  final languageCode =
      context.read<LanguageProvider>().languageCode;

  final lang =
      AppLocalizations(languageCode);

  showDialog(

    context: context,

    barrierDismissible: false,

    builder: (_) {

      return Dialog(

        backgroundColor: Colors.transparent,

        child: Container(

          padding: const EdgeInsets.all(28),

          decoration: BoxDecoration(

            color: Colors.white,

            borderRadius:
                BorderRadius.circular(36),
          ),

          child: Column(

            mainAxisSize: MainAxisSize.min,

            children: [

              Container(

                width: 100,
                height: 100,

                decoration: BoxDecoration(

                  shape: BoxShape.circle,

                  color:
                      const Color(0xFFE8ECE8),
                ),

                child: Center(

                  child: Container(

                    width: 64,
                    height: 64,

                    decoration: const BoxDecoration(

                      color: Color(0xFF005F0F),

                      shape: BoxShape.circle,
                    ),

                    child: const Icon(

                      Icons.check,

                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              Text(

                lang.text('arrivedTitle'),

                textAlign: TextAlign.center,

                style:
                    GoogleFonts.plusJakartaSans(

                  fontSize: 28,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),

              const SizedBox(height: 14),

              RichText(

                textAlign: TextAlign.center,

                text: TextSpan(

                  children: [

                    TextSpan(

                      text:
                          lang.text('reachedDestination'),

                      style:
                          GoogleFonts.plusJakartaSans(

                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),

                    TextSpan(

                      text:
                          "Courtallam Main Falls",

                      style:
                          GoogleFonts.plusJakartaSans(

                        fontSize: 18,
                        fontWeight:
                            FontWeight.w700,

                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(

                width: double.infinity,

                height: 56,

                child: ElevatedButton(

                  onPressed: () {

                    Navigator.pushAndRemoveUntil(

                      context,

                      MaterialPageRoute(

                        builder: (_) => 
                          const HomeScreen(),
                      ),

                      (route) => false,
                    );
                  },

                  style:
                      ElevatedButton.styleFrom(

                    backgroundColor:
                        AppColors.primary,

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                              40),
                    ),
                  ),

                  child: Text(

                    lang.text('done'),

                    style:
                        GoogleFonts.plusJakartaSans(

                      fontSize: 18,
                      fontWeight:
                          FontWeight.w600,

                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(

                width: double.infinity,

                height: 56,

                child:
                    OutlinedButton.icon(

                  onPressed: () {},

                  icon: const Icon(
                    Icons.share,
                  ),

                  label: Text(

                    lang.text('shareTrip'),

                    style:
                        GoogleFonts.plusJakartaSans(

                      fontSize: 17,
                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {

    final languageCode =
    context.watch<LanguageProvider>().languageCode;

final lang =
    AppLocalizations(languageCode);

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
                            IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back_ios_new,
        size: 20,
      ),
    ),

                        Container(
  width: 44,
  height: 44,

  decoration: BoxDecoration(
    color: const Color(0xFF0B5D1E),
    borderRadius: BorderRadius.circular(12),
  ),

  child: const Icon(
    Icons.route,
    color: Colors.white,
    size: 24,
  ),
),
                        const SizedBox(width: 12),

                        Text(
  lang.text('appName'),
  overflow: TextOverflow.ellipsis,
  style: GoogleFonts.plusJakartaSans(
    fontSize: languageCode == 'ta' ? 16 : 22,
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
                      'assets/images/forest_top_view.jpg',
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

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                        ),

                        child: Text(
                         lang.text('closeDestination'),

                          textAlign: TextAlign.center,

                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppColors.surfaceContainerLowest,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// TITLE
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 18,
                ),

                child: Text(
                  lang.text('nearbyHelp'),

                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 20,
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
              _buildAutoCard(context, lang),

              const SizedBox(height: 26),

              /// TAXI CARD
              _buildTaxiCard(context, lang),

              const SizedBox(height: 26),

              /// WALK CARD
              _buildWalkCard(context, lang),

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
                  color: AppColors.primaryContainer,

                  borderRadius:
                      BorderRadius.circular(18),
                ),

                child: const Icon(
                  Icons.directions_bus,
                  color: AppColors.surfaceContainerLowest,
                  size: 34,
                ),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(
                      "Main Bus Stand",

                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text(
                      "450m Away",

                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
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

              Expanded(
                child: Text(
                  "Next Bus to Tenkasi Junction",

                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),

                decoration: BoxDecoration(
                  color: Colors.blue.shade100,

                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: Text(
                  "Courtallam 7 Mins",

                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
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
  Widget _buildAutoCard(
  BuildContext context,
  AppLocalizations lang,
) {

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),

      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,

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

              Text(
                lang.text('autoRickshaws'),

                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),

              Icon(
                Icons.electric_rickshaw,
                color: AppColors.primary,
                size: 34,
              ),
            ],
          ),

          const SizedBox(height: 28),

          Container(
  padding: const EdgeInsets.symmetric(
    horizontal: 14,
    vertical: 12,
  ),
  decoration: BoxDecoration(
    color: Colors.green.shade50,
    borderRadius: BorderRadius.circular(18),
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        Icons.electric_rickshaw,
        color: AppColors.primary,
      ),
      const SizedBox(width: 10),
      Text(
        "8 autos available nearby",
        style: GoogleFonts.plusJakartaSans(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  ),
),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,

            child: ElevatedButton(

              style: ElevatedButton.styleFrom(
                backgroundColor:
                    AppColors.primary,

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

              child: Text(
                lang.text('nearestAuto'),

                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// TAXI
  Widget _buildTaxiCard(
  BuildContext context,
  AppLocalizations lang,
) {

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),

      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,

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

              Text(
                lang.text('privateTaxis'),

                style: GoogleFonts.plusJakartaSans(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),

              Icon(
                Icons.local_taxi,
                color: AppColors.primary,
                size: 34,
              ),
            ],
          ),

          const SizedBox(height: 30),

          Text(
            lang.text('taxiDescription'),

            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              color: Colors.black54,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 36),

          Center(
  child: SizedBox(
    width: 260,

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

              child: Text(
              lang.text('viewRates'),

                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          ),
        ],
      
      ),
    );
  }

/// WALK
Widget _buildWalkCard(
  BuildContext context,
  AppLocalizations lang,
) {

  return Container(
    margin: const EdgeInsets.symmetric(
      horizontal: 16,
    ),

    height: 190,

    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),

      image: const DecorationImage(
        image: AssetImage(
          'assets/images/forest_top_view.jpg',
        ),
        fit: BoxFit.cover,
      ),
    ),

    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),

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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [

          const Icon(
            Icons.directions_walk,
            color: AppColors.surfaceContainerLowest,
            size: 48,
          ),

          const SizedBox(height: 18),

          Center(
            child: SizedBox(
              width: 220,
              height: 52,

              child: ElevatedButton.icon(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  padding: EdgeInsets.zero,

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30),
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
                  size: 18,
                ),

                label: Text(
                  lang.text('startWalking'),

                  style:
                      GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
    }