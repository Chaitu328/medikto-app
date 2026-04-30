import 'package:flutter/material.dart';
import 'package:medikto/features/home/notifications/notification_screen.dart';
import 'package:medikto/features/medications/views/medical_records_screen.dart';
import 'package:medikto/features/medications/views/medication_verification_screen.dart';
import 'package:medikto/features/medications/views/selfie_verfication_medicine.dart';

class TimelineMedicine {
  String time;
  String title;
  String sub;
  IconData icon;
  bool isTaken;

  TimelineMedicine({
    required this.time,
    required this.title,
    required this.sub,
    required this.icon,
    this.isTaken = false,
  });
}

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
  DateTime selectedDate = DateTime.now();

  List<TimelineMedicine> medicines = [
    TimelineMedicine(
      time: "08:30 AM",
      title: "Atorvastatin 10mg",
      sub: "Cholesterol • Post-breakfast",
      icon: Icons.medication_rounded,
      isTaken: true,
    ),
    TimelineMedicine(
      time: "12:00 PM",
      title: "Vitamin C 500mg",
      sub: "Immune Support • With lunch",
      icon: Icons.vaccines_rounded,
    ),
    TimelineMedicine(
      time: "08:00 PM",
      title: "Multivitamin",
      sub: "Wellness • Before sleep",
      icon: Icons.inventory_2_outlined,
    ),
  ];

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
                  // _buildWeeklyComplianceCard(),

                  // const SizedBox(height: 15),

                  /// 🔴 Critical Pulse / Next Dose Card
                  _buildAddMedicationCard(),
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
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = medicines[index];

                  // ✅ Only next un-taken item is enabled
                  bool isCurrent =
                      index == medicines.indexWhere((e) => !e.isTaken);

                  return _buildAdvancedTimelineItem(
                    item: item,
                    isLast: index == medicines.length - 1,
                    isCurrent: isCurrent,
                    onMarkTaken: () {
                      setState(() {
                        medicines[index].isTaken = true;
                      });
                    },
                  );
                }, childCount: medicines.length),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 15)),

            /// ✅ PLACE IT HERE
            // SliverToBoxAdapter(child: _buildAddMedicationCard()),

            /// 🔹 5. REFILL & NOTES (Responsive Grid)
            // SliverPadding(
            //   padding: const EdgeInsets.all(20),
            //   sliver: SliverGrid(
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2,
            //       mainAxisSpacing: 15,
            //       crossAxisSpacing: 15,
            //       mainAxisExtent: 140, // Increased for long text safety
            //     ),
            //     delegate: SliverChildListDelegate([
            //       _buildRefillCard(),
            //       _buildDoctorNoteCard(),
            //     ]),
            //   ),
            // ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),

            /// ✅ ADD THIS HERE
            SliverToBoxAdapter(child: _buildMedicalComplianceButton()),

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

  /// 🔹 CALENDAR SECTION
  Widget _buildCalendarSection(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    // Logic: Calculate item width based on screen size so 5.5 items are visible
    // This gives a visual hint that the list is scrollable
    final itemWidth = screenWidth / 5.5;

    final List<DateTime> dates = List.generate(15, (index) {
      return DateTime.now().add(Duration(days: index - 2));
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          // Header remains padded
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${_getMonthName(selectedDate.month)} ${selectedDate.year}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // const Icon(
                //   Icons.calendar_month_outlined,
                //   color: Color(0xFF81DEEA),
                //   size: 20,
                // ),
              ],
            ),
          ),
          const SizedBox(height: 15),

          // Scrollable area
          SizedBox(
            height: 90, // Fixed height for the horizontal bar
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dates.length,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 20), // Start padding
              itemBuilder: (context, index) {
                final date = dates[index];
                bool isSelected = DateUtils.isSameDay(date, selectedDate);
                bool isToday = DateUtils.isSameDay(date, DateTime.now());

                return GestureDetector(
                  onTap: () => setState(() => selectedDate = date),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: itemWidth,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF81DEEA)
                          : const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(16),
                      border: isToday && !isSelected
                          ? Border.all(
                              color: const Color(0xFF81DEEA).withOpacity(0.5),
                            )
                          : Border.all(color: Colors.transparent),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _getWeekdayName(date.weekday),
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.white38,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper helpers for dynamic names without needing external packages
  String _getWeekdayName(int weekday) {
    return ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"][weekday - 1];
  }

  String _getMonthName(int month) {
    return [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ][month - 1];
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

  Widget _buildAdvancedTimelineItem({
    required TimelineMedicine item,
    required bool isLast,
    required bool isCurrent,
    required VoidCallback onMarkTaken,
  }) {
    bool isTaken = item.isTaken;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// 🔹 LEFT TIMELINE INDICATOR
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  color: isTaken
                      ? accentCyan
                      : isCurrent
                      ? accentCyan.withOpacity(0.1)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: accentCyan.withOpacity(0.5)),
                ),
                child: isTaken
                    ? const Icon(Icons.check, size: 16, color: Colors.black)
                    : null,
              ),
              if (!isLast)
                Expanded(child: Container(width: 2, color: Colors.white10)),
            ],
          ),

          const SizedBox(width: 20),

          /// 🔹 CARD
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(16),
                border: isCurrent
                    ? Border.all(color: accentCyan.withOpacity(0.3))
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE + TIME
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        item.time,
                        style: TextStyle(
                          color: isTaken
                              ? accentCyan
                              : isCurrent
                              ? accentCyan.withOpacity(0.7)
                              : Colors.white38,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Text(
                    item.sub,
                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                  ),

                  const SizedBox(height: 12),

                  /// 🔥 ACTION BUTTONS WITH ICONS FIXED
                  if (!isTaken && isCurrent) ...[
                    SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: ElevatedButton.icon(
                        // ✅ Changed to .icon
                        onPressed: onMarkTaken,
                        icon: const Icon(
                          Icons.check_circle_outline,
                          size: 18,
                        ), // ✅ Added Icon
                        label: const Text("Mark as Taken"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentCyan,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: OutlinedButton.icon(
                        // ✅ Changed to .icon
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SelfieVerficationMedicineScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          size: 18,
                          color: accentCyan,
                        ), // ✅ Added Icon
                        label: const Text("Verify with Selfie"),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white24),
                          foregroundColor: Colors.white70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],

                  /// ✅ TAKEN STATUS (Verification Badge)
                  if (isTaken)
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: accentCyan.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        // Added row for internal consistency
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.verified_user,
                            color: accentCyan,
                            size: 12,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "VERIFIED • LOGGED",
                            style: TextStyle(
                              color: accentCyan,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
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
  // Widget _buildRefillCard() {
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: surfaceColor,
  //       borderRadius: BorderRadius.circular(16),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Text(
  //           "REFILL STATUS",
  //           style: TextStyle(
  //             color: Colors.white38,
  //             fontSize: 10,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         // const Spacer(),
  //         SizedBox(height: 16),
  //         const Text(
  //           "12 days left",
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 22,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         const SizedBox(height: 10),
  //         ClipRRect(
  //           borderRadius: BorderRadius.circular(10),
  //           child: const LinearProgressIndicator(
  //             value: 0.7,
  //             minHeight: 8,
  //             backgroundColor: Colors.white10,
  //             valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // /// 🔹 DOCTOR NOTE CARD
  // Widget _buildDoctorNoteCard() {
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: surfaceColor,
  //       borderRadius: BorderRadius.circular(16),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Text(
  //           "DOCTOR NOTE",
  //           style: TextStyle(
  //             color: Colors.white38,
  //             fontSize: 10,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         // const Spacer(),
  //         SizedBox(height: 16),
  //         Text(
  //           "“Monitor blood pressure levels after morning...",
  //           overflow: TextOverflow.ellipsis,
  //           maxLines: 2,
  //           style: TextStyle(color: Colors.white70, fontSize: 12),
  //         ),
  //         // const Spacer(),
  //         SizedBox(height: 16),
  //         InkWell(
  //           onTap: () {},
  //           child: Row(
  //             children: const [
  //               Icon(Icons.open_in_new, color: accentCyan, size: 14),
  //               SizedBox(width: 5),
  //               Text(
  //                 "View Dr. Aris",
  //                 style: TextStyle(
  //                   color: accentCyan,
  //                   fontSize: 12,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  /// 🔹 Helper: Weekly Compliance Card

Widget _buildMedicalComplianceButton() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const MedicalRecordsScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: accentCyan,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        icon: const Icon(Icons.verified_user),
        label: const Text(
          "Medical Record Compliance",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    ),
  );
}
  Widget _buildAddMedicationCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E), // surfaceColor
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF81DEEA).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "QUICK ACTION",
                  style: TextStyle(
                    color: Color(0xFF81DEEA),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              Icon(
                Icons.add_moderator_outlined,
                color: Colors.white.withOpacity(0.2),
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Add Medication",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Keep track of your health by adding your daily prescriptions.",
            style: TextStyle(color: Colors.white54, fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to your medication adding logic

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MedicationVerificationScreen(
                      medicineName: "Add Medication",
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF81DEEA),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add_circle_outline, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Add New Medicine",
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
