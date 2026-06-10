import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../localization/app_localizations.dart';
import '../../../localization/language_provider.dart';

Future<void> showArrivalAlertDialog(
  BuildContext context,
) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.45),
    builder: (context) {
      final languageCode =
          context.watch<LanguageProvider>().languageCode;

      final lang =
          AppLocalizations(languageCode);

      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 26,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// ICON
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color:
                          Colors.green.withOpacity(0.10),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(
                      color: Color(0xFF005A13),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications_active,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 26),

              /// TITLE
              Text(
                lang.text('arrivalTitle'),
                textAlign: TextAlign.center,
                style: TextStyle(
  fontSize: languageCode == 'ta' ? 20 : 28,
  height: 1.3,
  fontWeight: FontWeight.w700,
  color: const Color(0xFF1A1A1A),
),
              ),

              const SizedBox(height: 18),

              /// SUBTEXT
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 17,
                    height: 1.5,
                    color: Color(0xFF666666),
                  ),
                  children: [
                    TextSpan(
                      text:
                          '${lang.text('prepareGetOff')} ',
                    ),
                    const TextSpan(
                      text: 'Tenkasi Junction',
                      style: TextStyle(
                        color: Color(0xFF005A13),
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),
                    const TextSpan(
                      text: '.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              /// READY BUTTON
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF006400),
                    elevation: 0,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        999,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 20,
                  ),
                  label: Text(
                    lang.text('ready'),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight:
                          FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              /// MUTE BUTTON
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton.icon(
                  style:
                      OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xFFD0D0D0),
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        999,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.notifications_off,
                    color: Colors.black87,
                    size: 20,
                  ),
                  label: Text(
                    lang.text('muteAlert'),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight:
                          FontWeight.w500,
                      color: Colors.black87,
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