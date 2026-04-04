import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? showBackButton;
  final VoidCallback? onBack;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      titleSpacing: 0,
      leadingWidth: 56,

      /// 🔙 Back Button
      leading: showBackButton == true
          ? InkWell(
              onTap: onBack ?? () => Navigator.pop(context),
              child: const Icon(
                size: 20,
                Icons.arrow_back_ios_new,
                color: Color(0xFF3D3D3D),
              ),
            )
          : null,

      /// 📝 Title
      title: Text(
        title ?? '',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color(0xFF3D3D3D),
        ),
      ),
    );
  }

  /// 🔥 Required for AppBar height
  @override
  Size get preferredSize => const Size.fromHeight(60);
}
