import 'package:flutter/material.dart';
import 'package:medikto/core/utils/widgets/custom_button.dart';
import 'package:medikto/features/auth/login_view/login_screen.dart';
import 'package:medikto/features/auth/register_view/register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context); // ✅ cache once

    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              /// 🔹 TOP CONTENT
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.16),

                    const Text(
                      "Welcome to Medikto",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF263238),
                        letterSpacing: 0.5,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      "Stay healthy. Stay secure.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8B8B8B),
                      ),
                    ),

                    SizedBox(height: size.height * 0.04),

                    /// 🔥 Responsive Image
                    Flexible(
                      child: Image.asset(
                        'assets/images/public-health-amico.png',
                        width: size.width * 0.7,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),

              /// 🔥 STICKY BUTTONS
              Padding(
                padding: const EdgeInsets.only(bottom: 30, top: 10),
                child: Column(
                  children: [
                    CustomButton(
                      buttonColor: const Color(0xFFFFFFFF),
                      border: Border.all(
                        color: const Color(0xFF213598),
                        width: 1,
                      ),
                      height: 54,
                      buttonText: "Login",
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF213598),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    CustomButton(
                      buttonColor: const Color(0xFF213598),
                      height: 54,
                      buttonText: "Register",
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFFFFFF),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
