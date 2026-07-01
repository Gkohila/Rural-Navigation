import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../home/home_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../../providers/profile_provider.dart';
import '../../localization/app_localizations.dart';
import '../../localization/language_provider.dart';

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
    final languageProvider =
     Provider.of<LanguageProvider>(context);

    final localizations =
     AppLocalizations(
      languageProvider.languageCode,
    );
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

                Text(
                  localizations.text('verifyOtp'),

                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF006400),
                  ),
                ),

                const SizedBox(height: 12),

                Text(
  localizations.text('enterOtpMessage'),

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
  "${localizations.text('otpExpiresIn')} ${seconds}s",

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

                      //  final response = await http.post(
                      //     Uri.parse("http://127.0.0.1:8081/api/auth/verify-otp"),
                      //     headers: {
                      //        "Content-Type": "application/json",
                      //     },
                      //      body: jsonEncode({
                      //      "mobile": widget.mobile,
                      //      "otp": otpController.text,
                      //     }),
                      //    );
  final String baseUrl = kIsWeb
      ? "http://localhost:8081"
      : "http://10.0.2.2:8081";

  final response = await http.post(
    Uri.parse("$baseUrl/api/auth/verify-otp"),
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "mobile": widget.mobile,
      "otp": otpController.text,
    }),
  );

  print("VERIFY STATUS = ${response.statusCode}");
print("VERIFY BODY = ${response.body}");

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
  await prefs.setBool("isLoggedIn", true);

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

  await prefs.setInt(
    "userId",
    data["userId"],
  );

  final profileProvider =
      Provider.of<ProfileProvider>(
    context,
    listen: false,
  );

  await profileProvider.loadProfile();

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    ),
  );

} else {

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        localizations.text('invalidOtp'),
      ),
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

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        Text(
  localizations.text('verifyOtp'),

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

  final String baseUrl = kIsWeb
      ? "http://localhost:8081"
      : "http://10.0.2.2:8081";

  final response = await http.post(
    Uri.parse("$baseUrl/api/auth/send-otp"),
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "mobile": widget.mobile,
    }),
  );

  print("RESEND STATUS = ${response.statusCode}");
  print("RESEND BODY = ${response.body}");

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
  localizations.text('otpSentAgain'),
),
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

                  label: Text(
  localizations.text('resendOtp'),

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