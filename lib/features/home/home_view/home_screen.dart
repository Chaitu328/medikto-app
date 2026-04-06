import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medikto/core/utils/widgets/custom_button.dart';
import 'package:medikto/core/utils/widgets/custom_textfields.dart';
import 'package:medikto/features/home/add_reports/widgets/timings_widget.dart';
import 'package:medikto/features/home/premium_plans_views/premium_plans.dart';
import 'package:medikto/features/reports/widgets/reports_action_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Use 'static const' for data that never changes to save memory
  static const List<Map<String, dynamic>> vitalsList = [
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

  static const List<String> carouselImages = [
    "assets/images/motivational-quotes.png",
    "assets/images/motivational-quotes2.png",
    "assets/images/motivational-quotes3.png",
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(size),
      body: CustomScrollView(
        // 🔥 Switched to CustomScrollView for better performance
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const MediktoOverlappingCarousel(imagePaths: carouselImages),
                SizedBox(height: size.height * 0.02),
                const Text(
                  "My Vitals",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF263238),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
              ]),
            ),
          ),

          /// ✅ Pinned Grid (No shrinkWrap = High Performance)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                mainAxisExtent: 110,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    _VitalsCard(item: vitalsList[index], size: size),
                childCount: vitalsList.length,
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const _ReportsCard(),
                SizedBox(height: size.height * 0.02),
                const _MedicineNextDueCard(),
                SizedBox(height: size.height * 0.02),
                _buildImage("assets/images/health-excellence-banner.png"),
                SizedBox(height: size.height * 0.02),
                const _AddReportCard(),
                SizedBox(height: size.height * 0.02),
                _buildImage("assets/images/Telemedicine-coming-soon.png"),
                SizedBox(height: size.height * 0.02),
                _buildImage("assets/images/AI-builder-button.png"),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(Size size) {
    return AppBar(
      toolbarHeight: 80,
      elevation: 0, // Set to 0 for a cleaner look
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      title: const _AppBarTitle(), // Extracted to its own const widget
      actions: [_AppBarActions(size: size)],
    );
  }

  Widget _buildImage(String path) {
    return RepaintBoundary(
      // 🔥 Isolates the image from the rest of the UI
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          path,
          fit: BoxFit.cover,
          cacheWidth: 600, // Prevents decoding huge images into memory
        ),
      ),
    );
  }
}

/// ✅ Optimization: Isolate the AppBar Title
class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text(
              "Hello",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 8),
            Icon(Icons.favorite, color: Color(0xFFF28F8F), size: 20),
            SizedBox(width: 8),
            Text(
              "Shiva Sai",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const Text(
          "wishing you a healthy day!",
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Color(0xD6263238),
          ),
        ),
      ],
    );
  }
}

/// ✅ Optimization: Isolate AppBar Actions
class _AppBarActions extends StatelessWidget {
  final Size size;
  const _AppBarActions({required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PremiumPlansScreen()),
            ),
            child: Image.asset(
              "assets/images/try-premium-button.png",
              width: 130,
              cacheWidth: 260,
            ),
          ),
          const SizedBox(width: 15),
          Stack(
            children: [
              Image.asset(
                "assets/images/notification-button.png",
                width: 20,
                cacheWidth: 40,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  height: 10,
                  width: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    "2",
                    style: TextStyle(fontSize: 8, color: Colors.white),
                  ),
                ),
                
              ),
            ],
          ),
        ],
      ),
    );
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
        padding: const EdgeInsets.all(10), // Simplified padding
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFCCCCCC).withAlpha(80),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fixed size icon
            Image.asset(item["icon"], height: 24, width: 24),
            const SizedBox(width: 10),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Distributes space evenly
                children: [
                  /// 1. Title - Clips if too long
                  Text(
                    item["title"],
                    
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontSize: 13, // Slightly smaller for better fit
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF263238),
                    ),
                  ),

                  /// 2. Value + Unit - Scales to fit width
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          item["value"],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF213598),
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          item["unit"],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xD6263238),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 3. Status Row - Flexible sizing
                  Row(
                    children: [
                      const Text(
                        "Status",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDF7E6),
                            border: Border.all(
                              color: const Color(0xFF44AB42),
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.check_circle,
                                size: 8,
                                color: Color(0xFF44AB42),
                              ),
                              SizedBox(width: 2),
                              Flexible(
                                child: Text(
                                  "Normal",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w500,
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



class _AddReportCard extends StatefulWidget {
  const _AddReportCard({super.key});

  @override
  State<_AddReportCard> createState() => _AddReportCardState();
}

class _AddReportCardState extends State<_AddReportCard> {
  bool isExpanded = false;
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      constraints: BoxConstraints(maxWidth: double.infinity),
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => ReportActionsSheet(
        actions: [
          {"icon": Icons.photo, "title": "Choose from Gallery"},
          {"icon": Icons.camera_alt, "title": "Take a Photo"},
          {"icon": Icons.insert_drive_file, "title": "choose PDF files"},
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF213598), width: 0.2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// 🔹 HEADER PART
          InkWell(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isExpanded ? "Add Medication" : "All Reports",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF263238),
                            ),
                          ),
                          Text(
                            isExpanded ? "2" : "0",
                            style: TextStyle(
                              fontSize: isExpanded ? 18 : 24,
                              fontWeight: FontWeight.w600,
                              color: isExpanded
                                  ? const Color(0xFF213598)
                                  : const Color(0xFF5F6368),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(
                    isExpanded ? Icons.remove_circle : Icons.add_circle,
                    color: const Color(0xFF213598),
                    size: 40,
                  ),
                ],
              ),
            ),
          ),

          /// 🔹 EXPANSION CONTENT
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTakeMedicationAction(),
                  SizedBox(height: size.height * 0.02),

                  /// 🔹 MEDICINE NAME FIELD
                  _buildTextField(
                    title: "Medicine Name",
                    hint: "Enter medicine name",
                  ),

                  /// 🔹 DOSAGE FIELD
                  _buildTextField(
                    title: "Dosage of Medication",
                    hint: "Enter your dosage, timings, others",
                  ),

                  SizedBox(height: size.height * 0.02),

                  /// 🔹 TIMINGS SECTION (Custom Widget)
                  const TimingsSection(),

                  SizedBox(height: size.height * 0.02),

                  /// 🔹 UPLOAD IMAGE
                  GestureDetector(
                    onTap: () => _showBottomSheet(context),
                    child: Center(
                      child: Image.asset(
                        "assets/images/upload-file.png",
                        width: size.width * 0.85,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.03),

                  /// 🔹 ADD REPORT BUTTON
                  CustomButton(
                    onPressed: () {
                      // Add your logic here
                      setState(() => isExpanded = false);
                    },
                    buttonColor: const Color(0xFF213598),
                    buttonText: "Add Report",
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFffffff),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  /// 🔹 Reusable Titled TextField Helper
  Widget _buildTextField({
    required String title,
    required String hint,
    int maxLines = 1,
    Color borderColor = const Color(0xA3555555),
    Widget? suffix,
  }) {
    return AppTextFormFieldTitled(
      title: title,
      hintText: hint,
      maxLines: maxLines,
      borderColor: borderColor,
      focusColor: Colors.black,
      fillColor: Colors.white,
      color: Colors.white,
      suffix: suffix,
      hintStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xA3555555),
      ),
      titleTextStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Color(0xFF555555),
      ),
    );
  }

  Widget _buildTakeMedicationAction() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8E9), // Soft green background
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF4CAF50), width: 0.5),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 20),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              "Ready for your 04:30 PM dose?",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2E7D32),
              ),
            ),
          ),
          Material(
            color: const Color(0xFF4CAF50),
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: () {
                // Logic to mark as taken and update log
              },
              borderRadius: BorderRadius.circular(20),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Text(
                  "Take Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MedicineNextDueCard extends StatelessWidget {
  const _MedicineNextDueCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF213598), width: 0.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCCCCCC).withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.access_time_filled,
            color: Color(0xFF213598),
            size: 28,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Medicine Next Due",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF263238),
                  ),
                ),
                Text(
                  "Next dose at 04:30 PM",
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: Color(0xFF5F6368),
          ),
        ],
      ),
    );
  }
}

class MediktoOverlappingCarousel extends StatefulWidget {
  final List<String> imagePaths;

  const MediktoOverlappingCarousel({super.key, required this.imagePaths});

  @override
  State<MediktoOverlappingCarousel> createState() =>
      _MediktoOverlappingCarouselState();
}

class _MediktoOverlappingCarouselState
    extends State<MediktoOverlappingCarousel> {
  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // 🔹 Timer for automatic smooth transitions every 4 seconds
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % widget.imagePaths.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // 🔹 Essential for memory optimization
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 🔹 RepaintBoundary isolates these animations, preventing 'jank' while scrolling
    return RepaintBoundary(
      child: Stack(
        alignment: Alignment.center,
        children: List.generate(widget.imagePaths.length, (index) {
          bool isVisible = index == _currentIndex;

          return AnimatedOpacity(
            opacity: isVisible ? 1.0 : 0.0, // Smooth fade in/out logic
            duration: const Duration(
              milliseconds: 800,
            ), // 800ms for smooth feel
            curve: Curves.easeInOut,
            // 🔹 Positioned.fill ensures they overlap perfectly 1 on 1
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8), // Match your app style
              child: Image.asset(
                widget.imagePaths[index],
                fit: BoxFit.cover,
                cacheWidth: 800, // 🔹 Performance: Optimization for memory
              ),
            ),
          );
        }),
      ),
    );
  }
}
