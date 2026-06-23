import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../localization/app_localizations.dart';
import '../../localization/language_provider.dart';
import '../../services/feedback_api_service.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController feedbackController =
      TextEditingController();

  String selectedCategory = "General Feedback";

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
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text(
  localizations.text('sendFeedback'),
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
  style: GoogleFonts.poppins(
    fontSize: isTamil ? 18 : 22,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF0B5D1E),
  ),
),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            /// FEEDBACK CARD
            Container(
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

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    localizations.text('feedbackHeader'),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    localizations.text('feedbackDescription'),
                    style: GoogleFonts.poppins(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// CATEGORY
                  Text(
                    localizations.text('category'),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  DropdownButtonFormField<String>(
                    value: selectedCategory,

                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(16),
                      ),
                    ),

                    items: [
  DropdownMenuItem(
    value: "General Feedback",
    child: Text(
      localizations.text(
        'generalFeedback',
      ),
    ),
  ),

  DropdownMenuItem(
    value: "Navigation",
    child: Text(
      localizations.text(
        'categoryNavigation',
      ),
    ),
  ),

  DropdownMenuItem(
    value: "Voice Navigation",
    child: Text(
      localizations.text(
        'categoryVoiceNavigation',
      ),
    ),
  ),

  DropdownMenuItem(
    value: "App Design",
    child: Text(
      localizations.text(
        'appDesign',
      ),
    ),
  ),

  DropdownMenuItem(
    value: "Other",
    child: Text(
      localizations.text(
        'categoryOther',
      ),
    ),
  ),
],

                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  /// FEEDBACK
                  Text(
                    localizations.text('yourFeedback'),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    controller: feedbackController,
                    maxLines: 6,

                    decoration: InputDecoration(
                      hintText:
                          localizations.text('feedbackHint'),

                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// SUBMIT BUTTON
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF0B5D1E),

                  foregroundColor:
                      Colors.white,

                  minimumSize:
                      const Size(double.infinity, 56),

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            18),
                  ),
                ),

                onPressed: () async {

  if (feedbackController.text.trim().isEmpty) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          localizations.text('enterFeedback'),
        ),
      ),
    );

    return;
  }

  final success =
      await FeedbackApiService.submitFeedback(
    category: selectedCategory,
    feedback: feedbackController.text.trim(),
  );

  if (success) {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color(0xFF0B5D1E),
        content: Text(
          "Feedback Submitted Successfully",
        ),
      ),
    );

    feedbackController.clear();

  } else {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Failed to Submit Feedback",
        ),
      ),
    );
  }
},

                child: Text(
                  localizations.text(
  'submitFeedback',
),
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}