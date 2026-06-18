import 'package:flutter/material.dart';
import 'otp_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController mobileController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              // TOP BAR
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    const Text(
                      "Tenkasi SmartNav",

                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF006400),
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
              ),

              // IMAGE CARD
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),

                child: Column(
                  children: [

                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),

                      child: Image.network(
                        "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Welcome Home",

                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF006400),
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),

                      child: Text(
                        "Connecting you to the heart of Tenkasi.",

                        textAlign: TextAlign.center,

                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // LOGIN CARD
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),

                  border: Border.all(
                    color: Colors.green,
                    width: 2,
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    const Text(
                      "Mobile Number / கைபேசி எண்",

                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 14),

                  TextField(
  controller: mobileController,
  keyboardType: TextInputType.number,
  maxLength: 10,
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
  ],
  decoration: InputDecoration(
    prefixText: "+91 ",
    hintText: "Enter 10 digit number",
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
),

                    const SizedBox(height: 10),

                    const Text(
                      "We will send a 4-digit OTP for verification.",

                      style: TextStyle(
                        color: Colors.black54,
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // SEND OTP BUTTON
                   // SEND OTP BUTTON
SizedBox(
  width: double.infinity,

  child: ElevatedButton(
    onPressed: () async {

  if (mobileController.text.length != 10) {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Enter valid 10 digit mobile number"),
      ),
    );

    return;
  }

  print("BUTTON CLICKED");

  try {

    final response = await http.post(
      Uri.parse("http://127.0.0.1:8081/api/auth/send-otp"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "mobile": mobileController.text
      }),
    );

    print("STATUS = ${response.statusCode}");
    print("BODY = ${response.body}");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpScreen(
  mobile: mobileController.text,
),
      ),
    );

  } catch (e) {

    print("ERROR = $e");
  }
},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF006400),

                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),

                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [

                            Text(
                              "Send OTP",

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

                    // OR
                    Row(
                      children: [

                        const Expanded(child: Divider()),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),

                          child: Text(
                            "OR",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 13,
                            ),
                          ),
                        ),

                        const Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: 22),

                    // GUEST BUTTON
                    Center(
                      child: OutlinedButton.icon(
                        onPressed: () {},

                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 14,
                          ),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),

                        icon: const Icon(
                          Icons.person_outline,
                          color: Colors.green,
                          size: 20,
                        ),

                        label: const Text(
                          "Guest",

                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.help_outline,
                    color: Colors.blue,
                    size: 18,
                  ),

                  SizedBox(width: 6),

                  Text(
                    "Need help logging in?",

                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                "©2024 Tenkasi District Administration.",

                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                "Designed for the citizens of Western Ghats.",

                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}