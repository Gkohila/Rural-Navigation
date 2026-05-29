import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DepartureTimeDialog extends StatefulWidget {
  final DateTime initialTime;
  final Function(DateTime time) onTimeSelected;

  const DepartureTimeDialog({
    super.key,
    required this.initialTime,
    required this.onTimeSelected,
  });

  @override
  State<DepartureTimeDialog> createState() =>
      _DepartureTimeDialogState();
}

class _DepartureTimeDialogState
    extends State<DepartureTimeDialog> {
  late DateTime selectedTime;
  late DateTime selectedDate;

  bool isLeaveSelected = true;

  @override
  void initState() {
    super.initState();

    selectedTime = widget.initialTime;
    selectedDate = widget.initialTime;
  }

  void _goToNextDate() {
    setState(() {
      selectedDate =
          selectedDate.add(const Duration(days: 1));

      selectedTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
    });
  }

  void _goToPreviousDate() {
    setState(() {
      selectedDate =
          selectedDate.subtract(
        const Duration(days: 1),
      );

      selectedTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
    });
  }

  String _getDayLabel(DateTime date) {
    final today = DateTime.now();

    final difference = date
        .difference(
          DateTime(
            today.year,
            today.month,
            today.day,
          ),
        )
        .inDays;

    if (difference == 0) {
      return "Today";
    } else if (difference == -1) {
      return "Yesterday";
    } else if (difference == 1) {
      return "Tomorrow";
    } else {
      return DateFormat(
        "dd MMM yyyy",
      ).format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hour =
        selectedTime.hour % 12 == 0
            ? 12
            : selectedTime.hour % 12;

    final minute = selectedTime.minute;

    final isAm =
        selectedTime.hour < 12;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding:
          const EdgeInsets.symmetric(
        horizontal: 36,
      ),
      child: Container(
        padding: const EdgeInsets.only(
          top: 14,
          bottom: 18,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(32),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 46,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius:
                    BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 22),

            _buildTabs(),

            const SizedBox(height: 20),

            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
              indent: 22,
              endIndent: 22,
            ),

            const SizedBox(height: 24),

            SizedBox(
              height: 220,
              child: Stack(
                alignment: Alignment.center,
                children: [

                  Positioned(
                    top: 86,
                    left: 0,
                    right: 0,
                    child: IgnorePointer(
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [

                          _buildFixedLine(),

                          const SizedBox(width: 28),

                          _buildFixedLine(),

                          const SizedBox(width: 28),

                          _buildFixedLine(),
                        ],
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [

                      _buildPickerColumn(
                        value: hour,
                        max: 12,
                        onChanged: (val) {

                          final newHour =
                              isAm
                                  ? val % 12
                                  : (val % 12) + 12;

                          setState(() {

                            selectedTime =
                                DateTime(
                              selectedDate.year,
                              selectedDate.month,
                              selectedDate.day,
                              newHour,
                              selectedTime.minute,
                            );
                          });
                        },
                      ),

                      Padding(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Text(
                          ":",
                          style: TextStyle(
                            fontSize: 30,
                            color:
                                Colors.grey.shade600,
                            fontWeight:
                                FontWeight.w500,
                          ),
                        ),
                      ),

                      _buildPickerColumn(
                        value: minute,
                        max: 59,
                        onChanged: (val) {

                          setState(() {

                            selectedTime =
                                DateTime(
                              selectedDate.year,
                              selectedDate.month,
                              selectedDate.day,
                              selectedTime.hour,
                              val,
                            );
                          });
                        },
                      ),

                      const SizedBox(width: 10),

                      _buildAmPmColumn(
                        isAm: isAm,
                        onChanged: (am) {

                          int currentHour =
                              selectedTime.hour;

                          if (am &&
                              currentHour >= 12) {
                            currentHour -= 12;
                          } else if (!am &&
                              currentHour < 12) {
                            currentHour += 12;
                          }

                          setState(() {

                            selectedTime =
                                DateTime(
                              selectedDate.year,
                              selectedDate.month,
                              selectedDate.day,
                              currentHour,
                              selectedTime.minute,
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              margin:
                  const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                borderRadius:
                    BorderRadius.circular(18),
              ),
              child: Row(
                children: [

                  GestureDetector(
                    onTap: _goToPreviousDate,
                    child: const Icon(
                      Icons.chevron_left,
                      size: 26,
                    ),
                  ),

                  Expanded(
                    child: Center(
                      child: Text(
                        _getDayLabel(
                          selectedDate,
                        ),
                        style:
                            const TextStyle(
                          fontSize: 17,
                          fontWeight:
                              FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: _goToNextDate,
                    child: const Icon(
                      Icons.chevron_right,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            GestureDetector(
              onTap: () {

                final now = DateTime.now();

                setState(() {

                  selectedDate = now;
                  selectedTime = now;
                });
              },
              child: const Text(
                "Reset to current time",
                style: TextStyle(
                  color: Color(0xFF137A1B),
                  decoration:
                      TextDecoration.underline,
                  fontSize: 15,
                  fontWeight:
                      FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 18),

            Padding(
  padding: const EdgeInsets.fromLTRB(
    18,
    0,
    18,
    10,
  ),
              child: Row(
                children: [

                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: OutlinedButton(
                        onPressed: () {

                          Navigator.pop(
                            context,
                          );
                        },
                        style:
                            OutlinedButton.styleFrom(
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              16,
                            ),
                          ),
                          side: BorderSide(
                            color:
                                Colors.grey.shade400,
                          ),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight:
                                FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {

                          widget.onTimeSelected(
                            selectedTime,
                          );

                          Navigator.pop(
                            context,
                          );
                        },
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(
                            0xFF137A1B,
                          ),
                          elevation: 0,
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              16,
                            ),
                          ),
                        ),
                        child: const Text(
                          "Set",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight:
                                FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center,
      children: [

        GestureDetector(
          onTap: () {

            setState(() {

              isLeaveSelected = true;
            });
          },
          child: Column(
            children: [

              Text(
                "Leave",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                      FontWeight.w500,
                  color: isLeaveSelected
                      ? const Color(
                          0xFF137A1B)
                      : Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 6),

              Container(
                height: 3,
                width: 38,
                decoration: BoxDecoration(
                  color: isLeaveSelected
                      ? const Color(
                          0xFF137A1B)
                      : Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(
                    10,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 40),

        GestureDetector(
          onTap: () {

            setState(() {

              isLeaveSelected = false;

              _goToNextDate();
            });
          },
          child: Column(
            children: [

              Text(
                "Arrive",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                      FontWeight.w500,
                  color: !isLeaveSelected
                      ? const Color(
                          0xFF137A1B)
                      : Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 6),

              Container(
                height: 3,
                width: 38,
                decoration: BoxDecoration(
                  color: !isLeaveSelected
                      ? const Color(
                          0xFF137A1B)
                      : Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(
                    10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFixedLine() {
    return Container(
      width: 64,
      height: 48,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade600,
            width: 2,
          ),
          bottom: BorderSide(
            color: Colors.grey.shade600,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildPickerColumn({
    required int value,
    required int max,
    required Function(int) onChanged,
  }) {
    return SizedBox(
      width: 72,
      child:
          ListWheelScrollView.useDelegate(
        itemExtent: 44,
        diameterRatio: 1.8,
        physics:
            const FixedExtentScrollPhysics(),
        controller:
            FixedExtentScrollController(
          initialItem: value,
        ),
        onSelectedItemChanged: (index) {

          onChanged(
            index == 0 ? max : index,
          );
        },
        childDelegate:
            ListWheelChildBuilderDelegate(
          childCount: max + 1,
          builder: (context, index) {

            final displayValue =
                index == 0 ? max : index;

            final isSelected =
                displayValue == value;

            return Center(
              child: Text(
                displayValue
                    .toString()
                    .padLeft(2, '0'),
                style: TextStyle(
                  fontSize:
                      isSelected
                          ? 18
                          : 16,
                  fontWeight:
                      isSelected
                          ? FontWeight.w500
                          : FontWeight.w400,
                  color: isSelected
                      ? Colors.black
                      : Colors.grey.shade400,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAmPmColumn({
    required bool isAm,
    required Function(bool) onChanged,
  }) {

    final items = [
      "am",
      "pm",
    ];

    return SizedBox(
      width: 72,
      child:
          ListWheelScrollView.useDelegate(
        itemExtent: 44,
        diameterRatio: 1.8,
        physics:
            const FixedExtentScrollPhysics(),
        controller:
            FixedExtentScrollController(
          initialItem:
              isAm ? 0 : 1,
        ),
        onSelectedItemChanged:
            (index) {

          onChanged(index == 0);
        },
        childDelegate:
            ListWheelChildBuilderDelegate(
          childCount: items.length,
          builder: (context, index) {

            final selected =
                (isAm && index == 0) ||
                    (!isAm &&
                        index == 1);

            return Center(
              child: Text(
                items[index],
                style: TextStyle(
                  fontSize:
                      selected
                          ? 18
                          : 16,
                  fontWeight:
                      selected
                          ? FontWeight.w500
                          : FontWeight.w400,
                  color: selected
                      ? Colors.black
                      : Colors.grey.shade400,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
Future<DateTime?> showDepartureTimeDialog(
  BuildContext context,
  DateTime selectedTime,
) async {

  DateTime? result;

  await showDialog(

    context: context,

    builder: (_) {

      return DepartureTimeDialog(

        initialTime: selectedTime,

        onTimeSelected: (time) {

          result = time;
        },
      );
    },
  );

  return result;
}