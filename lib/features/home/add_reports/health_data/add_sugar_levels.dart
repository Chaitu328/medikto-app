import 'package:flutter/material.dart';
import 'package:medikto/core/utils/widgets/custom_appbar.dart';
import 'package:medikto/core/utils/widgets/custom_button.dart';
import 'package:medikto/features/home/add_reports/widgets/form_field_widget.dart';
import 'package:medikto/bottom_bar.dart';

class AddSugarLevelsScreen extends StatefulWidget {
  const AddSugarLevelsScreen({super.key});

  @override
  State<AddSugarLevelsScreen> createState() => _AddSugarLevelsScreenState();
}

class _AddSugarLevelsScreenState extends State<AddSugarLevelsScreen> {
  // Dark Mode Palette
  static const Color darkBg = Color(0xFF121212);
  static const Color accentCyan = Color(0xFF81DEEA);

  final List<FormFieldModel> slFields = [
    FormFieldModel(
      title: "RBS Value",
      hint: "Enter RBS value",
      suffix: const Text(
        "mg/dL",
        style: TextStyle(
          color: Colors.white54,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      isRequired: true,
    ),
    FormFieldModel(title: "", hint: "", isRow: true, isRequired: true),
    FormFieldModel(
      title: "Notes",
      hint: "Enter your notes, others",
      maxLines: 3,
      isRequired: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: CustomAppBar(
        title: "Sugar Levels",
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
                      // Since DynamicFormSection is updated for dark mode, 
                      // it will render correctly here.
                      child: DynamicFormSection(fields: slFields),
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
                    onPressed: () {
                      if (!mounted) return;
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BaseBottomNavigationPage(),
                        ),
                        (route) => false,
                      );
                    },
                    buttonText: "Add Record",
                    buttonColor: accentCyan, // Switched to Cyan for Dark Mode
                    textStyle: const TextStyle(
                      color: Colors.black, // High contrast black text on Cyan
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
