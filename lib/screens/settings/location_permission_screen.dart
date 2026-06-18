import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../localization/app_localizations.dart';
import '../../localization/language_provider.dart';

class LocationPermissionScreen extends StatefulWidget {
  const LocationPermissionScreen({super.key});

  @override
  State<LocationPermissionScreen> createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState
    extends State<LocationPermissionScreen> {

  String permissionText = "Checking...";
  IconData permissionIcon = Icons.location_searching;
  Color permissionColor = Colors.orange;

  @override
  void initState() {
    super.initState();
    checkPermission(context);
  }

  Future<void> checkPermission(BuildContext context) async {

    final languageProvider =
    Provider.of<LanguageProvider>(
      context,
      listen: false,
    );

final localizations =
    AppLocalizations(
      languageProvider.languageCode,
    );

    final status = await Permission.location.status;

    setState(() {

      if (status.isGranted) {

        permissionText = "Location Access Granted";
        permissionIcon = Icons.check_circle;
        permissionColor = Colors.green;

      } else if (status.isDenied) {

        permissionText =
    localizations.text(
      'permissionDenied',
    );
        permissionIcon = Icons.cancel;
        permissionColor = Colors.red;

      } else if (status.isPermanentlyDenied) {

        permissionText =
    localizations.text(
      'locationDisabled',
    );
        permissionIcon = Icons.block;
        permissionColor = Colors.orange;

      } else {

        permissionText =
    localizations.text(
      'unknownStatus',
    );
        permissionIcon = Icons.help;
        permissionColor = Colors.grey;
      }
    });
  }

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
    'locationPermission',
  ),
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
  style: GoogleFonts.poppins(
    fontSize: isTamil ? 18 : 22,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF0B5D1E),
  ),
),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            /// STATUS CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    localizations.text(
  'locationAccess',
),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [

                      Icon(
                        permissionIcon,
                        color: permissionColor,
                        size: 28,
                      ),

                      const SizedBox(width: 12),

                      Text(
                        permissionText,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// WHY LOCATION CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    localizations.text(
  'whyLocationNeeded',
),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 16),

                  _featureItem(
                    Icons.navigation,
                    localizations.text(
  'liveNavigation',
),
                  ),

                  const SizedBox(height: 12),

                  _featureItem(
                    Icons.location_on,
                    localizations.text(
  'nearbyStops',
),
                  ),

                  const SizedBox(height: 12),

                  _featureItem(
                    Icons.notifications_active,
                    localizations.text(
  'arrivalAlerts',
),
                  ),

                  const SizedBox(height: 12),

                  _featureItem(
                    Icons.route,
                    localizations.text(
  'routeGuidance',
),
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// OPEN SETTINGS BUTTON
            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(

                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),

                label: Text(
                  localizations.text(
  'openDeviceSettings',
),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF0B5D1E),

                  foregroundColor: Colors.white,

                  minimumSize:
                      const Size(double.infinity, 56),

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(18),
                  ),
                ),

                onPressed: () async {

                  await openAppSettings();

                  WidgetsBinding.instance
    .addPostFrameCallback((_) {
  checkPermission(context);
});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureItem(
    IconData icon,
    String title,
  ) {

    return Row(
      children: [

        Icon(
          icon,
          color: const Color(0xFF1565C0),
          size: 22,
        ),

        const SizedBox(width: 12),

        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}