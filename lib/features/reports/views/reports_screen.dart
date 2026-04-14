import 'package:flutter/material.dart';
import 'package:medikto/features/home/notifications/notification_screen.dart';
import 'package:medikto/features/reports/widgets/reports_action_sheet.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  // Brand Dark Colors
  static const Color darkBg = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);
  static const Color accentCyan = Color(0xFF81DEEA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: _buildAppBar(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// 1. TOP STATS GRID
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                mainAxisExtent: 110,
              ),
              delegate: SliverChildListDelegate([
                _buildStatCard("ALL FILES", "24", Icons.folder_open),
                _buildStatCard("PRESCRIPTIONS", "12", Icons.medication),
                _buildStatCard("LAB REPORTS", "8", Icons.biotech),
                _buildStatCard("IMAGING", "4", Icons.calendar_view_month),
              ]),
            ),
          ),

          /// 2. RECENT ACTIVITY SECTION
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Text(
                  "RECENT ACTIVITY",
                  style: TextStyle(
                    color: accentCyan,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 15),
                _buildRecentTile(
                  "Blood Panel Added",
                  "Diagnostics Center • 2h ago",
                  Icons.analytics,
                ),
                _buildRecentTile(
                  "RX Refill Alert",
                  "Lipitor Refill Needed • 5h ago",
                  Icons.notifications_active,
                  isAlert: true,
                ),

                const SizedBox(height: 30),

                /// 3. TIMELINE HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "October 2023",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Diagnostic History & Protocols",
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                      ],
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.filter_list,
                        size: 16,
                        color: accentCyan,
                      ),
                      label: const Text(
                        "Filter",
                        style: TextStyle(color: accentCyan),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ]),
            ),
          ),

          /// 4. DETAILED REPORT CARDS
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildDetailReportCard(
                  index == 0
                      ? "Lipid Management Protocol"
                      : "Comprehensive Metabolic Panel",
                  index == 0 ? "CRITICAL" : "LABORATORY",
                  index == 0 ? "Dr. Aris Thorne" : "LabQuest Central",
                  index == 0 ? Colors.redAccent : accentCyan,
                ),
                childCount: 2,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      // floatingActionButton: _buildFAB(context),
    );
  }

  /// 🔹 STATS CARD HELPER (Top Grid)
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
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
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

  /// 🔹 RECENT TILE HELPER
  Widget _buildRecentTile(
    String title,
    String sub,
    IconData icon, {
    bool isAlert = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isAlert
                  ? Colors.redAccent.withOpacity(0.1)
                  : accentCyan.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: isAlert ? Colors.redAccent : accentCyan,
              size: 20,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  sub,
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 14),
        ],
      ),
    );
  }

  /// 🔹 DETAILED REPORT CARD (Bottom List)
  Widget _buildDetailReportCard(
    String title,
    String tag,
    String source,
    Color tagColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.description, color: accentCyan),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: tagColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: tagColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.calendar_today, size: 12, color: Colors.white38),
              const SizedBox(width: 4),
              const Text(
                "Oct 14, 2023",
                style: TextStyle(color: Colors.white38, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.person_outline, size: 14, color: Colors.white38),
              const SizedBox(width: 5),
              Text(
                source,
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white12,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("View"),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  color: accentCyan,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.download, color: Colors.black),
                ),
              ),
            ],
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
            backgroundColor: Colors.white12,
            child: Icon(Icons.person, color: Colors.white, size: 20),
          ),
          SizedBox(width: 12),
          Text(
            "Medikto",
            style: TextStyle(color: accentCyan, fontWeight: FontWeight.bold),
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
          icon: const Icon(Icons.notifications_none, color: accentCyan),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  // Widget _buildFAB(BuildContext context) {
  //   return FloatingActionButton(
  //     onPressed: () {},
  //     backgroundColor: accentCyan,
  //     child: const Icon(Icons.add, color: Colors.black),
  //   );
  // }
}
