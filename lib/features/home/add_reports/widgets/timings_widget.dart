import 'package:flutter/material.dart';

class TimeModel {
  String time;
  bool isEnabled;

  TimeModel({required this.time, this.isEnabled = true});
}

class TimingsSection extends StatefulWidget {
  const TimingsSection({super.key});

  @override
  State<TimingsSection> createState() => _TimingsSectionState();
}

class _TimingsSectionState extends State<TimingsSection> {
  List<TimeModel> times = [
    TimeModel(time: "04:30 PM", isEnabled: true),
    TimeModel(time: "08:30 PM", isEnabled: false),
  ];

  TimeOfDay selectedTime = const TimeOfDay(hour: 0, minute: 0);

  /// 🔥 Pick Time
  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,

      /// 🔥 THEME CUSTOMIZATION
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF213598), // 🔵 Blue (header, buttons)
              onPrimary: Colors.white, // text on blue
              onSurface: Color(0xFF3D3D3D), // normal text
            ),

            /// 🟦 Dialog Background
            dialogBackgroundColor: Colors.white,

            /// 🔘 Buttons (OK / CANCEL)
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF213598), // button text color
              ),
            ),

            /// 🕒 Time Picker specific theme
            timePickerTheme: const TimePickerThemeData(
              backgroundColor: Colors.white,

              hourMinuteTextColor: Color(0xFF213598),
              hourMinuteColor: Color(0xFFE8ECF8),

              dayPeriodTextColor: Color(0xFF213598),
              dayPeriodColor: Color(0xFFE8ECF8),

              dialHandColor: Color(0xFF213598),
              dialBackgroundColor: Color(0xFFF5F6FA),

              entryModeIconColor: Color(0xFF213598),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  /// 🔥 Format Time
  String formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? "AM" : "PM";
    return "$hour:$minute $period";
  }

  /// 🔥 Add Time
  void _addTime() {
    setState(() {
      times.add(TimeModel(time: formatTime(selectedTime)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Timings & Alerts",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF555555),
          ),
        ),

        const SizedBox(height: 12),

        /// 🔥 Time List
        ...times.asMap().entries.map((entry) {
          // int index = entry.key;
          TimeModel item = entry.value;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                const Icon(
                  Icons.access_time,
                  size: 20,
                  color: Color(0xFFA8A8A8),
                ),
                const SizedBox(width: 6),

                Expanded(
                  child: Text(
                    item.time,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF263238),
                    ),
                  ),
                ),

                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: item.isEnabled,
                    onChanged: (value) {
                      setState(() {
                        item.isEnabled = value;
                      });
                    },

                    /// 🔵 Thumb (circle)
                    thumbColor: WidgetStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return const Color(0xFF213598); // ON thumb
                      }
                      return const Color(0xFF929292); // OFF thumb
                    }),

                    /// 🟦 Track (background)
                    trackColor: WidgetStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return const Color(
                          0xFF213598,
                        ).withAlpha(50); // ON background
                      }
                      return Colors.white; // OFF background
                    }),

                    /// 🔥 Border (important for your UI)
                    trackOutlineColor: WidgetStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return const Color(0xFF213598); // ON border
                      }
                      return const Color(0xFF929292); // OFF border
                    }),

                    trackOutlineWidth: WidgetStateProperty.all(2),
                  ),
                ),
              ],
            ),
          );
        }),

        const SizedBox(height: 10),

        /// 🔥 Add Time Label
        Row(
          children: const [
            Icon(Icons.add_circle_outline, color: Color(0xFF213598)),
            SizedBox(width: 8),
            Text(
              "Add Time",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF263238),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        /// 🔥 Time Picker + Add Button
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xD1555555), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              /// Time Picker
              Expanded(
                child: InkWell(
                  onTap: _pickTime,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      formatTime(selectedTime),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),

              /// Add Button
              ElevatedButton(
                onPressed: _addTime,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFF213598),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFffffff),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
