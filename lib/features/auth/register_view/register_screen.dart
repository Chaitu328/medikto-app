import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medikto/core/utils/widgets/custom_button.dart';
import 'package:medikto/core/utils/widgets/custom_textfields.dart';
import 'package:medikto/features/auth/register_view/account_create_success.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context); // ✅ cache once

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              /// 🔹 SCROLLABLE CONTENT
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(), // ✅ smooth scroll
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
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF263238),
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Center(
                        child: Text(
                          "Start your healthy journey with simple details.",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF8B8B8B),
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
            color: Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.person, size: 60, color: Colors.grey.shade400),
        ),
        Positioned(
          bottom: 10,
          right: 0,
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.edit, size: 16, color: Color(0xFF7D7D7D)),
          ),
        ),
      ],
    );
  }
}

class _FormFields extends StatelessWidget {
  const _FormFields();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildField("Full Name", "Enter your full name"),
        SizedBox(height: size.height * 0.005),

        _buildField("Contact", "+91 - "),
        SizedBox(height: size.height * 0.005),

        /// 🔹 DOB + GENDER
        Row(
          children: [
            Expanded(child: _buildField("DOB", "DD/MM/YYYY")),
            SizedBox(width: size.width * 0.04),
            const Expanded(child: _GenderSection()),
          ],
        ),

        SizedBox(height: size.height * 0.005),

        _buildField("Aadhar Number", "0000 0000 0000"),

        SizedBox(height: size.height * 0.04),

        const Text(
          "Password",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Color(0xFF263238),
          ),
        ),

        SizedBox(height: size.height * 0.005),

        _buildField("New Password", "Enter your new password"),
        SizedBox(height: size.height * 0.005),

        _buildField("Confirm Password", "Renter your new password"),
      ],
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

class _GenderSection extends StatelessWidget {
  const _GenderSection();

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
          children: const [
            _GenderOption("Male"),
            SizedBox(width: 16),
            _GenderOption("Female"),
          ],
        ),
      ],
    );
  }
}

class _GenderOption extends StatelessWidget {
  final String text;

  const _GenderOption(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2, color: Color(0x8A555555)),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(fontSize: 16, color: Color(0x8A555555)),
        ),
      ],
    );
  }
}

class _BottomSection extends StatelessWidget {
  final Size size;

  const _BottomSection({required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AccountCreateSuccess()),
            );
          },
          buttonText: "Continue",
          buttonColor: const Color(0xFF213598),
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFFFFFFFF),
          ),
        ),

        SizedBox(height: size.height * 0.01),

        const Text.rich(
          TextSpan(
            text: "By signing In , I agree to health safe ",
            style: TextStyle(fontSize: 12, color: Color(0xFF8E98A8)),
            children: [
              TextSpan(
                text: "Terms of use ",
                style: TextStyle(color: Color(0xFF213598)),
              ),
              TextSpan(text: "and "),
              TextSpan(
                text: "Privacy Policy",
                style: TextStyle(color: Color(0xFF213598)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
