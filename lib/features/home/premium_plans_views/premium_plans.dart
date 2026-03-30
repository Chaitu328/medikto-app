import 'package:flutter/material.dart';

class PremiumPlansScreen extends StatefulWidget {
  const PremiumPlansScreen({super.key});

  @override
  State<PremiumPlansScreen> createState() => _PremiumPlansScreenState();
}

class _PremiumPlansScreenState extends State<PremiumPlansScreen> {
  final List<String> features = const [
    "🧾 Store up to 50 health reports",
    "💊 Manage up to 5 active medications",
    "🔔 Daily reminders for medications",
    "📁 Upload and view prescriptions anytime",
    "☁️ Secure cloud backup (limited space)",
    "📆 365days Validity",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),

      /// 🔥 Smooth Scroll (No nested scroll)
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 12)),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: RepaintBoundary(child: _PlanCard(features: features)),
                );
              }, childCount: 2),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  /// 🔥 Optimized AppBar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF3D3D3D)),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Icon(Icons.info_outline_rounded, color: Color(0xFF3D3D3D)),
        ),
      ],
      title: const Text(
        "Our Plans",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color(0xFF3D3D3D),
        ),
      ),
    );
  }
}

/// 🔥 Extracted Plan Card (prevents rebuild)
class _PlanCard extends StatelessWidget {
  final List<String> features;

  const _PlanCard({required this.features});



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Color(0xFFCCCCCC).withAlpha(200), blurRadius: 4),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [_PlanTitle(), _RadioCircle()],
            ),
          ),

          SizedBox(height: 12),

          const Divider(thickness: 0.4, color: Color(0xFF8E98A8)),

          SizedBox(height: 12),

          /// 🔹 Body
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _PlanBadge(),

                SizedBox(height: 16),

                const _PriceText(),

                SizedBox(height: 16),

                /// 🔥 Features List
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: features
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            e,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF555555),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 🔥 Title Row
class _PlanTitle extends StatelessWidget {
  const _PlanTitle();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          height: 34,
          width: 34,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFEB691F14).withAlpha(30),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey.shade100, blurRadius: 4),
              ],
            ),
            child: const Icon(
              Icons.favorite,
              color: Color(0xFFF28F8F),
              size: 16,
            ),
          ),
        ),
        const SizedBox(width: 20),
        const Text(
          "Basic plan",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF344054),
          ),
        ),
      ],
    );
  }
}

/// 🔥 Radio Circle
class _RadioCircle extends StatelessWidget {
  const _RadioCircle();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Color(0xFF8E98A8)),
      ),
    );
  }
}

/// 🔥 Badge
class _PlanBadge extends StatelessWidget {
  const _PlanBadge();

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/standard-premium-button.png", width: 140);
  }
}

/// 🔥 Price
class _PriceText extends StatelessWidget {
  const _PriceText();

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        text: "₹499/ ",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w600,
          color: Color(0xFF344054),
        ),
        children: [
          TextSpan(
            text: "per year",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF555555),
            ),
          ),
        ],
      ),
    );
  }
}
