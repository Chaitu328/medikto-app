import 'package:flutter/material.dart';

class ReportActionsSheet extends StatelessWidget {
  final List<Map<String, dynamic>> actions;

  const ReportActionsSheet({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),

          // 🔹 Top Handle
          Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFCCCCCC),
              borderRadius: BorderRadius.circular(100),
            ),
          ),

          const SizedBox(height: 20),

          /// 🔥 Dynamic List
          ...List.generate(actions.length, (index) {
            final item = actions[index];

            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              minLeadingWidth: 0,
              horizontalTitleGap: 16,
              minVerticalPadding: 12,

              leading: Icon(item["icon"], color: const Color(0xFF213598)),
              title: Text(
                item["title"],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF090A0A),
                ),
              ),
              onTap: item["onTap"], // optional
            );
          }),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
        ],
      ),
    );
  }
}
