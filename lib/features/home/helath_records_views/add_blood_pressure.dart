import 'package:flutter/material.dart';
import 'package:medikto/core/utils/widgets/custom_button.dart';
import 'package:medikto/core/utils/widgets/custom_textfields.dart';
import 'package:medikto/features/home/bottom_bar.dart';

class AddBloodPressureScreen extends StatefulWidget {
  const AddBloodPressureScreen({super.key});

  @override
  State<AddBloodPressureScreen> createState() => _AddBloodPressureScreenState();
}

class _AddBloodPressureScreenState extends State<AddBloodPressureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
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
                      child: const _FormSection(),
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
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF3D3D3D)),
      ),
      title: const Text(
        "Blood Pressure",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color(0xFF3D3D3D),
        ),
      ),
    );
  }
}

/// 🔥 Extracted Form Section (prevents rebuild of whole screen)
class _FormSection extends StatelessWidget {
  const _FormSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.016),

        /// 🔹 Systolic
        const AppTextFormFieldTitled(
          hintText: "100",
          title: "Systolic (max 120)*",
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
          suffix: Text(
            "mmHg",
            style: TextStyle(fontSize: 16, color: Color(0xA3555555)),
          ),
        ),

        /// 🔹 Diastolic
        const AppTextFormFieldTitled(
          hintText: "100",
          title: "Diastolic (max 80)*",
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
          suffix: Text(
            "mmHg",
            style: TextStyle(fontSize: 16, color: Color(0xA3555555)),
          ),
        ),

        /// 🔹 Date & Time Row (Responsive)
        Row(
          children: const [
            Expanded(
              child: AppTextFormFieldTitled(
                hintText: "DD.MM.YY",
                title: "Date*",
                borderColor: Colors.black,
                fillColor: Colors.white,
                color: Color(0xA3555555),
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Color(0xA3555555),
                  fontWeight: FontWeight.w400,
                ),
                titleTextStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF555555),
                ),
                suffix: Icon(
                  Icons.calendar_month_outlined,
                  color: Color(0xA3555555),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: AppTextFormFieldTitled(
                hintText: "00 : 00",
                title: "Time*",
                borderColor: Color(0xA3555555),
                fillColor: Colors.white,
                color: Color(0xA3555555),
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Color(0xA3555555),
                  fontWeight: FontWeight.w400,
                ),
                titleTextStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF555555),
                ),
                suffix: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Color(0xA3555555),
                ),
              ),
            ),
          ],
        ),

        /// 🔹 Notes
        const AppTextFormFieldTitled(
          maxLines: 4,
          hintText: "Enter your notes, others",
          borderColor: Color(0xA3555555),
          focusColor: Colors.black,
          fillColor: Colors.white,
          color: Colors.white,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xA3555555),
          ),
          title: "Notes",
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF555555),
          ),
        ),

        /// 🔥 Bottom spacing (instead of MediaQuery)
        const SizedBox(height: 120),
      ],
    );
  }
}
