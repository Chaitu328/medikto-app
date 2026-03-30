import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medikto/features/home/premium_plans_views/premium_plans.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> vitalsList = const [
    {
      "title": "Blood Pressure",
      "value": "120/80",
      "unit": "mmHg",
      "icon": "assets/images/blood-drop.png",
    },
    {
      "title": "Heart Rate",
      "value": "80",
      "unit": " Bpm",
      "icon": "assets/images/blood-pressure.png",
    },
    {
      "title": "Body Temperature",
      "value": "36.6",
      "unit": "°C",
      "icon": "assets/images/thermometer.png",
    },
    {
      "title": "Sugar Levels",
      "value": "106",
      "unit": "mg/dl",
      "icon": "assets/images/diabets-test.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(size),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage("assets/images/motivational-quotes.png"),
              SizedBox(height: size.height * 0.03),

              const Text(
                "My Vitals",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF263238),
                ),
              ),

              SizedBox(height: size.height * 0.02),

              /// ✅ Optimized Grid
              GridView.builder(
                itemCount: vitalsList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                cacheExtent: 300,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  mainAxisExtent: 110,
                ),
                itemBuilder: (context, index) {
                  final item = vitalsList[index];
                  return _VitalsCard(item: item, size: size);
                },
              ),

              SizedBox(height: size.height * 0.02),

              const _ReportsCard(),
              SizedBox(height: size.height * 0.02),

              _buildImage("assets/images/health-excellence-banner.png"),
              SizedBox(height: size.height * 0.02),

              const _AddReportCard(),
              SizedBox(height: size.height * 0.02),

              _buildImage("assets/images/Telemedicine-coming-soon.png"),
              SizedBox(height: size.height * 0.02),

              _buildImage("assets/images/AI-builder-button.png"),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ Extracted AppBar (prevents rebuild cost)
  AppBar _buildAppBar(Size size) {
    return AppBar(
      toolbarHeight: 80,
      elevation: 2,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Hello",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: size.width * 0.02),
              const Icon(Icons.favorite, color: Color(0xFFF28F8F), size: 20),
              SizedBox(width: size.width * 0.02),
              const Text(
                "Shiva Sai",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const Text(
            "wishing you a healthy day!",
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PremiumPlansScreen(),
                    ),
                  );
                },
                child: Image.asset(
                  "assets/images/try-premium-button.png",
                  width: 130,
                  cacheWidth: 260, // ✅ memory optimization
                ),
              ),
              SizedBox(width: size.width * 0.04),
              Image.asset(
                "assets/images/notification-button.png",
                width: 20,
                cacheWidth: 40,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// ✅ Image optimization helper
  Widget _buildImage(String path) {
    return Image.asset(path, fit: BoxFit.cover, cacheWidth: 600);
  }
}

/// ✅ Separate widget = less rebuild = smooth UI
class _VitalsCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final Size size;

  const _VitalsCard({required this.item, required this.size});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 4, 10),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFCCCCCC).withAlpha(50),
              blurRadius: 2,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(item["icon"], height: 24, width: 24),

            const SizedBox(width: 6),

            /// ✅ IMPORTANT FIX
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Text(
                    item["title"],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // 🔥 prevents overflow
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF263238),
                    ),
                  ),

                  /// Value
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          item["value"],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF213598),
                          ),
                        ),
                      ),
                      Text(item["unit"], style: const TextStyle(fontSize: 12)),
                    ],
                  ),

                  const SizedBox(height: 6),

                  /// Status Row (FIXED)
                  Row(
                    children: [
                      const Text("Status", style: TextStyle(fontSize: 12)),
                      const SizedBox(width: 6),

                      /// 🔥 FIX HERE
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDF7E6),
                            border: Border.all(color: Color(0xFF44AB42)),
                            borderRadius: BorderRadius.circular(108),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.check_circle,
                                size: 10,
                                color: Color(0xFF44AB42),
                              ),
                              SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  "Normal",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF44AB42),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ✅ Extracted static widgets
class _ReportsCard extends StatelessWidget {
  const _ReportsCard();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFCCCCCC).withAlpha(50),
              blurRadius: 2,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            /// LEFT SIDE
            Expanded(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFECF4FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      "assets/images/item2.png",
                      color: const Color(0xFF213598),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "All Reports",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "16",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// DIVIDER
            Container(width: 1, color: Colors.grey.shade200),

            /// RIGHT SIDE
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Newly Added",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "6",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_forward_ios_outlined, size: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddReportCard extends StatelessWidget {
  const _AddReportCard();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 20),

        width: double.infinity,

        decoration: BoxDecoration(
          color: Color(0xFFffffff),

          borderRadius: BorderRadius.circular(8),

          border: Border.all(color: Color(0xFF213598), width: 0.2),
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,

          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Container(
                  padding: EdgeInsets.all(10),

                  height: 40,

                  width: 40,

                  decoration: BoxDecoration(
                    color: Color(0xFFECF4FF),

                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: Image.asset(
                    "assets/images/item2.png",

                    color: Color(0xFF213598),
                  ),
                ),

                SizedBox(width: 20),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(
                      "All Reports",

                      style: TextStyle(
                        fontSize: 16,

                        fontWeight: FontWeight.w600,

                        color: Color(0xFF263238),
                      ),
                    ),

                    // SizedBox(height: 10),
                    Text(
                      "0",

                      style: TextStyle(
                        fontSize: 24,

                        fontWeight: FontWeight.w600,

                        color: Color(0xFF5F6368),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Icon(Icons.add_circle, color: Color(0xFF213598), size: 40),
          ],
        ),
      ),
    );
  }
}
