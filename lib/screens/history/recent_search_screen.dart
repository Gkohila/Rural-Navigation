import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../localization/app_localizations.dart';
import '../../localization/language_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RecentSearchScreen extends StatefulWidget {
  const RecentSearchScreen({super.key});

  @override
  State<RecentSearchScreen> createState() =>
      _RecentSearchScreenState();
}

class _RecentSearchScreenState
    extends State<RecentSearchScreen> {

  List<dynamic> history = [];
  List<dynamic> filteredHistory = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

Future<void> loadHistory() async {

  final prefs =
      await SharedPreferences.getInstance();

  final userId =
      prefs.getInt("user_id");

  print("USER ID = $userId");

  final response = await http.get(
    Uri.parse(
      "http://localhost:8081/api/history/user/$userId",
    ),
  );

  print("STATUS = ${response.statusCode}");
  print("BODY = ${response.body}");
  

 final List<dynamic> data =
    jsonDecode(response.body);

data.sort((a, b) {
  return DateTime.parse(b["searchedAt"])
      .compareTo(DateTime.parse(a["searchedAt"]));
});

setState(() {
 history = data;
 filteredHistory = data;


});

print(history);

}
String getSectionTitle(DateTime date) {

  final now = DateTime.now();

  final today =
      DateTime(now.year, now.month, now.day);

  final itemDate =
      DateTime(date.year, date.month, date.day);

  if (itemDate == today) {
    return "Today";
  }

  if (itemDate ==
      today.subtract(const Duration(days: 1))) {
    return "Yesterday";
  }

  return DateFormat("dd MMM yyyy").format(date);
}

List<Widget> buildHistoryList() {
  if (history.isEmpty) {
 return [
  const SizedBox(height: 80),

  Center(
    child: Column(
      children: [
        Icon(
          Icons.history,
          size: 70,
          color: Colors.grey.shade400,
        ),

        const SizedBox(height: 20),

        Text(
          "No Recent Searches",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0B5D1E),
          ),
        ),

        const SizedBox(height: 10),

        Text(
          "Your recent searches will appear here.",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),
];
}

  List<Widget> widgets = [];
  String lastSection = "";

  for (final item in  filteredHistory) {

    final date = DateTime.parse(item["searchedAt"]);
    final time = DateFormat("hh:mm a").format(date);

    final section = getSectionTitle(date);

    if (section != lastSection) {

      widgets.add(
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 16),
          child: Text(
            section,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0B5D1E),
              fontSize: 18,
            ),
          ),
        ),
      );

      lastSection = section;
    }

    widgets.add(
      historyCard(
        Icons.directions_bus,
        "${item["source"]} -> ${item["destination"]}",
        "${item["transportType"]} • $time",
      ),
    );
  }

  return widgets;
}

  @override
  Widget build(BuildContext context) {
    final languageCode =
    context.watch<LanguageProvider>().languageCode;

    final lang =
      AppLocalizations(languageCode);

    return Scaffold(

      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,

        elevation: 0,

        centerTitle: true,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 22,
          ),

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text(
          lang.text('recentSearchHistory'),

          style: GoogleFonts.poppins(
            color: const Color(0xFF0B5D1E),
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),

        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 12),

            child: IconButton(

onPressed: () async {

  final result = await showDialog<bool>(
    context: context,
    builder: (context) {

      return AlertDialog(
  backgroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
title: Text(
  "Clear History",
  style: GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF0B5D1E),
  ),
),
        content: Text(
  "Are you sure you want to clear your search history?",
  style: GoogleFonts.poppins(
    fontSize: 15,
    color: Colors.black54,
  ),
),

        actions: [

         TextButton(
  style: TextButton.styleFrom(
    foregroundColor: const Color(0xFF0B5D1E),
  ),
  onPressed: () {
    Navigator.pop(context, false);
  },
  child: const Text("Cancel"),
),

ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF0B5D1E),
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      
    ),
  ),            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 4,
  ),
  child: Text(
    "Clear",
    style: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
),
          ),

        ],
      );
    },
  );

  if (result != true) return;
  final prefs = await SharedPreferences.getInstance();

final userId = prefs.getInt("user_id");

final response = await http.delete(
  Uri.parse(
    "http://localhost:8081/api/history/user/$userId",
  ),
);

print("DELETE STATUS = ${response.statusCode}");
print("DELETE BODY = ${response.body}");

await loadHistory();

  // 👇 Next step la delete API call poduvom.

},

              icon: const Icon(
                Icons.delete_outline,

                color: Color(0xFF0B5D1E),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                const SizedBox(height: 10),

                /// SEARCH BAR
                Container(
                  height: 56,

                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(18),

                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),

                  child: Row(
                    children: [

                      Icon(
                        Icons.search,
                        color: Colors.grey.shade500,
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: TextField(
                           onChanged: (value) {

    setState(() {

      filteredHistory = history.where((item) {

        final route =
            "${item["source"]} ${item["destination"]}"
                .toLowerCase();

        return route.contains(
            value.toLowerCase());

      }).toList();

    });

  },
                          decoration: InputDecoration(
                            border: InputBorder.none,

                            hintText:
                                lang.text('searchHistory'),

                            hintStyle:
                                GoogleFonts.poppins(
                              color:
                                  Colors.grey.shade500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                
               
                const SizedBox(height: 16),
...buildHistoryList(),


                

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget historyCard(
    IconData icon,
    String title,
    String subtitle,
  ) {

    return Container(
      margin: const EdgeInsets.only(bottom: 14),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(22),

        border: Border.all(
          color: Colors.grey.shade200,
        ),

        boxShadow: [

          BoxShadow(
            color:
                Colors.black.withOpacity(0.03),

            blurRadius: 8,

            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        children: [

          /// ICON
          Container(
            height: 54,
            width: 54,

            decoration: BoxDecoration(
              color:
                  const Color(0xFFEAF7EA),

              borderRadius:
                  BorderRadius.circular(18),
            ),

            child: Icon(
              icon,
              color:
                  const Color(0xFF0B5D1E),
              size: 28,
            ),
          ),

          const SizedBox(width: 16),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: GoogleFonts.poppins(
                    fontWeight:
                        FontWeight.w600,
                    fontSize: 17,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,

                  style: GoogleFonts.poppins(
                    color:
                        Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          /// ARROW
          Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Colors.grey.shade500,
          ),
        ],
      ),
    );
  }
}