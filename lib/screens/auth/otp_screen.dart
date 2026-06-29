import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../home/home_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget {

  final String mobile;

  const OtpScreen({
    super.key,
    required this.mobile,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}



class _OtpScreenState extends State<OtpScreen> {

  final TextEditingController otpController =
      TextEditingController();
      int seconds = 120;
  Timer? timer;

   @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (seconds > 0) {
          setState(() {
            seconds--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    otpController.dispose();
    super.dispose();
  }
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

               Text(
  "+91 ${widget.mobile}",
  style: const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.green,
  ),
),

                const SizedBox(height: 35),

                // OTP BOXES
              Pinput(
  length: 4,
  controller: otpController,
),

                const SizedBox(height: 30),

                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    Icon(
                      Icons.timer,
                      color: Colors.green,
                      size: 20,
                    ),

                    SizedBox(width: 6),
Text(
  "OTP expires in ${seconds}s",

  style: const TextStyle(
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
                    onPressed: () async {

                     print("OTP ENTERED = ${otpController.text}");
                     print("MOBILE = ${widget.mobile}");

                       final response = await http.post(
                          Uri.parse("http://127.0.0.1:8081/api/auth/verify-otp"),
                          headers: {
                             "Content-Type": "application/json",
                          },
                           body: jsonEncode({
                           "mobile": widget.mobile,
                           "otp": otpController.text,
                          }),
                         );

  print("RESPONSE = ${response.body}");

final data = jsonDecode(response.body);
  print("FULL DATA = $data");
  print("USER ID = ${data["userId"]}");

if (data["message"] == "Login Success") {

  SharedPreferences prefs =
      await SharedPreferences.getInstance();


  await prefs.setInt(
    "user_id",
    data["userId"],
  );

  print(
    "SAVED USER ID = ${prefs.getInt("user_id")}",
  );

  bool saved =
      await prefs.setBool("isLoggedIn", true);

  print("SAVE RESULT = $saved");

  print(
    "READ AFTER SAVE = ${prefs.getBool("isLoggedIn")}",
  );

  await prefs.setString(
    "mobile",
    widget.mobile,
  );
  if (data["userId"] != null) {
  await prefs.setInt(
    "userId",
    data["userId"],
  );
   print(
    "SAVED USER ID = ${prefs.getInt("user_id")}",
  );
}

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    ),
  );
}else {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Invalid OTP"),
      ),
    );
  }
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
                  onPressed: () async {

  final response = await http.post(
    Uri.parse("http://127.0.0.1:8081/api/auth/send-otp"),
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "mobile": widget.mobile,
    }),
  );

  print(response.body);

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("OTP Sent Again"),
    ),
  );

  setState(() {
    seconds = 120;
  });
},

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

  
}