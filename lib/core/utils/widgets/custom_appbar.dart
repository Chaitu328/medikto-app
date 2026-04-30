import 'package:flutter/material.dart';
import 'package:medikto/bottom_bar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? showBackButton;
  final VoidCallback? onBack;
  final Color? backgroundColor;
  final TextStyle? titleStyle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.onBack,
    this.backgroundColor,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: backgroundColor ?? Colors.white,
      // elevation: 0,
      // surfaceTintColor: Colors.transparent,
      // scrolledUnderElevation: 0,
      titleSpacing: 0,
      leadingWidth: 56,

      /// 🔙 Back Button
      leading: showBackButton == true
          ? InkWell(
              onTap:
                  onBack ??
                  () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      // Optional: Redirect to Home if there's nowhere to go back to
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BaseBottomNavigationPage(),
                        ),
                      );
                    }
                  },
              child: const Icon(
                size: 20,
                Icons.arrow_back_ios_new,
                color: Color(0xFFffffff),
              ),
            )
          : null,
      /// 📝 Title
      title: showBackButton == false
          ? Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                title ?? '',
                style:
                    titleStyle ??
                    TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                      color: Color(0xFFffffff),
                ),
              ),
            )
          : Text(
              title ?? '',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xFFffffff),
              ),
            ),
    );
  }

  /// 🔥 Required for AppBar height
  @override
  Size get preferredSize => const Size.fromHeight(60);
}
