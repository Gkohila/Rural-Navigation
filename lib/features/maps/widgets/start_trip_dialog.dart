import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../localization/language_provider.dart';
import '../../../localization/app_localizations.dart';

Future<bool?> showStartTripDialog(
  BuildContext context,
) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.45),
    builder: (context) {
      final languageCode =
          context.watch<LanguageProvider>().languageCode;

      final lang =
          AppLocalizations(languageCode);

      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 28,
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              /// TITLE
              Text(
                lang.text('startTripTitle'),
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111111),
                ),
              ),

              const SizedBox(height: 14),

              /// DESCRIPTION
              Text(
                lang.text('startTripDescription'),
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xFF555555),
                ),
              ),

              const SizedBox(height: 28),

              /// DISMISS BUTTON
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF5AA9F0),
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
                    Navigator.pop(
                      context,
                      false,
                    );
                  },
                  child: Text(
                    lang.text('dismiss'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              /// START BUTTON
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF0B5D1E),
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
                    Navigator.pop(
                      context,
                      true,
                    );
                  },
                  child: Text(
                    lang.text('startTrip'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.w600,
                      color: Colors.white,
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