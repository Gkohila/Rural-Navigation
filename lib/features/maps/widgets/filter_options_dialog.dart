// ======================================
// filter_options_dialog.dart
// ======================================

import 'package:flutter/material.dart';

class FilterOptionsDialog extends StatefulWidget {

  final Function(String selectedFilter) onApply;

  const FilterOptionsDialog({
    super.key,
    required this.onApply,
  });

  @override
  State<FilterOptionsDialog> createState() =>
      _FilterOptionsDialogState();
}

class _FilterOptionsDialogState
    extends State<FilterOptionsDialog> {

  String selectedFilter = "Best route";

  @override
  Widget build(BuildContext context) {

    return Material(

      color: Colors.transparent,

      child: Center(

        child: Container(

          width: 320,

          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(

            color: Colors.white,

            borderRadius:
                BorderRadius.circular(32),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              // TOP HANDLE
              Container(
                width: 40,
                height: 4,

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,

                  borderRadius:
                      BorderRadius.circular(20),
                ),
              ),

              const SizedBox(height: 20),

              // HEADER
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [

                  const Text(
                    "Filter options",

                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  InkWell(

                    onTap: () {
                      Navigator.pop(context);
                    },

                    borderRadius:
                        BorderRadius.circular(50),

                    child: const Padding(
                      padding: EdgeInsets.all(4),

                      child: Icon(
                        Icons.close,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // OPTION 1
              _optionTile(

                title: "Best route",

                icon: Icons.star,

                selected:
                    selectedFilter ==
                        "Best route",

                onTap: () {

                  setState(() {
                    selectedFilter =
                        "Best route";
                  });
                },
              ),

              const SizedBox(height: 10),

              // OPTION 2
              _optionTile(

                title: "Fewer transfers",

                icon: Icons.compare_arrows,

                selected:
                    selectedFilter ==
                        "Fewer transfers",

                onTap: () {

                  setState(() {
                    selectedFilter =
                        "Fewer transfers";
                  });
                },
              ),

              const SizedBox(height: 10),

              // OPTION 3
              _optionTile(

                title: "Less walking",

                icon: Icons.directions_walk,

                selected:
                    selectedFilter ==
                        "Less walking",

                onTap: () {

                  setState(() {
                    selectedFilter =
                        "Less walking";
                  });
                },
              ),

              const SizedBox(height: 24),

              // APPLY BUTTON
              SizedBox(

                width: double.infinity,
                height: 52,

                child: ElevatedButton(

                  onPressed: () {

                    widget.onApply(
                      selectedFilter,
                    );

                    Navigator.pop(context);
                  },

                  style: ElevatedButton.styleFrom(

                    backgroundColor:
                        const Color(0xFF1B5E20),

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(40),
                    ),
                  ),

                  child: const Text(
                    "Apply Filters",

                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _optionTile({
    required String title,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {

    return InkWell(

      onTap: onTap,

      borderRadius:
          BorderRadius.circular(18),

      child: Container(

        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),

        decoration: BoxDecoration(

          color: selected
              ? const Color(0xFF1B5E20)
                  .withOpacity(0.08)
              : Colors.white,

          borderRadius:
              BorderRadius.circular(18),

          border: Border.all(

            color: selected
                ? const Color(0xFF1B5E20)
                : Colors.transparent,

            width: 2,
          ),
        ),

        child: Row(

          children: [

            // ICON
            Container(

              width: 42,
              height: 42,

              decoration: BoxDecoration(

                color: selected
                    ? const Color(0xFF1B5E20)
                        .withOpacity(0.12)
                    : Colors.grey.shade100,

                shape: BoxShape.circle,
              ),

              child: Icon(

                icon,

                color: selected
                    ? const Color(0xFF1B5E20)
                    : Colors.grey.shade700,
              ),
            ),

            const SizedBox(width: 14),

            // TITLE
            Expanded(
              child: Text(

                title,

                style: TextStyle(

                  fontSize: 17,

                  fontWeight: selected
                      ? FontWeight.bold
                      : FontWeight.w500,
                ),
              ),
            ),

            // RADIO
            Container(

              width: 24,
              height: 24,

              decoration: BoxDecoration(

                shape: BoxShape.circle,

                border: Border.all(

                  color: selected
                      ? const Color(0xFF1B5E20)
                      : Colors.grey.shade400,

                  width: 2,
                ),
              ),

              child: selected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,

                        decoration:
                            const BoxDecoration(
                          color: Color(0xFF1B5E20),
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}