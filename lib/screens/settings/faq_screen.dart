import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../localization/app_localizations.dart';
import '../../localization/language_provider.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

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
  localizations.text('faq'),
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
                      Icons.help_outline,
                      size: 40,
                      color: Color(0xFF0B5D1E),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
  localizations.text('faqTitle'),
  style: GoogleFonts.poppins(
    fontSize: isTamil ? 16 : 18,
    fontWeight: FontWeight.w700,
  ),
),

                  const SizedBox(height: 8),

                  Text(
  localizations.text('faqDescription'),
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

            /// FAQ ITEMS
            faqCard(
  localizations.text('faqQ1'),
  localizations.text('faqA1'),
),

faqCard(
  localizations.text('faqQ2'),
  localizations.text('faqA2'),
),

faqCard(
  localizations.text('faqQ3'),
  localizations.text('faqA3'),
),

faqCard(
  localizations.text('faqQ4'),
  localizations.text('faqA4'),
),

faqCard(
  localizations.text('faqQ5'),
  localizations.text('faqA5'),
),

faqCard(
  localizations.text('faqQ6'),
  localizations.text('faqA6'),
),

faqCard(
  localizations.text('faqQ7'),
  localizations.text('faqA7'),
),

faqCard(
  localizations.text('faqQ8'),
  localizations.text('faqA8'),
),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget faqCard(
    String question,
    String answer,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: ExpansionTile(

        iconColor: const Color(0xFF0B5D1E),
        collapsedIconColor: const Color(0xFF0B5D1E),

        title: Text(
  question,
  style: GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 15,
  ),
),

        children: [

          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              0,
              16,
              16,
            ),

            child: Text(
              answer,
              style: GoogleFonts.poppins(
                color: Colors.black54,
                height: 1.5,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}