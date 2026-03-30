// 🔥 Extracted widget (reduces rebuild cost)
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final int index;
  final Map<String, String> data;
  final Size size;
  final ValueNotifier<int> currentIndex;
  final int total;
  final PageController controller;

  const OnboardingPage({
    required this.index,
    required this.data,
    required this.size,
    required this.currentIndex,
    required this.total,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        index == 1 || index == 2
            ? SizedBox(height: size.height * 0.06)
            : const SizedBox.shrink(),

        index == 1 || index == 2
            ? Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    if (index > 0) {
                      controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_back_ios, size: 24),
                ),
              )
            : const SizedBox.shrink(),

        index == 1 || index == 2
            ? SizedBox(height: size.height * 0.06)
            : const SizedBox.shrink(),

        Text(
          data["title"]!,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Color(0xFF263238),
            letterSpacing: 0.5,
          ),
        ),

        SizedBox(height: size.height * 0.005),

        Text(
          data["desc"]!,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF8B8B8B),
          ),
        ),

        Image.asset(data["image"]!),

        SizedBox(height: size.height * 0.02),

        ValueListenableBuilder<int>(
          valueListenable: currentIndex,
          builder: (_, current, __) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                total,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 10,
                  width: current == i ? 26 : 10,
                  decoration: BoxDecoration(
                    color: current == i
                        ? const Color(0xFF213598)
                        : const Color(0xFFDDDDDD),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
