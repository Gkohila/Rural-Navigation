import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentSearchScreen extends StatelessWidget {
  const RecentSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF6F7F9),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F7F9),
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text(
          "Recent Searches",

          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            /// SEARCH BAR
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(18),
              ),

              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,

                  hintText: "Search history...",

                  hintStyle: GoogleFonts.poppins(),

                  icon: const Icon(Icons.search),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "Today",

              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 16),

            historyCard(
              Icons.directions_bus,
              "Tenkasi → Chennai",
              "Luxury Bus • 8h journey",
              "10 mins ago",
            ),

            historyCard(
              Icons.train,
              "Courtallam → Madurai",
              "Express Train • 5h journey",
              "30 mins ago",
            ),

            const SizedBox(height: 24),

            Text(
              "Yesterday",

              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 16),

            historyCard(
              Icons.location_on,
              "Tirunelveli Bus Stand",
              "Nearby stop search",
              "Yesterday",
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade50,

                  foregroundColor: Colors.red,

                  padding:
                      const EdgeInsets.symmetric(vertical: 16),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),

                onPressed: () {},

                icon: const Icon(Icons.delete_outline),

                label: Text(
                  "Clear History",

                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget historyCard(
    IconData icon,
    String title,
    String subtitle,
    String trailing,
  ) {

    return Container(
      margin: const EdgeInsets.only(bottom: 14),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(22),
      ),

      child: Row(
        children: [

          Container(
            padding: const EdgeInsets.all(14),

            decoration: BoxDecoration(
              color: Colors.green.shade50,

              borderRadius: BorderRadius.circular(18),
            ),

            child: Icon(
              icon,
              color: Colors.green.shade700,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
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

          Text(
            trailing,

            style: GoogleFonts.poppins(
              color: Colors.black45,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}