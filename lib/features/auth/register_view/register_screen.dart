import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medikto/core/utils/widgets/custom_button.dart';
import 'package:medikto/core/utils/widgets/custom_textfields.dart';
import 'package:medikto/features/auth/register_view/account_create_success.dart';
import 'package:medikto/features/auth/widgets/gender_selection_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  // Dark Mode Palette
  static const Color darkBg = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);
  static const Color accentCyan = Color(0xFF81DEEA);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // White icons for dark mode
      ),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
          backgroundColor: darkBg,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                /// 🔹 SCROLLABLE CONTENT
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.04),

                        /// 🔹 TITLE
                        const Center(
                          child: Text(
                            "Your journey starts here",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
        
                        const SizedBox(height: 8),

                        const Center(
                          child: Text(
                            "Start your healthy journey with simple details.",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white54,
                            ),
                          ),
                        ),

                        SizedBox(height: size.height * 0.04),

                        /// 🔹 PROFILE IMAGE
                        const Center(child: _ProfileAvatar()),

                        SizedBox(height: size.height * 0.04),

                        /// 🔹 FORM FIELDS
                        const _FormFields(),

                        SizedBox(height: size.height * 0.02),
                      ],
                    ),
                  ),
                ),

                /// 🔥 BOTTOM SECTION
                _BottomSection(size: size),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: const Color(0xFF252525),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white10, width: 2),
          ),
          child: const Icon(Icons.person, size: 60, color: Colors.white24),
        ),
        Positioned(
          bottom: 10,
          right: 0,
          child: Container(
            height: 32,
            width: 32,
            decoration: const BoxDecoration(
              color: Color(0xFF81DEEA), // Brand Cyan
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.edit, size: 16, color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class _FormFields extends StatelessWidget {
  const _FormFields();

  static const Color surfaceColor = Color(0xFF1E1E1E);
  static const Color accentCyan = Color(0xFF81DEEA);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildField("Full Name", "Enter your full name"),
        SizedBox(height: size.height * 0.01),
        
        AppTextFormFieldTitled(
          title: "Contact",
          hintText: "Enter phone number",
          focusColor: accentCyan,
          fillColor: surfaceColor,
          color: Colors.white,
          textInputType: TextInputType.phone,
          prefix: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "+91",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: accentCyan,
              ),
            ),
          ),
          borderColor: Colors.white10,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white24,
          ),
          titleTextStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white70,
          ),
        ),

        SizedBox(height: size.height * 0.01),

        /// 🔹 DOB + GENDER
        Row(
          children: [
            Expanded(child: _buildField("DOB", "DD/MM/YYYY")),
            SizedBox(width: size.width * 0.04),
            const Expanded(
              child: GenderSection(),
            ), // Ensure internal widget is dark
          ],
        ),

        SizedBox(height: size.height * 0.01),

        _buildField("Aadhar Number", "0000 0000 0000"),

        SizedBox(height: size.height * 0.04),

        const Text(
          "Security",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        SizedBox(height: size.height * 0.01),

        _buildField("New Password", "Enter your new password"),
        SizedBox(height: size.height * 0.01),

        _buildField("Confirm Password", "Re-enter your new password"),
      ],
    );
  }

  Widget _buildField(String title, String hint) {
    return AppTextFormFieldTitled(
      title: title,
      hintText: hint,
      focusColor: accentCyan,
      fillColor: surfaceColor,
      color: Colors.white,
      borderColor: Colors.white10,
      hintStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white24,
      ),
      titleTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
      ),
    );
  }
}

class _BottomSection extends StatelessWidget {
  final Size size;

  const _BottomSection({required this.size});

  @override
  Widget build(BuildContext context) {
    const Color accentCyan = Color(0xFF81DEEA);

    return Column(
      children: [
        CustomButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AccountCreateSuccess()),
            );
          },
          buttonText: "Create Account",
          buttonColor: accentCyan,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        SizedBox(height: size.height * 0.02),

        const Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            text: "By signing up, I agree to health safe ",
            style: TextStyle(fontSize: 11, color: Colors.white38),
            children: [
              TextSpan(
                text: "Terms of use ",
                style: TextStyle(
                  color: accentCyan,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: "and "),
              TextSpan(
                text: "Privacy Policy",
                style: TextStyle(
                  color: accentCyan,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // SizedBox(height: size.height * 0.01),
      ],
    );
  }
}
