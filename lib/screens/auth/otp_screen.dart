import 'package:flutter/material.dart';
import '../home/home_screen.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),

            child: Column(
              children: [

                // TOP ROW
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      icon: const Icon(
                        Icons.arrow_back,
                        size: 26,
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),

                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: const Row(
                        children: [

                          Icon(
                            Icons.language,
                            color: Colors.green,
                            size: 18,
                          ),

                          SizedBox(width: 5),

                          Text(
                            "EN/தமிழ்",

                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                // LOCK ICON
                Container(
                  height: 90,
                  width: 90,

                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.lock,
                    size: 45,
                    color: Colors.green,
                  ),
                ),

                const SizedBox(height: 28),

                const Text(
                  "Verify OTP",

                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF006400),
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  "Enter the 4-digit code sent to",

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "+91 9876543210",

                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),

                const SizedBox(height: 35),

                // OTP BOXES
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [

                    otpBox(),
                    otpBox(),
                    otpBox(),
                    otpBox(),
                  ],
                ),

                const SizedBox(height: 30),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    Icon(
                      Icons.timer,
                      color: Colors.green,
                      size: 20,
                    ),

                    SizedBox(width: 6),

                    Text(
                      "OTP expires in 01:45",

                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                // VERIFY BUTTON
                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                    onPressed: () {

  Navigator.pushReplacement(
    context,

    MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    ),
  );
},

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF006400),

                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),

                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        Text(
                          "Verify OTP",

                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(width: 8),

                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // RESEND BUTTON
                OutlinedButton.icon(
                  onPressed: () {},

                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 55),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.green,
                    size: 20,
                  ),

                  label: const Text(
                    "Resend OTP",

                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget otpBox() {
    return Container(
      height: 60,
      width: 55,

      decoration: BoxDecoration(
        color: Colors.white,

        border: Border.all(
          color: Colors.green,
          width: 2,
        ),

        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}