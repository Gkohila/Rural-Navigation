import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../localization/app_localizations.dart';
import '../../localization/language_provider.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final languageProvider =
    Provider.of<LanguageProvider>(context);

final localizations =
    AppLocalizations(
      languageProvider.languageCode,
    );

final isTamil =
    languageProvider.languageCode == 'ta';
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F7F9),
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF0B5D1E),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
title: Text(
  localizations.text(
    'termsConditions',
  ),
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
  style: GoogleFonts.poppins(
    fontSize: isTamil ? 16 : 22,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF0B5D1E),
  ),
),
        
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            _termCard(
  Icons.directions_bus,
  localizations.text('transportRules'),
  localizations.text('transportRulesDesc'),
),
const SizedBox(height: 24),
_termCard(
  Icons.gps_fixed,
  localizations.text('gpsAccuracy'),
  localizations.text('gpsAccuracyDesc'),
),
const SizedBox(height: 24),
_termCard(
  Icons.route,
  localizations.text('routeInformation'),
  localizations.text('routeInformationDesc'),
),
const SizedBox(height: 24),
_termCard(
  Icons.wifi_off,
  localizations.text('networkConnectivity'),
  localizations.text('networkConnectivityDesc'),
),
const SizedBox(height: 24),
_termCard(
  Icons.warning_amber_rounded,
  localizations.text('userResponsibility'),
  localizations.text('userResponsibilityDesc'),
),
const SizedBox(height: 24),
_termCard(
  Icons.record_voice_over,
  localizations.text('voiceNavigationTerm'),
  localizations.text('voiceNavigationTermDesc'),
),
const SizedBox(height: 24),
_termCard(
  Icons.location_on,
  localizations.text('locationUsage'),
  localizations.text('locationUsageDesc'),
),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _termCard(
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Container(
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(
              icon,
              color: const Color(0xFF0B5D1E),
              size: 24,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}