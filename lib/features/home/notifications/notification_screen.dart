import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:medikto/features/medications/data/medication_provider.dart';
import 'package:medikto/features/medications/models/today_scheduled_model.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  // Theme Colors consistent with your dashboard
  static const Color darkBg = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);
  static const Color accentCyan = Color(0xFF81DEEA);

  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();

    /// Initial API call
    Future.microtask(() {
      ref.refresh(getTodayScheduleProvider);
    });

    /// Auto refresh every 5 seconds
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      ref.refresh(getTodayScheduleProvider);
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todaySchedule = ref.watch(getTodayScheduleProvider);

    return Scaffold(
      backgroundColor: darkBg,
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.refresh(getTodayScheduleProvider.future);
        },
        backgroundColor: darkBg,
        color: accentCyan,

        child: todaySchedule.when(
          data: (response) {
            final List<TodayScheduleModel> notifications = response.data ?? [];

            return CustomScrollView(
              // physics: const BouncingScrollPhysics(),
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 10)),

                /// 🔹 Header Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent Updates (${notifications.length})",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // TextButton(
                        //   onPressed: () {},
                        //   child: const Text(
                        //     "Auto Refreshing",
                        //     style: TextStyle(color: accentCyan, fontSize: 12),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
        
                /// 🔹 Empty State
                if (notifications.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        "No notifications available",
                        style: TextStyle(color: Colors.white54, fontSize: 15),
                      ),
                    ),
                  )
                else
                  /// 🔹 Notification List
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final item = notifications[index];
        
                        return _NotificationTile(item: item);
                      }, childCount: notifications.length),
                    ),
                  ),

                const SliverToBoxAdapter(child: SizedBox(height: 50)),
              ],
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(color: accentCyan),
            );
          },
          error: (e, _) {
            return Center(
              child: Text(
                e.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: darkBg,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 20,
        ),
      ),
      title: const Text(
        "Notifications",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      
    );
  }
}

/// ✅ High Performance Notification Tile
class _NotificationTile extends StatelessWidget {
  final TodayScheduleModel item;

  const _NotificationTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final bool isTaken = item.status.toString().toLowerCase() == "taken";

    return RepaintBoundary(
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isTaken ? const Color(0xFF1E1E1E) : const Color(0xFF252A2C),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isTaken
                ? Colors.transparent
                : const Color(0xFF81DEEA).withOpacity(0.2),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Container
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: _getIconColor(item.status).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIcon(item.status),
                color: _getIconColor(item.status),
                size: 22,
              ),
            ),

            const SizedBox(width: 15),

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.name ?? "Medication Reminder",
                          style: TextStyle(
                            color: isTaken ? Colors.white70 : Colors.white,
                            fontWeight: isTaken
                                ? FontWeight.w500
                                : FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Text(
                        _formatTime(item.takenAt ?? ""),
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Text(
                    _buildBodyText(),
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Unread Indicator Dot
            if (!isTaken)
              Container(
                margin: const EdgeInsets.only(left: 10, top: 5),
                height: 8,
                width: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF81DEEA),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

String _buildBodyText() {
    final medicineName = item.name ?? "Medicine";
    final dosage = item.dosage ?? "";

    switch (item.status.toString().toLowerCase()) {
      case "taken":
        return "$medicineName $dosage marked as taken successfully.";

      case "pending":
        return "It's time to take your $medicineName $dosage dose.";

      case "missed":
        return "You missed your scheduled dose of $medicineName.";

      default:
        return "$medicineName status updated.";
    }
  }

  String _formatTime(dynamic time) {
    try {
      if (time == null) return "";

      final parsed = DateTime.parse(time.toString()).toLocal();

      return DateFormat('hh:mm a').format(parsed);
    } catch (e) {
      return "Now";
    }
  }

  IconData _getIcon(String? status) {
    switch (status?.toLowerCase()) {
      case 'taken':
        return Icons.check_circle_rounded;

      case 'missed':
        return Icons.warning_amber_rounded;

      case 'pending':
        return Icons.medication_rounded;

      default:
        return Icons.notifications_active_rounded;
    }
  }

  Color _getIconColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'taken':
        return const Color(0xFF81C784);

      case 'missed':
        return const Color(0xFFE57373);

      case 'pending':
        return const Color(0xFF81DEEA);

      default:
        return Colors.white70;
    }
  }
}