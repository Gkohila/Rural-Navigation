import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../localization/app_localizations.dart';
import '../../localization/language_provider.dart';
import '../../services/issue_api_service.dart';

class ReportIssueScreen extends StatefulWidget {
  const ReportIssueScreen({super.key});

  @override
  State<ReportIssueScreen> createState() =>
      _ReportIssueScreenState();
}

class _ReportIssueScreenState
    extends State<ReportIssueScreen> {

  final TextEditingController titleController =
      TextEditingController();

  final TextEditingController descriptionController =
      TextEditingController();

  String selectedCategory = "Navigation";

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
  localizations.text('reportIssueTitle'),
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

            /// MAIN CARD
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
                    localizations.text('issueDetails'),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ISSUE TITLE
                  Text(
                    localizations.text('issueTitle'),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    controller: titleController,

                    decoration: InputDecoration(
                      hintText:
localizations.text('enterIssueTitle'),

                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// CATEGORY
                  Text(
                    localizations.text('issueCategory'),
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
    value: "Navigation",
    child: Text(
      localizations.text(
        'categoryNavigation',
      ),
    ),
  ),

  DropdownMenuItem(
    value: "Location",
    child: Text(
      localizations.text(
        'categoryLocation',
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
    value: "Notifications",
    child: Text(
      localizations.text(
        'categoryNotifications',
      ),
    ),
  ),

  DropdownMenuItem(
    value: "App Crash",
    child: Text(
      localizations.text(
        'categoryAppCrash',
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

                  /// DESCRIPTION
                  Text(
                    localizations.text('description'),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    controller:
                        descriptionController,

                    maxLines: 5,

                    decoration: InputDecoration(
                      hintText:
localizations.text('describeIssue'),

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
      backgroundColor: const Color(0xFF0B5D1E),
      foregroundColor: Colors.white,
      minimumSize: const Size(
        double.infinity,
        56,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),

    onPressed: () async {

  if (titleController.text.trim().isEmpty ||
      descriptionController.text.trim().isEmpty) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          localizations.text('fillAllFields'),
        ),
      ),
    );

    return;
  }

  final success =
      await IssueApiService.submitIssue(
    issueTitle:
        titleController.text.trim(),
    category: selectedCategory,
    description:
        descriptionController.text.trim(),
  );

  if (success) {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color(0xFF0B5D1E),
        content: Text(
          "Issue Submitted Successfully",
        ),
      ),
    );

    titleController.clear();
    descriptionController.clear();

    Future.delayed(
      const Duration(seconds: 1),
      () {
        Navigator.pop(context);
      },
    );

  } else {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Failed to Submit Issue",
        ),
      ),
    );
  }
},

    child: Text(
      localizations.text(
        'submitReport',
      ),
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 16,
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