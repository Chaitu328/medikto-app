import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medikto/core/utils/widgets/custom_button.dart';
import 'package:medikto/features/auth/login_view/otp_screen.dart';
import 'package:medikto/features/auth/register_view/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  bool isButtonEnabled = false;

  // Dark Mode Palette
  static const Color darkBg = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);
  static const Color accentCyan = Color(0xFF81DEEA);

  @override
  void initState() {
    super.initState();
    phoneController.addListener(() {
      final isTenDigits = phoneController.text.length == 10;
      if (isTenDigits != isButtonEnabled) {
        setState(() {
          isButtonEnabled = isTenDigits;
        });
      }
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // White icons for dark mode
      ),
      child: Scaffold(
        backgroundColor: darkBg,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.06),

                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios_new, // Modern variant
                    size: 22,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: size.height * 0.02),

                const Text(
                  "Let’s get started!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: size.height * 0.01),

                const Text(
                  "Enter your phone number. We will send you a confirmation code.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white54,
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                /// 🔹 PHONE INPUT (Dark Mode Optimized)
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      alignment: Alignment.center,
                      height: 54,
                      width: size.width * 0.22,
                      decoration: BoxDecoration(
                        color: surfaceColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.05),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Image.asset(
                              "assets/images/flag.png",
                              height: 18,
                              width: 18,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "+91",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: accentCyan,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Container(
                        height: 54,
                        decoration: BoxDecoration(
                          color: surfaceColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isButtonEnabled
                                ? accentCyan.withOpacity(0.5)
                                : Colors.white.withOpacity(0.05),
                          ),
                        ),
                        child: TextField(
                          controller: phoneController,
                          cursorColor: accentCyan,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: InputDecoration(
                            suffixIcon: phoneController.text.isNotEmpty
                                ? InkWell(
                                    onTap: () => phoneController.clear(),
                                    child: const Icon(
                                      Icons.cancel,
                                      color: Colors.white24,
                                      size: 20,
                                    ),
                                  )
                                : null,
                            hintText: "Enter mobile number",
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.white24,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.02),

                Row(
                  children: [
                    const Text(
                      "Don't have an account?  ",
                      style: TextStyle(fontSize: 14, color: Colors.white38),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                        (route) => false,
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 14,
                          color: accentCyan,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.18),

                /// 🔥 BUTTON (Cyan Branding)
                CustomButton(
                  onPressed: isButtonEnabled
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const OtpScreen(),
                            ),
                          );
                        }
                      : null,
                  buttonText: "Send OTP",
                  buttonColor: isButtonEnabled
                      ? accentCyan
                      : accentCyan.withOpacity(0.15),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isButtonEnabled ? Colors.black : Colors.white24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
