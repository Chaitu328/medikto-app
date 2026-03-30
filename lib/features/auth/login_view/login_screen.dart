import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medikto/core/utils/widgets/custom_button.dart';
import 'package:medikto/features/auth/login_view/otp_screen.dart';
import 'package:medikto/features/auth/register_view/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context); // ✅ cache once
    final TextEditingController phoneController = TextEditingController();

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

              InkWell(
                onTap: () => Navigator.pop(context), // ✅ simple back navigation
                child: const Icon(
                  Icons.arrow_back,
                  size: 24,
                  color: Color(0xFF000000),
                ),
              ),

              SizedBox(height: size.height * 0.02),

              const Text(
                "Let’s get started!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF000000),
                ),
              ),

              SizedBox(height: size.height * 0.01),

              const Text(
                "Enter your phone number. we will send you confirmation code here",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF5F6368),
                ),
              ),

              SizedBox(height: size.height * 0.04),

              /// 🔹 PHONE INPUT
              Row(
                children: [
                  /// 🔹 COUNTRY CODE
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    alignment: Alignment.center,
                    height: 54,
                    width: size.width * 0.2, // ✅ responsive
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDEFF3),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Image.asset(
                            "assets/images/flag.png",
                            height: 20,
                            width: 20,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          "+91",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF000000),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  /// 🔹 MOBILE FIELD
                  Expanded(
                    child: Container(
                      height: 54,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDEFF3),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: TextField(
                        controller: phoneController,
                        cursorColor: Color(0xFF000000),
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF000000),
                        ),
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () => phoneController.clear(),
                            child: Icon(
                              Icons.close,
                              size: 24,
                              color: Color(0xFF000000),
                            ),
                          ),
                          hintText: "Enter mobile number",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF5F6368),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.02),

              /// 🔹 REGISTER TEXT
              Row(
                children: [
                  Text(
                    "Don't have an account?  ",
                    style: TextStyle(fontSize: 16, color: Color(0xFF7D7D7D)),
                  ),
                  InkWell(
                    onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                      (route) => false,
                    ),

                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 16, color: Color(0xFF213598)),
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.18),

              /// 🔥 BUTTON
              CustomButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const OtpScreen()),
                  );
                },
                buttonText: "Send OTP",
                buttonColor: const Color(0xFF213598),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
