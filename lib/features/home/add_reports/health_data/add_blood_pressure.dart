import 'package:flutter/material.dart';
import 'package:medikto/core/utils/widgets/custom_appbar.dart';
import 'package:medikto/core/utils/widgets/custom_button.dart';
import 'package:medikto/features/home/add_reports/widgets/form_field_widget.dart';
import 'package:medikto/features/home/bottom_bar.dart';

class AddBloodPressureScreen extends StatefulWidget {
  const AddBloodPressureScreen({super.key});

  @override
  State<AddBloodPressureScreen> createState() => _AddBloodPressureScreenState();
}

class _AddBloodPressureScreenState extends State<AddBloodPressureScreen> {
  final List<FormFieldModel> bpFields = [
    FormFieldModel(
      title: "Systolic (max 120)",
      hint: "100",
      suffix: const Text("mmHg"),
      isRequired: true,
    ),
    FormFieldModel(
      title: "Diastolic (max 80)",
      hint: "100",
      suffix: const Text("mmHg"),
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
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Blood Pressure"),
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
                padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: RepaintBoundary(
                  child: CustomButton(
                    onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BaseBottomNavigationPage(),
                      ),
                      (route) => false,
                    ),
                    buttonText: "Add",
                    buttonColor: Color(0xFF213598),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔥 AppBar optimized
}

/// 🔥 Extracted Form Section (prevents rebuild of whole screen)
