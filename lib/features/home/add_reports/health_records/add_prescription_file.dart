import 'package:flutter/material.dart';
import 'package:medikto/core/utils/widgets/custom_appbar.dart';
import 'package:medikto/core/utils/widgets/custom_button.dart';
import 'package:medikto/core/utils/widgets/custom_textfields.dart';
import 'package:medikto/features/home/add_reports/widgets/timings_widget.dart';
import 'package:medikto/features/home/bottom_bar.dart';
import 'package:medikto/features/reports/widgets/reports_action_sheet.dart';

class AddPrescriptionFileScreen extends StatefulWidget {
  const AddPrescriptionFileScreen({super.key});

  @override
  State<AddPrescriptionFileScreen> createState() => _AddPrescriptionFileScreenState();
}

class _AddPrescriptionFileScreenState extends State<AddPrescriptionFileScreen> {
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      constraints: BoxConstraints(maxWidth: double.infinity),
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => ReportActionsSheet(
        actions: [
          {"icon": Icons.photo, "title": "Choose from Gallery"},
          {"icon": Icons.camera_alt, "title": "Take a Photo"},
          {"icon": Icons.insert_drive_file, "title": "choose PDF files"},
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Prescription File"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            /// 🔹 FORM AREA
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.016),

                    /// 🔹 NAME FIELD
                    _buildTextField(
                      title: "Medicine Name",
                      hint: "Enter medicine name",
                    ),

                    /// 🔹 DESCRIPTION
                    _buildTextField(
                      title: "Dosage of Medication",
                      hint: "Enter your dosage, timings, others",
                    ),
                    SizedBox(height: size.height * 0.02),

                    const TimingsSection(),
                    SizedBox(height: size.height * 0.02),

                    /// 🔹 UPLOAD IMAGE
                    GestureDetector(
                      onTap: () => _showBottomSheet(context),
                      child: Center(
                        child: Image.asset(
                          "assets/images/upload-file.png",
                          width: size.width * 0.85,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.04),

                    /// 🔹 ADD MEDICATION CARD
                    _buildAddMedicationCard(),

                    SizedBox(height: size.height * 0.05),
                  ],
                ),
              ),
            ),

            /// 🔹 BUTTON
            CustomButton(
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const BaseBottomNavigationPage(),
                ),
                (route) => false,
              ),
              buttonColor: Color(0xFF213598),
              buttonText: "Add Report",
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFFffffff),
              ),
            ),

            SizedBox(height: size.height * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String title,
    required String hint,
    int maxLines = 1,
    Color borderColor = const Color(0xA3555555),
    Widget? suffix,
  }) {
    return AppTextFormFieldTitled(
      title: title,
      hintText: hint,
      maxLines: maxLines,
      borderColor: borderColor,
      focusColor: Colors.black,
      fillColor: Colors.white,
      color: Colors.white,
      suffix: suffix,
      hintStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xA3555555),
      ),
      titleTextStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Color(0xFF555555),
      ),
    );
  }

  Widget _buildAddMedicationCard() {
    return Container(
      // padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFECF4FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  "assets/images/item2.png",
                  color: const Color(0xFF213598),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Add Medication",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF263238),
                ),
              ),
            ],
          ),
          const Icon(Icons.add_circle, color: Color(0xFF213598), size: 40),
        ],
      ),
    );
  }
}
