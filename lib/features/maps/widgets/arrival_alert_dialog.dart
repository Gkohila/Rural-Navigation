import 'package:flutter/material.dart';

Future<void> showArrivalAlertDialog(
  BuildContext context,
) {

  return showDialog(

    context: context,

    barrierDismissible: false,

    barrierColor: Colors.black.withOpacity(0.45),

    builder: (context) {

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

            borderRadius:
                BorderRadius.circular(28),
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
                      color: Colors.green
                          .withOpacity(0.10),

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
              const Text(
                '10 Minutes away\n'
                'to reach your\n'
                'STOP',

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 28,
                  height: 1.3,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                ),
              ),

              const SizedBox(height: 18),

              /// SUBTEXT
              RichText(

                textAlign: TextAlign.center,

                text: const TextSpan(

                  style: TextStyle(
                    fontSize: 17,
                    height: 1.5,
                    color: Color(0xFF666666),
                  ),

                  children: [

                    TextSpan(
                      text:
                          'Prepare to get off at ',
                    ),

                    TextSpan(
                      text: 'Tenkasi Junction',

                      style: TextStyle(
                        color: Color(0xFF005A13),
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),

                    TextSpan(
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

                    Navigator.pop(
                      context,
                    );
                  },

                  icon: const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 20,
                  ),

                  label: const Text(
                    "I'm Ready",

                    style: TextStyle(
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

                    Navigator.pop(
                      context,
                    );
                  },

                  icon: const Icon(
                    Icons.notifications_off,
                    color: Colors.black87,
                    size: 20,
                  ),

                  label: const Text(
                    'Mute Alert',

                    style: TextStyle(
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