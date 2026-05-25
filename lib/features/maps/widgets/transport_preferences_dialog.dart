import 'package:flutter/material.dart';

class TransportPreferencesDialog extends StatefulWidget {
  final Function(List<String>) onApply;

  const TransportPreferencesDialog({
    super.key,
    required this.onApply,
  });

  @override
  State<TransportPreferencesDialog> createState() =>
      _TransportPreferencesDialogState();
}

class _TransportPreferencesDialogState
    extends State<TransportPreferencesDialog> {

  bool train = false;
bool bus = false;
bool autoRickshaw = false;
bool walking = false;

  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: Colors.transparent,

      child: Container(
        padding: const EdgeInsets.all(24),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [

            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                const Text(
                  'Preferred modes',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  icon: const Icon(Icons.close),
                ),
              ],
            ),

            const SizedBox(height: 20),

            buildOption(
              title: 'Train',
              subtitle:
                  'Local and Express services',

              icon: Icons.train,

              color: const Color(0xFFD9ECFF),

              value: train,

              onChanged: (v) {
                setState(() {
                  train = v;
                });
              },
            ),

            buildOption(
              title: 'Bus',
              subtitle:
                  'Government and Private fleets',

              icon: Icons.directions_bus,

              color: const Color(0xFFDDF8D6),

              value: bus,

              onChanged: (v) {
                setState(() {
                  bus = v;
                });
              },
            ),

            buildOption(
              title: 'Auto Rickshaw',
              subtitle:
                  'Quick short distance travel',

              icon: Icons.electric_rickshaw,

              color: const Color(0xFFFCE0D7),

              value: autoRickshaw,

              onChanged: (v) {
                setState(() {
                  autoRickshaw = v;
                });
              },
            ),

            buildOption(
              title: 'Walking',
              subtitle:
                  'Eco-friendly accessible paths',

              icon: Icons.directions_walk,

              color: const Color(0xFFF2F2F2),

              value: walking,

              onChanged: (v) {
                setState(() {
                  walking = v;
                });
              },
            ),

            const SizedBox(height: 28),

Row(
  children: [

    Expanded(
      child: ElevatedButton(

        onPressed: () {

          final selectedModes = <String>[];

          if (train) selectedModes.add('Train');
          if (bus) selectedModes.add('Bus');
          if (autoRickshaw) selectedModes.add('Auto');
          if (walking) selectedModes.add('Walking');

          widget.onApply(selectedModes);

          Navigator.pop(context);
        },

        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0B6B1A),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),

        child: const Text(
          'Apply preferences',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),

    const SizedBox(width: 14),

    Expanded(
      child: OutlinedButton(

        onPressed: () {

          setState(() {

            train = false;
            bus = false;
            autoRickshaw = false;
            walking = false;
          });
        },

        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),

        child: const Text(
          'Reset',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    ),
  ],
),
          ],
        ),
      ),
    );
  }

  Widget buildOption({

    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool value,
    required Function(bool) onChanged,

  }) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),

      child: Row(
        children: [

          Container(
            width: 56,
            height: 56,

            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(18),
            ),

            child: Icon(icon),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,

                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),

          Switch(
            value: value,

            activeColor: Colors.white,

            activeTrackColor:
                const Color(0xFF0B6B1A),

            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
Future<List<String>?> showTransportPreferencesDialog(
  BuildContext context,
  List<String> selectedModes,
) async {

  List<String>? result;

  await showDialog(
    context: context,
    builder: (_) {
      return TransportPreferencesDialog(
        onApply: (modes) {
          result = modes;
        },
      );
    },
  );

  return result;
}