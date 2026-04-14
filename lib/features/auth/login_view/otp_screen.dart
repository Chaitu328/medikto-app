import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medikto/features/home/bottom_bar.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _loading = false;
  String enteredOtp = "";

  // Dark Mode Palette
  static const Color darkBg = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);
  static const Color accentCyan = Color(0xFF81DEEA);

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _verifyOtp() async {
    if (_loading) return;
    setState(() => _loading = true);

    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const BaseBottomNavigationPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    // ✅ Dark Mode Pin Theme
    final defaultPinTheme = PinTheme(
      width: size.width * 0.12,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 24,
        color: Colors.white, // White text for visibility
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: surfaceColor, // Darker input boxes
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
    );

    // Highlight the active box with Cyan
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: accentCyan, width: 1.5),
      ),
    );

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

                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios_new, // Modern icon variant
                    size: 22,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: size.height * 0.02),

                const Text(
                  "6-digit code",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Code sent to +91 9701222010. Please enter it below to verify.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white54, // Muted secondary text
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                ///🔹 OTP FIELD
                SizedBox(
                  width: double.infinity,
                  child: Pinput(
                    length: 6,
                    controller: _pinController,
                    focusNode: _focusNode,
                    keyboardType: TextInputType.number,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: defaultPinTheme,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    separatorBuilder: (index) => const SizedBox(width: 8),
                    onCompleted: (pin) => _verifyOtp(),
                    autofocus: true,
                    cursor: Container(width: 2, height: 24, color: accentCyan),
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                Row(
                  children: [
                    const Text(
                      "No code received? ",
                      style: TextStyle(color: Colors.white38, fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Add Resend Logic
                      },
                      child: const Text(
                        "Resend Code",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: accentCyan,
                        ),
                      ),
                    ),
                  ],
                ),

                if (_loading) ...[
                  SizedBox(height: size.height * 0.05),
                  const Center(
                    child: CircularProgressIndicator(color: accentCyan),
                  ),
                ],

                SizedBox(height: size.height * 0.14),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
