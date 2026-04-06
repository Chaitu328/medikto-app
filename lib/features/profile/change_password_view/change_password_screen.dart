import 'package:flutter/material.dart';
import 'package:medikto/core/utils/widgets/custom_button.dart';
import 'package:medikto/core/utils/widgets/custom_textfields.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF3D3D3D)),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.info_outline_rounded, color: Color(0xFF3D3D3D)),
          ),
        ],
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xFF3D3D3D),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.016),
                  const Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF263238),
                    ),
                  ),

                  SizedBox(height: size.height * 0.01),

                  _buildField("New Password", "Enter your new password"),
                  SizedBox(height: size.height * 0.005),

                  _buildField("Confirm Password", "Renter your new password"),
                ],
              ),
            ),
            CustomButton(
              onPressed: () => Navigator.pop(context),
              buttonColor: const Color(0xFF213598),
              buttonText: "Save Changes",
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(height: size.height * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String title, String hint) {
    return AppTextFormFieldTitled(
      title: title,
      hintText: hint,
      focusColor: Colors.black,
      fillColor: Colors.white,
      color: Colors.white,
      borderColor: const Color(0xA3555555),
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
}
