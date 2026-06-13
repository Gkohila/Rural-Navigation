import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'faq_screen.dart';
import 'report_issue_screen.dart';
import 'feedback_screen.dart';

import 'package:provider/provider.dart';
import '../../localization/app_localizations.dart';
import '../../localization/language_provider.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

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
            color: Color(0xFF0B5D1E),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text(
  localizations.text('helpSupport'),
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
  style: GoogleFonts.poppins(
    fontSize: isTamil ? 19 : 22,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF0B5D1E),
  ),
),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            /// HEADER CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),

              child: Column(
                children: [

                  Container(
                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: const Icon(
                      Icons.support_agent,
                      size: 40,
                      color: Color(0xFF0B5D1E),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    localizations.text('needHelp'),
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    localizations.text('helpDescription'),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// FAQ
            supportCard(
              context,
              icon: Icons.help_outline,
             title: localizations.text('faq'),
             subtitle: localizations.text('faqSubtitle'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const FaqScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            /// REPORT ISSUE
            supportCard(
              context,
              icon: Icons.report_problem_outlined,
              title: localizations.text('reportIssue'),
              subtitle: localizations.text('reportIssueSubtitle'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ReportIssueScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            /// CONTACT SUPPORT
      
            /// FEEDBACK
            supportCard(
              context,
              icon: Icons.feedback_outlined,
              title: localizations.text('sendFeedback'),
subtitle: localizations.text('feedbackSubtitle'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const FeedbackScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            /// CONTACT INFO CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(
  localizations.text(
    'contactInformation',
  ),
  style: GoogleFonts.poppins(
    fontSize: 17,
    fontWeight: FontWeight.w700,
  ),
),

                  const SizedBox(height: 16),

                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.email_outlined,
                      color: Color(0xFF0B5D1E),
                    ),
                    title: Text("support@tenkasismartnav.in"),
                  ),

                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.phone_outlined,
                      color: Color(0xFF0B5D1E),
                    ),
                    title: Text("+91 8111036650"),
                  ),

                  ListTile(
  contentPadding: EdgeInsets.zero,
  leading: const Icon(
    Icons.access_time,
    color: Color(0xFF0B5D1E),
  ),
  title: Text(
    localizations.text('supportHours'),
  ),
),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text(
  localizations.text(
    'appVersionFooter',
  ),
  style: GoogleFonts.poppins(
    color: Colors.grey,
    fontSize: 13,
  ),
),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget supportCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,

      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          children: [

            Container(
              padding: const EdgeInsets.all(12),

              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(16),
              ),

              child: Icon(
                icon,
                color: const Color(0xFF0B5D1E),
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      color: Colors.black54,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}