import 'package:flutter/material.dart';
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

  /// 🔥 Use controller for smoother scroll
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),

      /// ✅ Smooth scroll physics
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(), // 🔥 smooth feel
        slivers: [
          /// 🔹 Filters
          SliverToBoxAdapter(
            child: RepaintBoundary(
              // 🔥 prevents unnecessary repaint
              child: _buildFilters(),
            ),
          ),

          /// 🔹 Grid
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return const RepaintBoundary(
                  // 🔥 isolates each item
                  child: ReportCard(),
                );
              }, childCount: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                mainAxisExtent: 140,
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: _buildFAB(context),
    );
  }

  /// 🔥 AppBar (const optimized)
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF3D3D3D)),
      title: const Text(
        "Reports",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color(0xFF3D3D3D),
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

  /// 🔥 Filters (only this rebuilds, not whole screen)
  Widget _buildFilters() {
    return SizedBox(
      height: 34,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        physics: const BouncingScrollPhysics(), // 🔥 smooth horizontal scroll
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              if (selectedIndex != index) {
                setState(() => selectedIndex = index);
              }
            },
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
                filters[index],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : const Color(0xFF7D7D7D),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 🔥 FAB (const optimized)
  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {},
      backgroundColor: const Color(0xFF213598),
      label: const Row(
        children: [
          Icon(Icons.add, color: Colors.white),
          SizedBox(width: 10),
          Text(
            "Add Reports",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
