import 'package:flutter/material.dart';
import 'package:medikto/core/utils/widgets/custom_appbar.dart';
import 'package:medikto/core/utils/widgets/custom_button.dart';
import 'package:medikto/features/vitals/views/vitals_track_details.dart';

class VitalsScreen extends StatefulWidget {
  const VitalsScreen({super.key});

  @override
  State<VitalsScreen> createState() => _VitalsScreenState();
}

class _VitalsScreenState extends State<VitalsScreen> {
  final List<Map<String, dynamic>> vitalsList = const [
    {"title": "Sugar Levels", "image": "assets/images/diabets-test.png"},
    {"title": "Heart Rate", "image": "assets/images/blood-pressure.png"},
    {"title": "Blood Sugar", "image": "assets/images/blood-drop.png"},
    {"title": "Body Temperature", "image": "assets/images/thermometer.png"},
  ];

  final List<Map<String, dynamic>> reportsList = const [
    {
      "title": "Total Reports",
      "image": "assets/images/profile.png",
      "count": 22,
    },
    {"title": "Reminders", "image": "assets/images/bell.png", "count": 4},
    {
      "title": "All Medications",
      "image": "assets/images/pills.png",
      "count": 23,
    },
    {
      "title": "All Lab Reports",
      "image": "assets/images/dna-tests.png",
      "count": 17,
    },
  ];

  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Vitals"),

      /// 🔥 Smooth Scroll Fix
      body: CustomScrollView(
        controller: _controller,
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// 🔹 Vitals Grid
          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.02)),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = vitalsList[index];

                return RepaintBoundary(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const VitalsTrackDetailsScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFCCCCCC).withAlpha(85),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// 🔹 Title Row
                          Row(
                            children: [
                              Container(
                                height: 34,
                                width: 34,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFED9D9).withAlpha(60),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    item["image"],
                                    height: 20,
                                    width: 20,
                                    filterQuality:
                                        FilterQuality.low, // 🔥 performance
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width * 0.02),
                              Expanded(
                                child: Text(
                                  item["title"],
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: size.height * 0.01),

                          /// 🔹 Value + Status
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "120/80 mmHg",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF213598),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEDF7E6),
                                  border: Border.all(color: Color(0xFF44AB42)),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      size: 10,
                                      color: Colors.green,
                                    ),
                                    SizedBox(width: 3),
                                    Text(
                                      "Normal",
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: Color(0xFF44AB42),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: size.height * 0.02),

                          Image.asset(
                            "assets/images/vitals-graph.png",
                            filterQuality: FilterQuality.low, // 🔥 important
                          ),

                          const Spacer(),

                          CustomButton(
                            buttonColor: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                            height: 24,
                            radius: BorderRadius.circular(8),
                            buttonText: "View",
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF7D7D7D),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }, childCount: vitalsList.length),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                mainAxisExtent: 190,
              ),
            ),
          ),

          /// 🔹 Reports Title
          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.03)),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Reports Data",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF263238),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.03)),

          /// 🔹 Reports Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = reportsList[index];

                return RepaintBoundary(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFCCCCCC).withAlpha(100),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            color: const Color(0xFF28B873).withAlpha(20),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(
                              item["image"],
                              height: 20,
                              width: 20,
                              filterQuality: FilterQuality.low,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["title"],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF263238),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  item["count"].toString(),
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF263238),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }, childCount: reportsList.length),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.64,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

}
