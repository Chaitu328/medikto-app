// import 'package:flutter/material.dart';

// class VitalsTrackDetailsScreen extends StatefulWidget {
//   const VitalsTrackDetailsScreen({super.key});

//   @override
//   State<VitalsTrackDetailsScreen> createState() =>
//       _VitalsTrackDetailsScreenState();
// }

// class _VitalsTrackDetailsScreenState extends State<VitalsTrackDetailsScreen> {
//   final List<Map<String, dynamic>> reportsList = const [
//     {
//       "title": "Total Reports",
//       "image": "assets/images/profile.png",
//       "count": 22,
//     },
//     {"title": "Reminders", "image": "assets/images/bell.png", "count": 4},
//     {
//       "title": "All Medications",
//       "image": "assets/images/pills.png",
//       "count": 23,
//     },
//     {
//       "title": "All Lab Reports",
//       "image": "assets/images/dna-tests.png",
//       "count": 17,
//     },
//   ];

//   final ScrollController _controller = ScrollController();

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: _buildAppBar(),

//       /// 🔥 Smooth Scroll
//       body: CustomScrollView(
//         controller: _controller,
//         physics: const BouncingScrollPhysics(),
//         slivers: [
//           /// 🔹 Top spacing
//           SliverToBoxAdapter(child: SizedBox(height: size.height * 0.016)),

//           /// 🔹 Card (Graph)
//           SliverPadding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             sliver: SliverToBoxAdapter(
//               child: RepaintBoundary(
//                 child: Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: const [
//                       BoxShadow(color: Color(0xCCCCCCCC), blurRadius: 6),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Heart Rate",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xFF3D3D3D),
//                         ),
//                       ),
//                       SizedBox(height: size.height * 0.01),
//                       Image.asset(
//                         "assets/images/graph.png",
//                         filterQuality: FilterQuality.low, // 🔥 perf
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           SliverToBoxAdapter(child: SizedBox(height: size.height * 0.02)),

//           /// 🔹 Grey Box
//           SliverPadding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             sliver: SliverToBoxAdapter(
//               child: Container(
//                 height: 50,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//           ),

//           SliverToBoxAdapter(child: SizedBox(height: size.height * 0.02)),

//           /// 🔹 Banner
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Image.asset(
//                 "assets/images/health-excellence-banner.png",
//                 filterQuality: FilterQuality.low,
//               ),
//             ),
//           ),

//           SliverToBoxAdapter(child: SizedBox(height: size.height * 0.02)),

//           /// 🔹 Title
//           const SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 "Reports Data",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w500,
//                   color: Color(0xFF263238),
//                 ),
//               ),
//             ),
//           ),

//           SliverToBoxAdapter(child: SizedBox(height: size.height * 0.02)),

//           /// 🔹 Reports Grid
//           SliverPadding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             sliver: SliverGrid(
//               delegate: SliverChildBuilderDelegate((context, index) {
//                 final item = reportsList[index];

//                 return RepaintBoundary(
//                   child: Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: const Color(0xFFCCCCCC).withAlpha(100),
//                           blurRadius: 6,
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           height: 32,
//                           width: 32,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF28B873).withAlpha(20),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Center(
//                             child: Image.asset(
//                               item["image"],
//                               height: 20,
//                               width: 20,
//                               filterQuality: FilterQuality.low,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 item["title"],
//                                 overflow: TextOverflow.clip,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(0xFF263238),
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Align(
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   item["count"].toString(),
//                                   style: const TextStyle(
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.w600,
//                                     color: Color(0xFF263238),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }, childCount: reportsList.length),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 16,
//                 crossAxisSpacing: 16,
//                 childAspectRatio: 1.64,
//               ),
//             ),
//           ),

//           const SliverToBoxAdapter(child: SizedBox(height: 20)),
//         ],
//       ),
//     );
//   }

//   /// 🔥 Optimized AppBar
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       toolbarHeight: 60,
//       backgroundColor: Colors.white,
//       elevation: 0,
//       surfaceTintColor: Colors.transparent,
//       scrolledUnderElevation: 0,
//       leading: GestureDetector(
//         onTap: () => Navigator.pop(context),
//         child: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF3D3D3D)),
//       ),
//       title: const Text(
//         "Vitals",
//         style: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.w500,
//           color: Color(0xFF3D3D3D),
//         ),
//       ),
//     );
//   }
// }




import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:medikto/core/utils/widgets/custom_appbar.dart'; // 🔥 High performance charts

class VitalsTrackDetailsScreen extends StatefulWidget {
  const VitalsTrackDetailsScreen({super.key});

  @override
  State<VitalsTrackDetailsScreen> createState() =>
      _VitalsTrackDetailsScreenState();
}

class _VitalsTrackDetailsScreenState extends State<VitalsTrackDetailsScreen> {
  int _selectedTab = 0; // 0: Today, 1: Weekly, 2: Monthly

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
      body: CustomScrollView(
        controller: _controller,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.016)),

          /// 🔹 Graph Card
          /// 🔹 Graph Card with Watermark
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Stack(
                // Added Stack to place the watermark
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Body Temperature", // Changed from Heart Rate to match Image
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF3D3D3D),
                          ),
                        ),
                        const Text("°F", style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 20),
                        SizedBox(height: 200, child: _buildHeartRateChart()),
                      ],
                    ),
                  ),
                  
                  // 🔥 THE CLIENT'S STAMP (Positioned at the top right of the card)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Opacity(
                      opacity: 0.8, // Simulate ink transparency
                      child: Transform.rotate(
                        angle:
                            -0.15, // Real-world stamping is never perfectly straight
                        child: MediktoDigitalStamp(),
                      ),
                    ),
),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.025)),

          /// 🔹 Custom Tab Toggle (Today/Weekly/Monthly)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Color(0x14767680),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    _buildTabItem("Today", 0),
                    _buildTabItem("Weekly", 1),
                    _buildTabItem("Monthly", 2),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.025)),

          /// 🔹 Banner
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/images/health-excellence-banner.png",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 80,
                    color: Colors.blue.shade50,
                    child: const Center(child: Text("Banner Placeholder")),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.02)),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Reports Data",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF263238),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.02)),

          /// 🔹 Reports Grid
          
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
          const SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    );
  }

  /// 🔹 Builds the toggle tab item
  Widget _buildTabItem(String title, int index) {
    bool isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 4)]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF000000),
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 Builds the Line Chart with Tooltip
  Widget _buildHeartRateChart() {
    return LineChart(
      LineChartData(
        
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) =>
              FlLine(color: Colors.grey.withOpacity(0.1), strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 20,
              reservedSize: 30,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 45),
              FlSpot(2, 50),
              FlSpot(4, 42),
              FlSpot(6, 65),
              FlSpot(8, 70), // The high point
              FlSpot(10, 75),
            ],
            isCurved: true,
            color: const Color(0xFFE57373),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFE57373).withOpacity(0.3),
                  const Color(0xFFE57373).withOpacity(0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) => const Color(0xFFE57373),
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                return LineTooltipItem(
                  '98bpm', // Static for design, usually barSpot.y
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

}





class MediktoDigitalStamp extends StatelessWidget {
  final DateTime? dateTime;

  const MediktoDigitalStamp({super.key, this.dateTime});

  @override
  Widget build(BuildContext context) {
    final now = dateTime ?? DateTime.now();

    return Opacity(
      opacity: 0.8, // 🔹 UX: Real stamps have slight ink transparency
      child: Transform.rotate(
        angle: -0.15, // 🔹 UX: Slight tilt for a "hand-stamped" feel
        child: Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF213598).withOpacity(0.5),
              width: 1.5,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 1. 🔄 Repeating "MEDIKTO" around the circle in Blue
              const _CircularBranding(text: "MEDIKTO • "),

              // 2. 🕒 Time and Date in Black (as per your request)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${now.hour % 12 == 0 ? 12 : now.hour % 12}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}",
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87, // 🔹 Black color for time
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "${now.day} ${_getMonth(now.month)} ${now.year}",
                    style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54, // 🔹 Black color for date
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getMonth(int month) {
    return [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ][month - 1];
  }
}

class _CircularBranding extends StatelessWidget {
  final String text;
  const _CircularBranding({required this.text});

  @override
  Widget build(BuildContext context) {
    // 🔹 Repeating text to fill the 360-degree radius
    String fullCircleText = text * 6;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double radius = (constraints.maxWidth / 2) - 5;
        return Stack(
          children: List.generate(fullCircleText.length, (index) {
            double angle = (index * 2 * math.pi) / fullCircleText.length;

            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..translate(radius * math.cos(angle), radius * math.sin(angle))
                ..rotateZ(angle + (math.pi / 2)),
              child: Text(
                fullCircleText[index],
                style: const TextStyle(
                  fontSize: 7,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF213598), // 🔹 Your Brand Blue
                  fontFamily:
                      'Courier', // 🔹 Monospace looks more like a real stamp
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
