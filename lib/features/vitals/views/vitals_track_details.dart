import 'package:flutter/material.dart';

class VitalsTrackDetailsScreen extends StatefulWidget {
  const VitalsTrackDetailsScreen({super.key});

  @override
  State<VitalsTrackDetailsScreen> createState() =>
      _VitalsTrackDetailsScreenState();
}

class _VitalsTrackDetailsScreenState extends State<VitalsTrackDetailsScreen> {
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
      appBar: _buildAppBar(),

      /// 🔥 Smooth Scroll
      body: CustomScrollView(
        controller: _controller,
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// 🔹 Top spacing
          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.016)),

          /// 🔹 Card (Graph)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: RepaintBoundary(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(color: Color(0xCCCCCCCC), blurRadius: 6),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Heart Rate",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF3D3D3D),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Image.asset(
                        "assets/images/graph.png",
                        filterQuality: FilterQuality.low, // 🔥 perf
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.02)),

          /// 🔹 Grey Box
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.02)),

          /// 🔹 Banner
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(
                "assets/images/health-excellence-banner.png",
                filterQuality: FilterQuality.low,
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.02)),

          /// 🔹 Title
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

          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.02)),

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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                overflow: TextOverflow.clip,
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

  /// 🔥 Optimized AppBar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF3D3D3D)),
      ),
      title: const Text(
        "Vitals",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color(0xFF3D3D3D),
        ),
      ),
    );
  }
}
