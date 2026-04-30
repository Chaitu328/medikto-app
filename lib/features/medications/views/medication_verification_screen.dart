import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medikto/core/utils/widgets/custom_textfields.dart';
import 'package:medikto/features/medications/views/activity_history_screen.dart';

class MedicationVerificationScreen extends StatefulWidget {
  final String medicineName;
  const MedicationVerificationScreen({super.key, required this.medicineName});

  @override
  State<MedicationVerificationScreen> createState() =>
      _MedicationVerificationScreenState();
}

class _MedicationVerificationScreenState
    extends State<MedicationVerificationScreen> {
  static const Color darkBg = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);
  static const Color accentCyan = Color(0xFF00E5FF);

  File? capturedImage;
  final ImagePicker _picker = ImagePicker();
  bool remindersEnabled = true;
  String selectedDosageAmount = "Morning"; // Default radio value
  String selectedUnit = "mg";

  final List<String> units = ["mg", "ml", "tablet", "capsule"];
  List<String> selectedDosageTimings = [];

  Future<void> _captureProofImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        capturedImage = File(image.path);
      });
    }
  }


  List<String> selectedTimings = [];

  // Add this helper method to your State class
  void _showDosageAndFrequencyPopup() {
    final options = ["Morning", "Afternoon", "Evening", "Night"];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: surfaceColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                "SELECT DOSAGE TIMINGS",
                style: TextStyle(
                  color: accentCyan,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: options.map((dose) {
                  final isSelected = selectedDosageTimings.contains(dose);

                  return CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    activeColor: accentCyan,
                    title: Text(
                      dose,
                      style: const TextStyle(color: Colors.white),
                    ),
                    value: isSelected,
                    onChanged: (value) {
                      setDialogState(() {
                        if (value == true) {
                          selectedDosageTimings.add(dose);
                        } else {
                          selectedDosageTimings.remove(dose);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {}); // 🔥 update main UI
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "SAVE",
                    style: TextStyle(
                      color: accentCyan,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "VERIFICATION PROTOCOL",
                style: TextStyle(
                  color: accentCyan,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Today's Schedule",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              /// 1. CAMERA SCANNER FRAME
              // _buildCameraFrame(),

              // const SizedBox(height: 30),

              /// 2. VERIFY BUTTON
              // ElevatedButton.icon(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: accentCyan,
              //     foregroundColor: Colors.black,
              //     minimumSize: const Size(double.infinity, 56),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(30),
              //     ),
              //   ),
              //   onPressed: () => _captureProofImage(),
              //   icon: const Icon(Icons.camera_alt),
              //   label: const Text(
              //     "Verify with Selfie",
              //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //   ),
              // ),

              // const SizedBox(height: 20),

              /// 3. LOGGING INFO
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const Icon(
              //       Icons.info_outline,
              //       color: Colors.white38,
              //       size: 14,
              //     ),
              //     const SizedBox(width: 8),
              //     const Expanded(
              //       child: Text(
              //         "AUTOMATIC DATE, TIME, AND LOCATION LOGGING ENABLED",
              //         style: TextStyle(
              //           color: Colors.white38,
              //           fontSize: 9,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 30),

              /// 📝 2. MEDICATION FORM FIELDS
              AppTextFormFieldTitled(
                titleTextStyle: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                title: "MEDICATION NAME",
                hintText: "e.g. Lisinopril",
                fillColor: surfaceColor,
                borderColor: Colors.white10,
              ),
              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: AppTextFormFieldTitled(
                      titleTextStyle: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      title: "DOSAGE",
                      hintText: "50",
                      fillColor: surfaceColor,
                      borderColor: Colors.white10,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(child: _buildDropdownField("UNIT")),
                ],
              ),
              // const SizedBox(height: 20),
              /// /// 📅 3. FREQUENCY & DOSAGE ROW
              const SizedBox(height: 20),
              _buildDosageRow(),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const SizedBox(height: 8),
              //     Text(
              //       selectedDosageAmount,
              //       style: const TextStyle(
              //         color: Colors.white,
              //         fontSize: 16,
              //       ),
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       children: [
              //         const Text(
              //           "DOSAGE",
              //           style: TextStyle(
              //             color: Colors.white54,
              //             fontSize: 12,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //         const SizedBox(height: 4),
              //         IconButton(
              //           onPressed: _showDosageAndFrequencyPopup,
              //           icon: const Icon(
              //             Icons.add_circle,
              //             color: accentCyan,
              //             size: 32,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              const SizedBox(height: 24),
              // const Text(
              //   "FREQUENCY",
              //   style: TextStyle(
              //     color: Colors.white54,
              //     fontSize: 12,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // const SizedBox(height: 10),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
              //       _buildFrequencyChip("Daily", false),
              //       _buildFrequencyChip("Every 12h", true), // Selected
              //       _buildFrequencyChip("Weekly", false),
              //       _buildFrequencyChip("As Needed", false),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 24),

              /// ⏰ 4. SCHEDULED REMINDER CARD
              _buildNotificationToggleCard(),
              const SizedBox(height: 20),

              /// 🗒️ 5. PATIENT INSTRUCTIONS
              AppTextFormFieldTitled(
                titleTextStyle: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                title: "PATIENT INSTRUCTIONS",
                hintText: "Take with food, avoid alcohol...",
                fillColor: surfaceColor,
                maxLines: 3,
                borderColor: Colors.white10,
              ),

              const SizedBox(height: 30),

              /// 🔥 6. ADD MEDICATION BUTTON
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentCyan,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // TODO: Perform Backend Save Logic Here
                  Navigator.pop(
                    context,
                  ); // Redirects back to Medications Screen
                },
                child: const Text(
                  "ADD MEDICATION",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),
              

              /// 4. RECENT ACTIVITY LIST
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "RECENT ACTIVITY",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ActivityHistoryScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "View History",
                      style: TextStyle(
                        color: accentCyan,
                        fontSize: 12,
                       
                      ),
                    ),
                  ),
                ],
              ),
              _buildActivityTile(
                "Omega-3",
                "08:30 AM • Verified",
                "TAKEN",
                Colors.teal,
              ),
              _buildActivityTile(
                "Vitamin D3",
                "11:00 AM • Pending",
                "MISSED",
                Colors.redAccent,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

Widget _buildDosageRow() {
    return GestureDetector(
      onTap: _showDosageAndFrequencyPopup,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// 🔹 LEFT → SELECTED VALUES
            Expanded(
              child: Text(
                selectedDosageTimings.isEmpty
                    ? "Select timings"
                    : selectedDosageTimings.join(", "),
                maxLines: 2,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  color: selectedDosageTimings.isEmpty
                      ? Colors.white38
                      : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            /// 🔹 RIGHT → LABEL
            const Row(
              children: [
                Text(
                  "DOSAGE",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(width: 6),
                Icon(Icons.add, color: accentCyan, size: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }


/// 🔹 Helper for the Unit Dropdown
Widget _buildDropdownField(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          // height: 54,
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.white10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              padding: EdgeInsets.zero,
              value: selectedUnit,
              dropdownColor: surfaceColor,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white54,
              ),
              style: const TextStyle(color: Colors.white, fontSize: 16),

              items: units.map((unit) {
                return DropdownMenuItem(value: unit, child: Text(unit));
              }).toList(),

              onChanged: (value) {
                setState(() {
                  selectedUnit = value!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
  /// 🔹 Helper for Frequency Chips
  // Widget _buildFrequencyChip(String label, bool isSelected) {
  //   return Container(
  //     margin: const EdgeInsets.only(right: 10),
  //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  //     decoration: BoxDecoration(
  //       color: isSelected ? accentCyan : Colors.transparent,
  //       borderRadius: BorderRadius.circular(25),
  //       border: Border.all(color: isSelected ? accentCyan : Colors.white10),
  //       boxShadow: isSelected
  //           ? [BoxShadow(color: accentCyan.withOpacity(0.3), blurRadius: 10)]
  //           : null,
  //     ),
  //     child: Text(
  //       label,
  //       style: TextStyle(
  //         color: isSelected ? Colors.black : Colors.white,
  //         fontWeight: FontWeight.bold,
  //         fontSize: 14,
  //       ),
  //     ),
  //   );
  // }

  /// 🔹 Helper for the Reminder Card
Widget _buildNotificationToggleCard() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withAlpha(14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Notifications",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18, // Slightly larger for better readability
                  fontWeight: FontWeight.w500,
                ),
              ),
              Transform.scale(
                scale: 0.8, // Slightly smaller switch to look more modern
                child: Switch(
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  padding: EdgeInsets.zero,
                  value: remindersEnabled,
                  activeThumbColor: accentCyan,
                  activeTrackColor: accentCyan.withAlpha(30),
                  inactiveThumbColor: Colors.white24,
                  inactiveTrackColor: Colors.white10,
                  onChanged: (val) => setState(() => remindersEnabled = val),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildCorner({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double angle,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          height: 30,
          width: 30,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: accentCyan, width: 3),
              left: BorderSide(color: accentCyan, width: 3),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityTile(
    String name,
    String desc,
    String status,
    Color statusColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: statusColor.withOpacity(0.1),
            child: Icon(
              name == "Omega-3" ? Icons.link : Icons.history,
              color: statusColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  desc,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: statusColor.withOpacity(0.5)),
            ),
            child: Row(
              children: [
                CircleAvatar(radius: 3, backgroundColor: statusColor),
                const SizedBox(width: 5),
                Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: darkBg,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      title: const Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.white12,
            child: Icon(Icons.person, color: Colors.white, size: 18),
          ),
          SizedBox(width: 10),
          Text(
            "Medikto",
            style: TextStyle(
              color: accentCyan,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none, color: Colors.white),
        ),
      ],
    );
  }


Widget _buildCameraFrame() {
    return Container(
      height: 280,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: capturedImage != null
            ? DecorationImage(
                image: FileImage(capturedImage!),
                fit: BoxFit.cover,
              )
            : null,
        color: surfaceColor,
      ),
      child: Stack(
        children: [
          /// 🌫 Dark overlay for better contrast
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.black.withOpacity(
                capturedImage != null ? 0.2 : 0.45,
              ),
            ),
          ),

          /// 🔥 CORNERS
          _buildCorner(top: 0, left: 0, angle: 0),
          _buildCorner(top: 0, right: 0, angle: 1.57),
          _buildCorner(bottom: 0, left: 0, angle: 4.71),
          _buildCorner(bottom: 0, right: 0, angle: 3.14),

          /// 📷 CENTER CONTENT
          if (capturedImage == null)
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, color: Colors.white54, size: 55),
                  SizedBox(height: 10),
                  Text(
                    "Tap to capture proof",
                    style: TextStyle(
                      color: Colors.white54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

          // /// 📌 BOTTOM INSTRUCTION
          // Positioned(
          //   bottom: 18,
          //   left: 18,
          //   right: 18,
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(
          //       horizontal: 16,
          //       vertical: 10,
          //     ),
          //     decoration: BoxDecoration(
          //       color: Colors.black.withOpacity(0.6),
          //       borderRadius: BorderRadius.circular(16),
          //       border: Border.all(
          //         color: const Color(0xFF00E5FF).withOpacity(0.4),
          //       ),
          //     ),
          //     child: const Text(
          //       "Tap to capture proof of medication",
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //         color: Color(0xFF00E5FF),
          //         fontSize: 12,
          //         fontWeight: FontWeight.w600,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }


}
