import 'package:flutter/material.dart';

class ActivityHistoryScreen extends StatelessWidget {
  const ActivityHistoryScreen({super.key});

  // Colors consistent with your App Theme
  static const Color darkBg = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);
  static const Color accentCyan = Color(0xFF00E5FF);

  // Mock Data List for the History
  final List<Map<String, dynamic>> historyData = const [
    {"name": "Omega-3", "desc": "08:30 AM • Verified", "status": "TAKEN", "color": Colors.teal},
    {"name": "Vitamin D3", "desc": "11:00 AM • Pending", "status": "MISSED", "color": Colors.redAccent},
    {"name": "Lisinopril", "desc": "Yesterday • 09:00 PM", "status": "TAKEN", "color": Colors.teal},
    {"name": "Metformin", "desc": "Yesterday • 02:00 PM", "status": "TAKEN", "color": Colors.teal},
    {"name": "Atorvastatin", "desc": "Oct 22 • 08:00 AM", "status": "MISSED", "color": Colors.redAccent},
    {"name": "Vitamin C", "desc": "Oct 21 • 12:00 PM", "status": "TAKEN", "color": Colors.teal},
    {"name": "Omega-3", "desc": "Oct 21 • 08:30 AM", "status": "TAKEN", "color": Colors.teal},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: darkBg,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "Activity History",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "RECENT LOGS",
              style: TextStyle(
                color: accentCyan.withOpacity(0.7),
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              physics: const BouncingScrollPhysics(),
              itemCount: historyData.length,
              itemBuilder: (context, index) {
                final item = historyData[index];
                return _buildActivityTile(
                  item['name'],
                  item['desc'],
                  item['status'],
                  item['color'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Same design as provided in your snippet
  Widget _buildActivityTile(
    String name,
    String desc,
    String status,
    Color statusColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15), // Consistent spacing
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: statusColor.withOpacity(0.1),
            child: Icon(
              name == "Omega-3" ? Icons.link : Icons.history,
              color: statusColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  desc,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: statusColor.withOpacity(0.5)),
            ),
            child: Row(
              children: [
                CircleAvatar(radius: 3, backgroundColor: statusColor),
                const SizedBox(width: 5),
                Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}