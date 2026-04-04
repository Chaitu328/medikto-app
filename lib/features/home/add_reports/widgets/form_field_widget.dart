import 'package:flutter/material.dart';
import 'package:medikto/core/utils/widgets/custom_textfields.dart';

class FormFieldModel {
  final String title;
  final String hint;
  final Widget? suffix;
  final int maxLines;
  final bool isRow;
  final bool isRequired; // ✅ NEW

  FormFieldModel({
    required this.title,
    required this.hint,
    this.suffix,
    this.maxLines = 1,
    this.isRow = false,
    this.isRequired = false, // default optional
  });
}

class DynamicFormSection extends StatelessWidget {
  final List<FormFieldModel> fields;

  const DynamicFormSection({super.key, required this.fields});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),

        ...fields.map((field) {
          /// 🔥 Special case (Row → Date & Time)
          ///
          if (field.isRow) {
            return Row(
              children: [
                Expanded(
                  child: AppTextFormFieldTitled(
                    isRequired: field.isRequired,
                    borderColor: Color(0xA3555555),
                    focusColor: Colors.black,
                    fillColor: Colors.white,
                    color: Colors.white,
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xA3555555),
                    ),
                    titleTextStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF555555),
                    ),
                    hintText: "DD.MM.YY",
                    title: "Date",
                    suffix: Icon(
                      Icons.calendar_month_outlined,
                      color: Color(0xA3555555),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppTextFormFieldTitled(
                    isRequired: field.isRequired,
                    borderColor: Color(0xA3555555),
                    focusColor: Colors.black,
                    fillColor: Colors.white,
                    color: Colors.white,
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xA3555555),
                    ),
                    titleTextStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF555555),
                    ),
                    hintText: "00:00",
                    title: "Time",
                    suffix: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: Color(0xA3555555),
                    ),
                  ),
                ),
              ],
            );
          }

          /// 🔥 Normal Field
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppTextFormFieldTitled(
              isRequired: field.isRequired,
              borderColor: Color(0xA3555555),
              focusColor: Colors.black,
              fillColor: Colors.white,
              color: Colors.white,
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xA3555555),
              ),
              titleTextStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF555555),
              ),
              title: field.title,
              hintText: field.hint,
              maxLines: field.maxLines,
              suffix: field.suffix,
            ),
          );
        }).toList(),

        const SizedBox(height: 40),
      ],
    );
  }
}
