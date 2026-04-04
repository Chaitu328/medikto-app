import 'package:flutter/material.dart';

class _GenderOption extends StatelessWidget {
  final String text;
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;

  const _GenderOption({
    required this.text,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(20),
      child: Row(
        children: [
          /// 🔥 Custom Radio (same size)
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: isSelected
                    ? const Color(0xFF213598) // 🔵 selected border
                    : const Color(0x8A555555),
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF213598), // 🔵 inner dot
                      ),
                    ),
                  )
                : null,
          ),

          const SizedBox(width: 6),

          /// 🔹 Text (same style)
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0x8A555555),
            ),
          ),
        ],
      ),
    );
  }
}

class GenderSection extends StatefulWidget {
  const GenderSection();

  @override
  State<GenderSection> createState() => _GenderSectionState();
}

class _GenderSectionState extends State<GenderSection> {
  String selectedGender = "Male"; // default

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Gender",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF555555),
          ),
        ),
        const SizedBox(height: 8),

        Row(
          children: [
            _GenderOption(
              text: "Male",
              value: "Male",
              groupValue: selectedGender,
              onChanged: (val) {
                setState(() => selectedGender = val);
              },
            ),
            const SizedBox(width: 16),
            _GenderOption(
              text: "Female",
              value: "Female",
              groupValue: selectedGender,
              onChanged: (val) {
                setState(() => selectedGender = val);
              },
            ),
          ],
        ),
      ],
    );
  }
}