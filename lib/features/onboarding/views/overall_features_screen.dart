import 'package:flutter/material.dart';
import 'package:medikto/core/utils/widgets/custom_button.dart';
import 'package:medikto/features/onboarding/views/onboarding_screens.dart';
import 'package:medikto/features/onboarding/views/welcome_screen.dart';

class OverrallFeaturesScreen extends StatefulWidget {
  const OverrallFeaturesScreen({super.key});

  @override
  State<OverrallFeaturesScreen> createState() => _OverrallFeaturesScreenState();
}

class _OverrallFeaturesScreenState extends State<OverrallFeaturesScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              /// 🔹 SCROLLABLE CONTENT
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.06),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => OnboardingScreens(),
                            ),
                            (route) => false,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 24,
                            color: Color(0xFF000000),
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.03),

                      Image.asset(
                        'assets/images/public-health-amico.png',
                        width: 300,
                        height: 300,
                      ),

                      SizedBox(height: size.height * 0.04),

                      Text(
                        "Secure · Store · Share",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF263238),
                        ),
                      ),

                      SizedBox(height: size.height * 0.02),

                      Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth:
                                MediaQuery.sizeOf(context).width *
                                0.65, // 🔥 key
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start, // ✅ ALIGN ALL LEFT
                            children: [
                              _featureItem("Secure Storage"),
                              _featureItem("Organized Records"),
                              _featureItem("Trusted Privacy"),
                              _featureItem("Doctor Sharing"),
                              _featureItem("ABDM Govt. Health ID"),
                              _featureItem("Family Accounts"),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              /// 🔥 FIXED BUTTON (STICKY)
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 10),
                child: CustomButton(
                  height: 54,
                  buttonText: "Get Started",
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFffffff),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // 🔥 CENTER WHOLE ROW
        mainAxisSize: MainAxisSize.min, // 🔥 DON'T TAKE FULL WIDTH
        children: [
          Container(
            height: 6,
            width: 6,
            decoration: const BoxDecoration(
              color: Color(0xFF7D7D7D),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            textAlign: TextAlign.center, // 🔥 IMPORTANT
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF7D7D7D),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
