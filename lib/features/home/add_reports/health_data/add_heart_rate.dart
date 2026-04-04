import 'package:flutter/material.dart';
import 'package:medikto/core/utils/widgets/custom_appbar.dart';
import 'package:medikto/core/utils/widgets/custom_button.dart';
import 'package:medikto/features/home/add_reports/widgets/form_field_widget.dart';
import 'package:medikto/features/home/bottom_bar.dart';

class AddHeartRateScreen extends StatefulWidget {
  const AddHeartRateScreen({super.key});

  @override
  State<AddHeartRateScreen> createState() => _AddHeartRateScreenState();
}

class _AddHeartRateScreenState extends State<AddHeartRateScreen> {
  final List<FormFieldModel> hrFields = [
    FormFieldModel(title: "Heart Rate", hint: "72", suffix: const Text("BPM"),isRequired: true),
    FormFieldModel(title: "", hint: "", isRow: true, isRequired: true),
    FormFieldModel(
      title: "Notes",
      hint: "Enter your notes, others",
      maxLines: 3,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Heart Rate"),
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
                      child: DynamicFormSection(fields: hrFields),
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

 }
