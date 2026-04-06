import 'package:flutter/material.dart';
import 'package:medikto/features/reports/widgets/reports_action_sheet.dart';
import 'package:medikto/features/reports/widgets/reports_card.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int selectedIndex = 0;

  final List<String> filters = const [
    "All",
    "Recent",
    "Prescriptions",
    "Lab Tests",
  ];

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => const ReportActionsSheet(
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          /// 🔹 Fixed Filters (Doesn't scroll with the list)
          const SizedBox(height: 12),
          RepaintBoundary(child: _buildFilters()),
          const SizedBox(height: 12),

          /// 🔹 Scrollable Grid Area
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return const RepaintBoundary(
                          child: ReportCard());
                    }, childCount: 10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          mainAxisExtent: 140,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFAB(context),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 0,
      title: const Padding(
        padding: EdgeInsets.only(left: 20),
        child: Text(
          "Reports",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xFF3D3D3D),
          ),
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Icon(Icons.search, color: Color(0xFF3D3D3D)),
        ),
      ],
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 34,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return _FilterChip(
            label: filters[index],
            isSelected: selectedIndex == index,
            onTap: () {
              if (selectedIndex != index) {
                setState(() => selectedIndex = index);
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return SizedBox(
      height: 44,
      child: FloatingActionButton.extended(
        extendedPadding: const EdgeInsets.symmetric(horizontal: 30),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () => _showBottomSheet(context),
        backgroundColor: const Color(0xFF213598),
        icon: const Icon(Icons.add, color: Colors.white, size: 20),
        label: const Text(
          "Add Reports",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

/// 🔥 Extracted FilterChip to isolate rebuilds
class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: isSelected ? const Color(0xFF213598) : Colors.white,
          border: Border.all(
            color: isSelected
                ? const Color(0xFF213598)
                : const Color(0xFF555555),
            width: 0.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14, // Slightly reduced for better fit
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF7D7D7D),
          ),
        ),
      ),
    );
  }
}
