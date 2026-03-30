import 'package:flutter/material.dart';
import 'package:medikto/features/home/bottom_bar.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final OtpFieldController otpController = OtpFieldController();

  bool _loading = false;
  String enteredOtp = "";

  @override
  void dispose() {
    otpController.clear(); // ✅ cleanup
    super.dispose();
  }

  Future<void> _verifyOtp() async {
    if (_loading) return; // ✅ prevent multiple calls

    setState(() => _loading = true);

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return; // ✅ avoid context crash

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const BaseBottomNavigationPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context); // ✅ cache once

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(), // ✅ smooth scroll
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.06),

              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back,
                  size: 24,
                  color: Color(0xFF000000),
                ),
              ),

              SizedBox(height: size.height * 0.02),

              const Text(
                "6-digit code",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF000000),
                ),
              ),

              SizedBox(height: size.height * 0.01),

              const Text(
                "Code sent to +91 9701222010 unless you already have account",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF5F6368),
                ),
              ),

              SizedBox(height: size.height * 0.04),

              /// 🔹 OTP FIELD
              SizedBox(
                width: double.infinity,
                child: OTPTextField(
                  length: 6,
                  fieldWidth: size.width * 0.11, // ✅ responsive
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 6,
                  style: const TextStyle(
                    fontSize: 26,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  otpFieldStyle: OtpFieldStyle(
                    disabledBorderColor: Colors.transparent,
                    backgroundColor: Color(0xFFEDEFF3),
                    borderColor: Colors.transparent,
                    focusBorderColor: Colors.transparent,
                    enabledBorderColor: Colors.transparent,
                  ),
                  onCompleted: (pin) {
                    enteredOtp = pin;
                    _verifyOtp();
                  },
                ),
              ),

              SizedBox(height: size.height * 0.02),

              const Text(
                "No code received?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF213598),
                ),
              ),

              SizedBox(height: size.height * 0.14),
            ],
          ),
        ),
      ),
    );
  }
}
