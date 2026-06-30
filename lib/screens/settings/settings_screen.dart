import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../localization/language_provider.dart';
import 'location_permission_screen.dart';
import 'privacy_policy_screen.dart';
import 'terms_screen.dart';
import 'help_support_screen.dart';
import '../../localization/app_localizations.dart';
import '../../providers/profile_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool voiceNavigation = false;
  bool pushNotifications = false;
  String voiceLanguage = 'en';
String alertVolume = 'Medium';

  @override
  Widget build(BuildContext context) {
      final profileProvider =
      Provider.of<ProfileProvider>(context);
    final languageProvider =
    Provider.of<LanguageProvider>(context);


final localizations =
    AppLocalizations(
      languageProvider.languageCode,
    );

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
  localizations.text('settingsPrivacy'),
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
  style: GoogleFonts.poppins(
    fontSize:
        languageProvider.languageCode == 'ta'
            ? 17
            : 22,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF0B5D1E),
  ),
),
),

      body: SingleChildScrollView(

        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 24,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 8),

            /// ACCOUNT
            
            sectionTitle(
  localizations.text('account'),
),

            const SizedBox(height: 14),

            Container(
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

              child: Row(
                children: [

                  CircleAvatar(
                    radius: 38,

                    backgroundColor: Colors.green.shade100,

                    child: CircleAvatar(
  radius: 34,
  backgroundColor: Colors.white,

  backgroundImage:
      profileProvider.profile.imageBytes != null
          ? MemoryImage(
              profileProvider
                  .profile
                  .imageBytes!,
            )
          : null,

  child:
      profileProvider.profile.imageBytes == null
          ? Icon(
              Icons.person,
              size: 42,
              color: Colors.green.shade800,
            )
          : null,
),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
Text(
  profileProvider.profile.name,
  style: GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  ),
),

                        const SizedBox(height: 8),

Text(
  profileProvider.profile.bio,
  style: GoogleFonts.poppins(
    color: Colors.black54,
    fontSize: 14,
  ),
),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            /// ACCESSIBILITY
            sectionTitle(
  localizations.text(
    'accessibility',
  ),
),

            const SizedBox(height: 14),

            settingsCard(
  children: [

        Consumer<LanguageProvider>(
      builder: (context, provider, child) {
        return ListTile(
          leading: const Icon(
            Icons.language,
            color: Color(0xFF1565C0),
          ),

          title: Text(
            localizations.text(
  'language',
),
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),

          trailing: DropdownButton<String>(
            value: provider.languageCode,
            underline: const SizedBox(),

            items: const [
              DropdownMenuItem(
                value: 'en',
                child: Text('English'),
              ),
              DropdownMenuItem(
                value: 'ta',
                child: Text('தமிழ்'),
              ),
            ],

            onChanged: (value) {
              if (value != null) {
                provider.changeLanguage(value);
              }
            },
          ),
        );
      },
    ),
    

    switchTile(
      Icons.record_voice_over_outlined,
      localizations.text(
  'voiceNavigation',
),
      voiceNavigation,
      (value) {
        setState(() {
          voiceNavigation = value;
        });
      },
    ),

    


  ],
),
 const SizedBox(height: 26),


sectionTitle(
  localizations.text(
    'navigationSettings',
  ),
),

const SizedBox(height: 14),

settingsCard(
  children: [

    ListTile(
      leading: Icon(
        Icons.record_voice_over,
        color: voiceNavigation
            ? const Color(0xFF1565C0)
            : Colors.grey,
      ),

      title: Text(
        localizations.text(
  'voiceLanguage',
),
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: voiceNavigation
              ? Colors.black87
              : Colors.grey,
        ),
      ),

      trailing: DropdownButton<String>(
        value: voiceLanguage,

        underline: const SizedBox(),

        onChanged: voiceNavigation
            ? (value) {
                setState(() {
                  voiceLanguage = value!;
                });
              }
            : null,

        items: const [
          DropdownMenuItem(
            value: 'en',
            child: Text('English'),
          ),
          DropdownMenuItem(
            value: 'ta',
            child: Text('தமிழ்'),
          ),
        ],
      ),
    ),

    divider(),

    ListTile(
      leading: Icon(
        Icons.volume_up,
        color: voiceNavigation
            ? const Color(0xFF1565C0)
            : Colors.grey,
      ),

      title: Text(
        localizations.text(
  'alertVolume',
),
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: voiceNavigation
              ? Colors.black87
              : Colors.grey,
        ),
      ),

      trailing: DropdownButton<String>(
        value: alertVolume,

        underline: const SizedBox(),

        onChanged: voiceNavigation
            ? (value) {
                setState(() {
                  alertVolume = value!;
                });
              }
            : null,

       items: [
  DropdownMenuItem(
    value: 'Low',
    child: Text(
      localizations.text('low'),
    ),
  ),
  DropdownMenuItem(
    value: 'Medium',
    child: Text(
      localizations.text('medium'),
    ),
  ),
  DropdownMenuItem(
    value: 'High',
    child: Text(
      localizations.text('high'),
    ),
  ),
],
      ),
    ),
  ],
),

const SizedBox(height: 26), 

sectionTitle(
  localizations.text(
    'notifications',
  ),
),

const SizedBox(height: 14),

settingsCard(
  children: [

    switchTile(
      Icons.notifications_active_outlined,
      localizations.text(
  'pushNotifications',
),
      pushNotifications,
      (value) {
        setState(() {
          pushNotifications = value;
        });
      },
    ),
  ],
),
            
const SizedBox(height: 26),
         /// PRIVACY
sectionTitle(
  localizations.text(
    'privacy',
  ),
),

const SizedBox(height: 14),

settingsCard(
  children: [
   InkWell(
  onTap: () {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const LocationPermissionScreen(),
      ),
    );
  },

  child: listTile(
    Icons.location_on_outlined,
    localizations.text(
  'locationPermissions',
),
  ),
),
  ],
),

const SizedBox(height: 26),

/// ABOUT
sectionTitle(
  localizations.text(
    'aboutSection',
  ),
),

const SizedBox(height: 14),

settingsCard(
  children: [

    InkWell(
  onTap: () {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const PrivacyPolicyScreen(),
      ),
    );
  },

  child: listTile(
    Icons.privacy_tip_outlined,
    localizations.text(
  'privacyPolicy',
),
  ),
),

    divider(),

    InkWell(
  onTap: () {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const TermsScreen(),
      ),
    );
  },

  child: listTile(
    Icons.description_outlined,
    localizations.text(
  'termsConditions',
),
  ),
),

    divider(),

    listTile(
      Icons.info_outline,
      localizations.text(
  'appVersion',
),
      trailing: "v1.0.0",
    ),
  ],
),

const SizedBox(height: 26),

/// SUPPORT
sectionTitle(
  localizations.text(
    'support',
  ),
),

const SizedBox(height: 14),

settingsCard(
  children: [

   InkWell(
  onTap: () {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const HelpSupportScreen(),
      ),
    );
  },

  child: listTile(
    Icons.help_outline,
    localizations.text(
  'helpSupport',
),
  ),
),
  ],
),

const SizedBox(height: 26),

/// LOGOUT
SizedBox(
  width: double.infinity,

  child: ElevatedButton.icon(
    icon: const Icon(
  Icons.logout,
  color: Colors.white,
),

    label: Text(
  localizations.text(
  'logout',
),
  style: GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 16,
  ),
),

    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFC62828),
      foregroundColor: Colors.white,
      minimumSize: const Size(
        double.infinity,
        55,
      ),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(18),
      ),
    ),

    onPressed: () {

  showDialog(

    context: context,

    builder: (context) {

      return AlertDialog(

        
          title: Text(
  localizations.text(
    'logoutTitle',
  ),
),
      

        content: Text(
          localizations.text(
  'logoutMessage',
),
        ),

        actions: [

          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
           child: Text(
  localizations.text(
    'cancel',
  ),
),
          ),

          ElevatedButton(
  onPressed: () async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.clear();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
    );
  },
  child: Text(
    localizations.text('logout'),
  ),
)
        ],
      );
    },
  );
},
  ),
),

],
),
),
);
}


  Widget sectionTitle(String text) {

    return Padding(
      padding: const EdgeInsets.only(left: 4),

      child: Text(
        text,

        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w700,

          letterSpacing: 1.2,

          fontSize: 15,

          color: const Color(0xFF0B5D1E),
        ),
      ),
    );
  }

  Widget settingsCard({
    required List<Widget> children,
  }) {

    return Container(
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
        children: children,
      ),
    );
  }

  Widget switchTile(
    IconData icon,
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 8,
      ),

      child: Row(
        children: [

          Icon(
            icon,
            color: const Color(0xFF1565C0),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Text(
              title,

              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Switch(
            value: value,

            activeColor: const Color(0xFF0B5D1E),

            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget listTile(
    IconData icon,
    String title, {
    String? trailing,
  }) {

    return ListTile(

      leading: Icon(
        icon,
        color: const Color(0xFF1565C0),
      ),

      title: Text(
        title,

        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),

      trailing: trailing != null

          ? Text(
              trailing,

              style: GoogleFonts.poppins(
                color: const Color(0xFF0B5D1E),

                fontWeight: FontWeight.w600,
              ),
            )

          : const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
    );
  }

  Widget divider() {

    return Divider(
      height: 1,
      color: Colors.grey.shade200,
    );
  }
}