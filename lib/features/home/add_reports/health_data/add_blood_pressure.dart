import 'package:flutter/material.dart';
import 'package:medikto/core/utils/widgets/custom_appbar.dart';
import 'package:medikto/core/utils/widgets/custom_button.dart';
import 'package:medikto/features/home/add_reports/widgets/form_field_widget.dart';
import 'package:medikto/bottom_bar.dart';

class AddBloodPressureScreen extends StatefulWidget {
  const AddBloodPressureScreen({super.key});

  @override
  State<AddBloodPressureScreen> createState() => _AddBloodPressureScreenState();
}

class _AddBloodPressureScreenState extends State<AddBloodPressureScreen> {
  // Theme Palette
  static const Color darkBg = Color(0xFF121212);
  static const Color accentCyan = Color(0xFF81DEEA);

  final List<FormFieldModel> bpFields = [
    FormFieldModel(
      title: "Systolic (max 120)",
      hint: "100",
      suffix: const Text(
        "mmHg",
        style: TextStyle(color: Colors.white54, fontSize: 12),
      ),
      isRequired: true,
    ),
    FormFieldModel(
      title: "Diastolic (max 80)",
      hint: "80",
      suffix: const Text(
        "mmHg",
        style: TextStyle(color: Colors.white54, fontSize: 12),
      ),
      isRequired: true,
    ),
    FormFieldModel(
      title: "",
      hint: "",
      isRow: true,
      isRequired: true,
    ), // Date & Time
    FormFieldModel(
      title: "Notes",
      hint: "Enter your notes",
      maxLines: 4,
      isRequired: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      
      appBar: CustomAppBar(
        title: "Blood Pressure",
        onBack: () => Navigator.pop(context),
        backgroundColor: darkBg,
        titleStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),

      ),
      body: SafeArea(
        child: Column(
          children: [
            /// 🔥 Scroll Area
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      // NOTE: Ensure DynamicFormSection/FormFieldWidget 
                      // internally handles Dark Mode colors for TextFields
                      child: DynamicFormSection(fields: bpFields),
                    ),
                  );
                },
              ),
            ),

            /// 🔥 Bottom Button (Fixed)
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: RepaintBoundary(
                  child: CustomButton(
                    onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BaseBottomNavigationPage(),
                      ),
                      (route) => false,
                    ),
                    buttonText: "Add Record",
                    buttonColor: accentCyan, // Brighter for Dark Mode
                    textStyle: const TextStyle(
                      color: Colors.black, // High contrast
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
