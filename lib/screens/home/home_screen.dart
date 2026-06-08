import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';
import '../../widgets/animations/interactive_scale.dart';
import '../../widgets/home/animated_hero_section.dart';
import '../../widgets/home/hero/weather_hero_scenario.dart';
import '../../widgets/home/bottom_navbar.dart';
import '../../widgets/home/quick_action_card.dart';
import '../../widgets/home/route_card.dart';

import '../navigation/active_trip_screen.dart';
  
import '../history/recent_search_screen.dart';
import '../stops/nearby_stops_screen.dart';

import '../../features/maps/screens/route_search_screen.dart';
import '../navigation/live_navigation_screen.dart';
import '../alert/alerts_screen.dart';

import 'package:provider/provider.dart';

import '../../localization/app_localizations.dart';
import '../../localization/language_provider.dart';
import '../../features/maps/services/location_service.dart';

import '../../features/maps/models/weather_model.dart';
import '../../features/maps/services/weather_api_service.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherModel? weather;
bool isLoadingWeather = true;

  HomeNavItem _selectedNavItem = HomeNavItem.home;
@override
void initState() {
  super.initState();
  _loadWeather();
}
Future<void> _loadWeather() async {
  try {
    final position =
    await LocationService.getCurrentLocation();

if (position == null) {
  setState(() {
    isLoadingWeather = false;
  });
  return;
}

debugPrint("LAT = ${position.latitude}");
debugPrint("LON = ${position.longitude}");





final languageCode =
    context.read<LanguageProvider>().languageCode;

final result =
    await WeatherApiService.getWeather(
      position.latitude,
      position.longitude,
      languageCode,
    );

setState(() {
  weather = result;
  
  isLoadingWeather = false;
});

    debugPrint("LOCATION = ${weather?.location}");
debugPrint("WEATHER = ${weather?.weather}");
debugPrint("TEMP = ${weather?.temperature}");
debugPrint("TIME = ${weather?.time}");
  } catch (e) {
    debugPrint("WEATHER ERROR = $e");

    setState(() {
      isLoadingWeather = false;
    });
  }
}
Future<void> _testLocation() async {

  debugPrint("TEST STARTED");

  final position =
      await LocationService.getCurrentLocation();

  debugPrint("POSITION = $position");

  if (position != null) {

    debugPrint("LAT = ${position.latitude}");
    debugPrint("LON = ${position.longitude}");

  } else {

    debugPrint("LOCATION NULL");

  }
}
  static const String _routeImageCourtallam =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuCMhdy8PODqwy-UeLbKLgh3lxC8MYIZqeSzOD5wNjv8lBlcP-WztDX9R2MDZDmv8LfBBvpdydSTEx4pSGnB9yq_1m_J9SDvdLxeCi7SQUj1lT7HV_0BLwJs-FoYCoNUMqc1zoRE4ZkajCv5KfbOik73_rOv72OHCqSNg5ZFKBohfkqooTXzy7X7in9PIQXQBdqNSDFA6GAq9u_v7IGOcJUa6rp6khocrsAYNZd3_sWFtVfUSZuru6_PSBaBygp0dXEQpMFPsAe9Hdeo';

  static const String _routeImageTirunelveli =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuAfWcRPU3bzJRRc64faDa-icvTtC01l_OrgmhHegaw3iUfpowDr8doPzxMpM_uySB3XQERBg0-MDujUwDmybDNLDxkq9nKrjknf8FgXMWxgUE-EiqUsqrcKYcyILLjlXj5apoqw1k2abPE3peO-WxYn1MTcEKcEZU-dIH5wYjbnKKG3yZogf93woU3RnneNzoHTuLeDcfHdQqHHkrf8H-utPG4KuTOK_XnWucUHwAxYaXIisSm-oRJZfkMPWsDZog_bbG57MovyMnuR';

  @override
  Widget build(BuildContext context) {
    final languageCode =
    context.watch<LanguageProvider>().languageCode;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _HomeHeader(),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppColors.maxContentWidth,
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      AppColors.mobilePadding,
                      16,
                      AppColors.mobilePadding,
                      80,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        isLoadingWeather || weather == null
    ? const SizedBox(
        height: 330,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
    : AnimatedHeroSection(
        scenario: WeatherHeroScenario(
         location: weather!.location,
          weather: weather!.weather,
          timeLabel: weather!.time,
          temperatureC: weather!.temperature,

         greeting: languageCode == 'ta'
    ? 'வணக்கம், ${weather!.location}!'
    : 'Vanakkam, ${weather!.location}!',

          sceneType:
              weather!.weather.toLowerCase().contains('rain')
                  ? HeroSceneType.nightRain
                  : HeroSceneType.sunnyMorning,

          weatherIcon:
              weather!.weather.toLowerCase().contains('cloud')
                  ? Icons.cloud
                  : Icons.wb_sunny,

          subtitle: weather!.weather,
        ),
      ),
                        const SizedBox(height: AppColors.gutter),
                        const _QuickActionsSection(),
                        const SizedBox(height: AppColors.gutter),
                        _SavedRoutesSection(
                          routeImageCourtallam: _routeImageCourtallam,
                          routeImageTirunelveli: _routeImageTirunelveli,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
     bottomNavigationBar: HomeBottomNavbar(

  selectedItem: _selectedNavItem,

  onItemSelected: (item) {

    setState(() {
      _selectedNavItem = item;
    });

    if (item == HomeNavItem.alerts) {

      Navigator.push(

        context,

        MaterialPageRoute(
          builder: (_) => const AlertsScreen(),
        ),
      );
    }
  },
),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  static const String _logoUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBKNhCvFGaHsmWmeoK4r50kcWeKxwmBBqH65gHcWQpVTvrGtm8f5lOPD4jUMZn5rQqjNd6I7BFzBt-KSodaT84URzdWF2-sDRmu0uEidsxkx0Ysj46cKrx2MpHHwDfezfTDFaUWrHu01la2xR93YrZm00_XtzVNTyGMvGQP_0FrHZjA-gn41UMVnDvuuu3LbUu3FwMY00AjU8wChelIxS7S_FS4GP1HrjBefhXUXMt1hA3cq7l1s9IDjeScfSkx8kexynwqIh3akGYzPGM';


    @override
    Widget build(BuildContext context) {

    final languageCode =
      context.watch<LanguageProvider>().languageCode;

  return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.78),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.4),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppColors.mobilePadding,
              vertical: 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      ClipOval(
                        child: ColoredBox(
                          color: AppColors.primaryFixed,
                          child: Image.network(
                            _logoUrl,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => const Icon(
                              Icons.location_city,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 400.ms)
                          .scale(
                            begin: const Offset(0.85, 0.85),
                            end: const Offset(1, 1),
                            duration: 400.ms,
                            curve: Curves.easeOutBack,
                          ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
  languageCode == 'ta'
      ? 'தென்காசி ஸ்மார்ட் நாவ்'
      : 'Tenkasi SmartNav',

                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: languageCode == 'ta' ? 15 : 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      )
                          .animate(delay: 60.ms)
                          .fadeIn(duration: 400.ms)
                          .slideX(begin: -0.05, end: 0, duration: 400.ms),
                    ],
                  ),
                ),
              Consumer<LanguageProvider>(
  builder: (context, provider, child) {
    return Container(
      width: 130,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade200,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                provider.changeLanguage('en');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: provider.languageCode == 'en'
                      ? AppColors.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'English',
                    style: TextStyle(
                      fontSize: 11,
                      color: provider.languageCode == 'en'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                provider.changeLanguage('ta');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: provider.languageCode == 'ta'
                      ? AppColors.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'தமிழ்',
                    style: TextStyle(
                      fontSize: 11,
                      color: provider.languageCode == 'ta'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate(delay: 120.ms).fadeIn(duration: 350.ms);
  },
)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickActionsSection extends StatelessWidget {
  const _QuickActionsSection();

  

  @override
  Widget build(BuildContext context) {
     final languageCode =
      context.watch<LanguageProvider>()
          .languageCode;

  final lang =
      AppLocalizations(languageCode);

   final actions = [
  (
    key: 'findBus',
    icon: Icons.directions_bus,
    label: lang.text('findBus'),
    bg: AppColors.secondaryContainer,
    fg: AppColors.onSecondaryContainer,
    delay: 320,
    float: 0,
  ),
  (
    key: 'recentSearch',
    icon: Icons.history,
    label: lang.text('recentSearch'),
    bg: AppColors.tertiaryContainer,
    fg: AppColors.onTertiaryContainer,
    delay: 400,
    float: 400,
  ),
  (
    key: 'liveNavigation',
    icon: Icons.near_me,
    label: lang.text('liveNavigation'),
    bg: AppColors.primaryContainer,
    fg: AppColors.onPrimaryContainer,
    delay: 480,
    float: 800,
  ),
  (
    key: 'nearbyStops',
    icon: Icons.map_outlined,
    label: lang.text('nearbyStops'),
    bg: AppColors.secondaryContainer,
    fg: AppColors.onSecondaryContainer,
    delay: 560,
    float: 1200,
  ),
];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
  lang.text('quickActions'),
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
            color: AppColors.onSurfaceVariant,
          ),
        )
            .animate(delay: 280.ms)
            .fadeIn(duration: 350.ms),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth =
                (constraints.maxWidth - AppColors.cardGap) / 2;
            return Wrap(
              spacing: AppColors.cardGap,
              runSpacing: AppColors.cardGap,
              children: [
                for (final action in actions)
                  SizedBox(
                    width: itemWidth,
                    child: QuickActionCard(
  icon: action.icon,
  label: action.label,
  iconBackgroundColor: action.bg,
  iconColor: action.fg,
  animateDelayMs: action.delay,
  floatPhaseMs: action.float,

  onTap: () {

  if (action.key == 'findBus'){

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RouteSearchScreen(),
      ),
    );

  }

  else if (action.key == 'recentSearch'){

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RecentSearchScreen(),
      ),
    );

  }

  else if (action.key == 'nearbyStops'){

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const NearbyStopsScreen(),
      ),
    );

  }

  else if (action.key == 'liveNavigation'){

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LiveNavigationScreen(),      ),
    );

  }

},
),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _SavedRoutesSection extends StatelessWidget {
  const _SavedRoutesSection({
    required this.routeImageCourtallam,
    required this.routeImageTirunelveli,
  });

  final String routeImageCourtallam;
  final String routeImageTirunelveli;

  @override
  Widget build(BuildContext context) {
    final languageCode =
    context.watch<LanguageProvider>().languageCode;

final lang =
    AppLocalizations(languageCode);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
  spacing: 12,
  runSpacing: 8,
  children: [
            Text(
              lang.text('savedRoutes'),
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.1,
                color: AppColors.onSurfaceVariant,
              ),
            )
                .animate(delay: 600.ms)
                .fadeIn(duration: 350.ms),
            InteractiveScale(
              hoverScale: 1.05,
              pressScale: 0.95,
              onTap: () {},
              child: Text(
                lang.text('viewAll'),
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            )
                .animate(delay: 640.ms)
                .fadeIn(duration: 350.ms),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            padding: const EdgeInsets.only(bottom: 8),
            children: [
              RouteCard(
                imageUrl: routeImageCourtallam,

  fromCity: lang.text('tenkasi'),
  toCity: lang.text('courtallam'),

                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RouteSearchScreen(),
                    ),
                  );

                },

                 duration: lang.text('mins15'),
  frequencyLabel: lang.text('every10m'),
                frequencyIcon: Icons.directions_bus,
                frequencyColor: AppColors.primary,
                animateDelayMs: 680,
              ),
              const SizedBox(width: AppColors.cardGap),
              RouteCard(
  imageUrl: routeImageTirunelveli,

  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RouteSearchScreen(),
      ),
    );
  },

  imageBackgroundColor: AppColors.secondaryFixed,

  fromCity: lang.text('sengottai'),
  toCity: lang.text('tirunelveli'),

  duration: lang.text('hour20'),
  frequencyLabel: lang.text('trainsDaily'),

  frequencyIcon: Icons.train,
  frequencyColor: AppColors.secondary,
  animateDelayMs: 760,
)

            ],
          ),
        ),
      ],
    );
  }
}