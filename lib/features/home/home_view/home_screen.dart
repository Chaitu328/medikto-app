import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medikto/core/utils/widgets/custom_button.dart';
import 'package:medikto/core/utils/widgets/custom_textfields.dart';
import 'package:medikto/features/home/add_reports/widgets/timings_widget.dart';
import 'package:medikto/features/home/notifications/notification_screen.dart';
import 'package:medikto/features/home/premium_plans_views/premium_plans.dart';
import 'package:medikto/features/medications/views/medication_verification_screen.dart';
import 'package:medikto/features/medications/widgets/medication_log_card.dart';
import 'package:medikto/features/medications/widgets/reports_action_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Brand Colors modified for Dark Mode visibility
  static const Color primaryBlue = Color(0xFF4D6AFF); // Brightened for dark bg
  static const Color darkBg = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: darkBg,
      appBar: _buildAppBar(size),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Text(
                  "DASHBOARD",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Colors.white54,
                  ),
                ),
                const Text(
                  "Good morning, \nShiva Sai",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                /// 1. ADHERENCE SCORE CARD (Dark Themed)
                _buildAdherenceCard(),
                

                const SizedBox(height: 20),

                /// 2. NEXT DOSE QUICK ACTION
                _buildNextDoseCard(),
                // const SizedBox(height: 16),

                // _buildPremiumCard(),

                
                const SizedBox(height: 16),

                
               
                /// 🔹 3. TODAY'S SCHEDULE HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Today's Schedule",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Tuesday, Oct 24",
                          style: TextStyle(fontSize: 14, color: Colors.white38),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: const Text(
                        "VIEW ALL",
                        style: TextStyle(
                          color: Color(0xFF81DEEA), // Cyan
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                /// 4. SCHEDULE LIST
_buildScheduleItem(
                  time: "7 AM",
                  name: "Atorvastatin",
                  desc: "20mg Tablet",
                  status: "MISSED",
                  // A slightly stronger tint for missed background
                  color: Colors.redAccent,
                ),
                _buildScheduleItem(
                  time: "8 AM",
                  name: "Vitamin D3",
                  desc: "1000 IU Capsule",
                  status: "TAKEN",
                  subStatus: "Logged at 8:04 AM",
                  color: const Color(0xFF81DEEA), // Cyan
                ),
                _buildScheduleItem(
                  time: "2 PM",
                  name: "Metformin",
                  desc: "500mg Oral",
                  status: "UPCOMING",
                  color: Colors.orangeAccent,
                ),
                _buildScheduleItem(
                  time: "9 PM",
                  name: "Lisinopril",
                  desc: "10mg Tablet",
                  status: "LATER",
                  color: Colors.white24, // Muted grey for later
                ),
                const SizedBox(height: 10),

                const Text(
                  "Quick Health Look",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
              ]),
            ),
          ),

          /// 5. VITALS GRID (Dark Cards)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                mainAxisExtent: 110,
              ),
              delegate: SliverChildListDelegate([
                _buildSmallVitalCard(
                  "Pulse",
                  "72",
                  "BPM",
                  Icons.favorite,
                  Colors.redAccent,
                ),
                _buildSmallVitalCard(
                  "Sleep",
                  "8h 12m",
                  "",
                  Icons.bedtime,
                  Colors.orange,
                ),
                _buildSmallVitalCard(
                  "BP",
                  "120/80",
                  "mmHg",
                  Icons.bloodtype,
                  Colors.blueAccent,
                ),
                _buildSmallVitalCard(
                  "Sugar",
                  "106",
                  "mg/dl",
                  Icons.local_drink,
                  Colors.greenAccent,
                ),
              ]),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }

  Widget _buildAdherenceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // Subtle gradient to match the modern dark UI
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [surfaceColor, surfaceColor.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // --- Left Side: Text Data ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Medication",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "Compliance",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Last 7 days performance",
                  style: TextStyle(fontSize: 11, color: Colors.white54),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: const [
                    Text(
                      "85%",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF81DEEA), // Bright Cyan
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      "ADHERENCE",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: Color(0xFF81DEEA), // Darker Cyan/Teal
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // --- Right Side: Circular Progress with Badge ---
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 90,
                width: 90,
                child: CircularProgressIndicator(
                  value: 0.85,
                  strokeWidth: 8,
                  backgroundColor: Colors.white.withOpacity(0.1),
                  color: const Color(0xFF81DEEA),
                  strokeCap: StrokeCap.round,
                ),
              ),
              // Center Badge Icon
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons
                      .verified, // Using verified icon to match the "badge" look
                  color: Color(0xFF81DEEA),
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildPremiumCard() {
    return _AnimatedPremiumCard(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PremiumPlansScreen()),
        );
      },
    );
  }


  Widget _buildNextDoseCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1b2028),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF25353e),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.medication, color: Color(0xFF81DEEA)),
              ),
              const SizedBox(width: 15),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "NEXT DOSE",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Metformin 500mg",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 45),
              backgroundColor: const Color(0xFF81DEEA),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MedicationVerificationScreen(
                    medicineName: "Metformin 500mg",
                  ),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle_outline, size: 20),
                const SizedBox(width: 8),
                const Text(
                  "Mark as Taken",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget _buildScheduleItem({
    required String time,
    required String name,
    required String desc,
    required String status,
    String? subStatus,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        // 🔹 Tinted Background: surfaceColor mixed with a hint of status color
        color: Color.alphaBlend(
          color.withOpacity(0.08),
          const Color(0xFF1E1E1E),
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.1), // Subtle border glow
          width: 1,
      ),
      ),
      child: IntrinsicHeight(
      child: Row(
        children: [
            // 🔹 Left Thick Accent Strip
            Container(
              width: 5,
              margin: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(4),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // 🔹 Time Section
                    SizedBox(
                      width: 45,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            time,
                            style: TextStyle(
                              color: color.withOpacity(0.9),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            height: 6,
                            width: 6,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: color.withOpacity(0.4),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),

                    // 🔹 Medication Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            desc,
                            style: const TextStyle(
                              color: Colors.white38,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 🔹 Status Badge
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              color: color,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        if (subStatus != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            subStatus,
                            style: const TextStyle(
                              color: Colors.white24,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
 
  Widget _buildSmallVitalCard(
    String title,
    String value,
    String unit,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white54,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: " $unit",
                    style: const TextStyle(fontSize: 10, color: Colors.white38),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(Size size) {
    return AppBar(
      toolbarHeight: 80,
      elevation: 0,
      backgroundColor: darkBg,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white10,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello Shiva!",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "Ready for your checkup?",
                style: TextStyle(fontSize: 11, color: Colors.white54),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            // Handle notifications
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationScreen()),
            );
          },
          icon: const Badge(
            child: Icon(Icons.notifications_none, color: Colors.white),
          ),
        ),
        const SizedBox(width: 10),
      ],
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

class NextDoseFloatingReminder extends StatelessWidget {
  final String medicineName;
  final String countdown;
  final String timeSlot;
  final VoidCallback onTap;

  const NextDoseFloatingReminder({
    super.key,
    required this.medicineName,
    required this.countdown,
    required this.timeSlot,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(
            0xFF1A1C1E,
          ).withAlpha(450), // Dark themed like image
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5ce5f9).withAlpha(100),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon with the pink notification dot
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.alarm,
                    color: Color(0xFF81DEEA),
                    size: 24,
                  ),
                ),
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF48FB1), // Pink dot
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 15),
            // Text Content
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "NEXT DOSE IN",
                    style: TextStyle(
                      color: Color(0xFF81DEEA),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    countdown,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Medicine Name and Time
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  medicineName.toUpperCase(),
                  style: const TextStyle(color: Colors.white70, fontSize: 10),
                ),
                Text(
                  timeSlot,
                  style: const TextStyle(
                    color: Color(0xFFFFD54F), // Yellow/Gold time
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class _AnimatedPremiumCard extends StatefulWidget {
  final VoidCallback onTap;

  const _AnimatedPremiumCard({required this.onTap});

  @override
  State<_AnimatedPremiumCard> createState() => _AnimatedPremiumCardState();
}

class _AnimatedPremiumCardState extends State<_AnimatedPremiumCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(); // smooth infinite loop
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Container(
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: SweepGradient(
                colors: const [
                  Color(0xFF81DEEA),
                  Color(0xFF4D6AFF),
                  Color(0xFF81DEEA),
                ],
                stops: const [0.0, 0.5, 1.0],
                transform: GradientRotation(_controller.value * 6.28),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.all(1.5), // border thickness
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(18),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: widget.onTap,
                child: Row(
                  children: [
                    /// 🔥 PREMIUM ICON (Glow effect)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF81DEEA).withAlpha(50),
                      ),
                      child: const Icon(
                        Icons.workspace_premium,
                        color: Color(0xFF81DEEA),
                        size: 26,
                      ),
                    ),

                    const SizedBox(width: 14),

                    /// 🔹 TEXT
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Go Premium",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Unlock insights, smart alerts & reports",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// 🔹 CTA (Better UX)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF81DEEA), Color(0xFF4D6AFF)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            "UPGRADE",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 10,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
