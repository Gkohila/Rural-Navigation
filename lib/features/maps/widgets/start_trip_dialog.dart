import 'package:flutter/material.dart';

Future<bool?> showStartTripDialog(
  BuildContext context,
) {

  return showDialog<bool>(

    context: context,

    barrierDismissible: true,

    barrierColor: Colors.black.withOpacity(0.45),

    builder: (context) {

      return Dialog(

        backgroundColor: Colors.transparent,

        insetPadding:
            const EdgeInsets.symmetric(
          horizontal: 28,
        ),

        child: Container(

          padding: const EdgeInsets.all(24),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.circular(28),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              /// TITLE
              const Text(
                'Start this trip?',

                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111111),
                ),
              ),

              const SizedBox(height: 14),

              /// DESCRIPTION
              const Text(
                'You’re on an active trip. '
                'Do you want to end guidance '
                'for your active trip, and '
                'start this trip instead?',

                style: TextStyle(
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

                  style:
                      ElevatedButton.styleFrom(

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

                  child: const Text(
                    'Dismiss',

                    style: TextStyle(
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

                  style:
                      ElevatedButton.styleFrom(

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

                  child: const Text(
                    'Start trip',

                    style: TextStyle(
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