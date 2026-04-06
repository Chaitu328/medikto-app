import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medikto/features/onboarding/views/overall_features_screen.dart';
import 'package:medikto/features/onboarding/views/welcome_screen.dart';
import 'package:medikto/features/onboarding/widgets/onboarding_page.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  final PageController _controller = PageController();
  final ValueNotifier<int> currentIndex = ValueNotifier(0);

  final List<Map<String, String>> data = const [
    {
      "image": "assets/images/vault-rafiki.png",
      "title": "Welcome to Medikto",
      "desc": "Your smart companion for timely medications and secure health records.",
    },
    {
      "image": "assets/images/add-files-rafiki.png",
      "title": "Medikto – Medicine reminder app",
      "desc": "Upload, organize, and access anytime",
    },
    {
      "image": "assets/images/security-rafiki.png",
      "title": "Your Data, Protected",
      "desc": "We ensure privacy with encryption",
    },
  ];

  @override
  void initState() {
    super.initState();

    // 🔥 Preload images (removes lag on first swipe)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var item in data) {
        precacheImage(AssetImage(item["image"]!), context);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    currentIndex.dispose();
    super.dispose();
  }

  void _next() {
    if (currentIndex.value < data.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OverrallFeaturesScreen()),
      );
    }
  }

  void _skip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context); // ✅ cache
    return SafeArea(
      top: false,
      bottom: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ValueListenableBuilder<int>(
                  valueListenable: currentIndex,
                  builder: (_, index, __) {
                    return index == 0
                        ? SizedBox(height: size.height * 0.16)
                        : const SizedBox.shrink();
                  },
                ),

                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: data.length,
                    onPageChanged: (index) => currentIndex.value = index,
                    itemBuilder: (_, index) {
                      return OnboardingPage(
                        index: index,
                        data: data[index],
                        size: size,
                        currentIndex: currentIndex,
                        total: data.length,
                        controller: _controller,
                      );
                    },
                  ),
                ),

                _buildBottomControls(size),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomControls(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: _skip,
            child: const Text(
              "Skip",
              style: TextStyle(fontSize: 16, color: Color(0xFF8B8B8B)),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: _next,
            child: Container(
              alignment: Alignment.center,
              height: size.height * 0.046,
              width: size.width * 0.24,
              decoration: BoxDecoration(
                color: const Color(0xFF213598),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                "Next",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
