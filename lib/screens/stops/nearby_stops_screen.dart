import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NearbyStopsScreen extends StatelessWidget {
  const NearbyStopsScreen({super.key});

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
          "Nearby Stops",

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
          children: [

            /// MAP
            Container(
              height: 180,
              width: double.infinity,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),

                image: const DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1524661135-423995f22d0b',
                  ),

                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 24),

            stopCard(
              "Courtallam Bus Stop",
              "200m away",
              Icons.directions_bus,
            ),

            stopCard(
              "Tenkasi Railway Station",
              "1.2 km away",
              Icons.train,
            ),

            stopCard(
              "Main Auto Stand",
              "350m away",
              Icons.local_taxi,
            ),
          ],
        ),
      ),
    );
  }

  Widget stopCard(
    String title,
    String distance,
    IconData icon,
  ) {

    return Container(
      margin: const EdgeInsets.only(bottom: 16),

      padding: const EdgeInsets.all(18),

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
                  distance,

                  style: GoogleFonts.poppins(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          ElevatedButton(

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade700,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),

            onPressed: () {},

            child: Text(
              "Directions",

              style: GoogleFonts.poppins(),
            ),
          ),
        ],
      ),
    );
  }
}