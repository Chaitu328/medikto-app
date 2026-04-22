import 'package:flutter/material.dart';
import 'package:medikto/core/utils/widgets/custom_appbar.dart';
import 'package:medikto/features/home/notifications/notification_screen.dart';
import 'package:medikto/features/medications/views/medication_verification_screen.dart';

class MedicationsScreen extends StatefulWidget {
  const MedicationsScreen({super.key});

  @override
  State<MedicationsScreen> createState() => _MedicationsScreenState();
}

class _MedicationsScreenState extends State<MedicationsScreen> {
  // Brand Dark Colors consistent with design
  static const Color darkBg = Color(0xFF121212); // Deep Charcoal
  static const Color surfaceColor = Color(0xFF1E1E1E); // Elevated Grey
  static const Color accentCyan = Color(0xFF81DEEA); // Branding Cyan
  static const Color dangerRed = Color(0xFFE57373); // Critical Alerts

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            /// 🔹 1. HEADER SECTION (Compliance & Next Dose)
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  /// 🟢 Weekly Compliance Card
                  _buildWeeklyComplianceCard(),

                  const SizedBox(height: 15),

                  /// 🔴 Critical Pulse / Next Dose Card
                  _buildNextDoseCard(),
                ]),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            /// 🔹 2. CALENDAR SECTION
            SliverToBoxAdapter(child: _buildCalendarSection(context)),

            const SliverToBoxAdapter(child: SizedBox(height: 10)),

            /// 🔹 3. DAILY TIMELINE HEADER
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: const BoxDecoration(
                        color: accentCyan,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "DAILY TIMELINE",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 15)),

            /// 🔹 4. MEDICATION TIMELINE CARDS
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // TAKEN Item
                  _buildTimelineItem(
                    time: "08:30 AM",
                    title: "Atorvastatin 10mg",
                    sub: "Cholesterol • Post-breakfast",
                    icon: Icons.medication_rounded,
                    isTaken: true,
                    isLast: false,
                  ),
                  // UPCOMING Item
                  _buildTimelineItem(
                    time: "12:00 PM",
                    title: "Vitamin C 500mg",
                    sub: "Immune Support • With lunch",
                    icon: Icons.vaccines_rounded,
                    isTaken: false,
                    isUpcoming: true,
                    isLast: false,
                  ),
                  // General Wellness Item
                  _buildTimelineItem(
                    time: "08:00 PM",
                    title: "Multivitamin",
                    sub: "Wellness • Before sleep",
                    icon: Icons.inventory_2_outlined,
                    isTaken: false,
                    isLast: true,
                  ),
                ]),
              ),
            ),

            /// 🔹 5. REFILL & NOTES (Responsive Grid)
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  mainAxisExtent: 140, // Increased for long text safety
                ),
                delegate: SliverChildListDelegate([
                  _buildRefillCard(),
                  _buildDoctorNoteCard(),
                ]),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ), // Bottom padding
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: accentCyan,
      //   child: const Icon(Icons.add, color: Colors.black, size: 28),
      // ),
    );
  }

  /// 🔹 STATS CARD HELPER (Responsive fixes applied)
  Widget _buildStatCard(String title, String count, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: accentCyan, size: 20),
              Flexible(
                // ✅ Fixes potential overflow if title is long
                child: Text(
                  title,
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 COMPLIANCE RING CARD
  Widget _buildComplianceCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const SizedBox(
            height: 80,
            width: 80,
            child: CircularProgressIndicator(
              value: 0.85,
              strokeWidth: 8,
              color: accentCyan,
              backgroundColor: Colors.white12,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "85%",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "COMPLIANCE",
                style: TextStyle(
                  color: accentCyan,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔹 CALENDAR SECTION
  Widget _buildCalendarSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "September 2024",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: const [
                  Icon(Icons.chevron_left, color: Colors.white38),
                  SizedBox(width: 15),
                  Icon(Icons.chevron_right, color: Colors.white),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(5, (index) {
                bool isSelected = index == 2;
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? accentCyan : surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        ["MON", "TUE", "WED", "THU", "FRI"][index],
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white38,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${16 + index}",
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 TIMELINE ITEM (Vertical list items)
  Widget _buildTimelineItem({
    required String time,
    required String title,
    required String sub,
    required IconData icon,
    bool isTaken = false,
    bool isUpcoming = false,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Vertical Indicator
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  color: isTaken
                      ? accentCyan
                      : isUpcoming
                      ? accentCyan.withOpacity(0.1)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isTaken ? accentCyan : accentCyan.withOpacity(0.4),
                    width: isTaken ? 0 : 1.5,
                  ),
                ),
                child: isTaken
                    ? const Icon(Icons.check, size: 16, color: Colors.black)
                    : null,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          // Content Card
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(16),
                border: isUpcoming
                    ? Border.all(color: accentCyan.withOpacity(0.2))
                    : null,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: accentCyan.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: accentCyan, size: 22),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              time,
                              style: TextStyle(
                                color: isTaken
                                    ? accentCyan
                                    : isUpcoming
                                    ? accentCyan.withOpacity(0.7)
                                    : Colors.white38,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          sub,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 REFILL CARD
  Widget _buildRefillCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "REFILL STATUS",
            style: TextStyle(
              color: Colors.white38,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          // const Spacer(),
          SizedBox(height: 16),
          const Text(
            "12 days left",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0.7,
              minHeight: 8,
              backgroundColor: Colors.white10,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 DOCTOR NOTE CARD
  Widget _buildDoctorNoteCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "DOCTOR NOTE",
            style: TextStyle(
              color: Colors.white38,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          // const Spacer(),
          SizedBox(height: 16),
          Text(
            "“Monitor blood pressure levels after morning...",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          // const Spacer(),
          SizedBox(height: 16),
          InkWell(
            onTap: () {},
            child: Row(
              children: const [
                Icon(Icons.open_in_new, color: accentCyan, size: 14),
                SizedBox(width: 5),
                Text(
                  "View Dr. Aris",
                  style: TextStyle(
                    color: accentCyan,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Helper: Weekly Compliance Card
  Widget _buildWeeklyComplianceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E), // surfaceColor
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "WEEKLY COMPLIANCE",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "85%",
                style: TextStyle(
                  color: Color(0xFF81DEEA), // accentCyan
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "5% improvement from last week",
                style: TextStyle(color: Colors.white38, fontSize: 11),
              ),
            ],
          ),
          // Progress Ring
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  value: 0.85,
                  strokeWidth: 6,
                  color: const Color(0xFF81DEEA),
                  backgroundColor: Colors.white.withOpacity(0.05),
                ),
              ),
              const Icon(
                Icons.auto_graph_rounded,
                color: Color(0xFF81DEEA),
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔹 Helper: Next Dose Card
  Widget _buildNextDoseCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E), // surfaceColor
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "CRITICAL PULSE",
                style: TextStyle(
                  color: Color(0xFFFF8A65), // Muted Orange/Red
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.wb_sunny_outlined,
                color: Colors.white.withOpacity(0.2),
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            "Next Dose Window",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Vitamin C 500mg in 42 minutes",
            style: TextStyle(color: Colors.white54, fontSize: 14),
          ),
          const SizedBox(height: 20),
          // The Large Log Dose Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MedicationVerificationScreen(medicineName: "Vitamin C"),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00E5FF), // Bright Cyan
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add_circle_outline, size: 18),
                  SizedBox(width: 8),
                  Text(
                    "Log Dose",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: darkBg,
      elevation: 0,
      title: Row(
        children: const [
          CircleAvatar(
            radius: 18,
            backgroundColor: surfaceColor,
            backgroundImage: NetworkImage(
              'https://i.pravatar.cc/100?img=12',
            ), // Using NetworkImage for pravatar
          ),
          SizedBox(width: 12),
          Text(
            "Medikto",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NotificationScreen()),
          ),
          icon: const Icon(Icons.notifications, color: accentCyan),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
