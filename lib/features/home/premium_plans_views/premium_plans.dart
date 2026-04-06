import 'package:flutter/material.dart';
import 'package:medikto/features/home/bottom_bar.dart';

class PremiumPlansScreen extends StatefulWidget {
  const PremiumPlansScreen({super.key});

  @override
  State<PremiumPlansScreen> createState() => _PremiumPlansScreenState();
}

class _PremiumPlansScreenState extends State<PremiumPlansScreen> {
  // ValueNotifier for smooth, targeted rebuilds when selecting plans
  final ValueNotifier<int> _selectedPlanIndex = ValueNotifier<int>(0);

  final List<Map<String, dynamic>> plans = [
    {
      "title": "Basic plan",
      "price": "₹499",
      "icon": Icons.favorite,
      "iconBg": const Color(0xFFFFEBEE),
      "iconColor": const Color(0xFFF28F8F),
      "badge": "assets/images/basic-plan.png", // Replace with your asset
      "features": [
        "🧾 Store up to 50 health reports",
        "💊 Manage up to 5 active medications",
        "🔔 Daily reminders for medications",
        "📸 Take photo & delete in 48 hours",
        "📁 Upload and view prescriptions anytime",
        "☁️ Secure cloud backup (limited space)",
      ],
    },
    {
      "title": "Premium Plan",
      "price": "₹2000",
      "icon": Icons.diamond_outlined,
      "iconBg": const Color(0xFFFFF8E1),
      "iconColor": const Color(0xFFB99D33),
      "badge": "assets/images/premium-plan.png",
      "features": [
        "🧾 Store up to 250 health reports",
        "💊 Manage unlimited medications",
        "📸 Take photo & store indefinitely",
        "📈 Detailed AI health analytics",
        "☁️ Full cloud storage & sync across devices",
        "📤 Share as PDF, JPEG via Bluetooth/Email",
      ],
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          /// 🔹 Scrollable List
          ValueListenableBuilder(
            valueListenable: _selectedPlanIndex,
            builder: (context, selectedIndex, _) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _PlanCard(
                            plan: plans[index],
                            isSelected: selectedIndex == index,
                            onTap: () => _selectedPlanIndex.value = index,
                          ),
                        );
                      }, childCount: plans.length),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 100),
                  ), // Space for button
                ],
              );
            },
          ),

          /// 🔹 Bottom Fixed Button
          _buildBottomButton(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      leadingWidth: 56,
      titleSpacing: 0,

      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xFF3D3D3D),
          size: 20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: false,
      title: const Text(
        "Our Plans",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1D2939),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.help_outline, color: Color(0xFF667085)),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildBottomButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ValueListenableBuilder(
          valueListenable: _selectedPlanIndex,
          builder: (context, index, _) {
            return ElevatedButton(
              onPressed: () {
                // 1. Show the success dialog
                showDialog(
                  barrierColor: Colors.black.withAlpha(100),
                  
                  context: context,
                  barrierDismissible:
                      false, // User must wait for the transition
                  builder: (context) => const _SuccessDialog(),
                );

                // // 2. Wait for 2 seconds then navigate
                Future.delayed(const Duration(seconds: 2), () {
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BaseBottomNavigationPage(),
                      ),
                      (route) => false,
                    );
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF213598),
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: Text(
                "Activate ${plans[index]['title']}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final Map<String, dynamic> plan;
  final bool isSelected;
  final VoidCallback onTap;

  const _PlanCard({
    required this.plan,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF213598) : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header Row
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: plan['iconBg'],
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        plan['icon'],
                        color: plan['iconColor'],
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    plan['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D2939),
                    ),
                  ),
                  const Spacer(),
                  _buildRadioIcon(),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 0.4, color: Color(0xFF8E98A8)),
            
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Plan Badge
                  // Replace your Container/Row badge with this:
                  Image.asset(
                    plan['badge'], // This pulls the path from your map
                    width: 110, // Adjust width to match your design
                    height: 32, // Adjust height to match your design
                    fit: BoxFit.contain,
                    // Use colorBlendMode if you need to tint the image when selected,
                    // otherwise just leave it as the raw asset.
                  ),
                  const SizedBox(height: 12),

                  // Price
                  RichText(
                    text: TextSpan(
                      text: "${plan['price']}/ ",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D2939),
                      ),
                      children: const [
                        TextSpan(
                          text: "per month",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF667085),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Features
                  ...plan['features']
                      .map<Widget>((feature) => _buildFeatureItem(feature))
                      .toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioIcon() {
    return Container(
      height: 22,
      width: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? const Color(0xFF213598) : const Color(0xFFD0D5DD),
          width: 2,
        ),
      ),
      child: isSelected
          ? const Center(
              child: Icon(
                Icons.check_circle,
                size: 18,
                color: Color(0xFF213598),
              ),
            )
          : null,
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Keeps emoji aligned with the first line
        children: [
          // We use a SizedBox or Padding to give the emoji its own space
          // without a separate Icon widget
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5, // Improves readability for multi-line points
                fontWeight: FontWeight.w400,
                color: Color(0xFF555555),
                // Ensure your font supports emojis (default Flutter font usually does)
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _SuccessDialog extends StatelessWidget {
  const _SuccessDialog();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Dialog(
        constraints: BoxConstraints(
      
          minWidth: double.infinity,
        ), // Keeps the dialog compact on larger screens
        insetPadding: EdgeInsets.all(0),
        backgroundColor: Colors.white, // Ensures the background is pure white
        surfaceTintColor: Colors.transparent, // Prevents M3 purple-ish tint
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ✅ Your Image Asset
              Image.asset(
                "assets/images/account-create-success.png",
                
                width: 120,
              ),
              const SizedBox(height: 16),
              
              // 🔹 Title
              const Text(
                "Thank you for plan request",
                // textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.w600, // Slightly bolder for better visibility
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 6),

              // 🔸 Subtitle
              const Text(
                "Our team will get back to you soon.",
                // textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12, // Adjusted slightly for better hierarchy
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF7D7D7D),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
