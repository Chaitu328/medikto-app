import 'package:flutter/material.dart';
import 'package:medikto/core/utils/widgets/custom_appbar.dart';
import 'package:medikto/features/home/premium_plans_views/premium_plans.dart';
import 'package:medikto/features/profile/change_password_view/change_password_screen.dart';
import 'package:medikto/features/profile/views/edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSwitched = false;
  
  // Theme Colors consistent with your other dark mode screens
  static const Color darkBg = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);
  static const Color accentCyan = Color(0xFF81DEEA);

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: surfaceColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("Logout", style: TextStyle(color: Colors.white)),
          content: const Text(
            "Are you sure you want to logout?",
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.white54),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: accentCyan,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);

                /// 🔥 TODO: Add your logout logic here
                debugPrint("User Logged Out");
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: surfaceColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Delete Account",
            style: TextStyle(color: Colors.redAccent),
          ),
          content: const Text(
            "This action is permanent and cannot be undone.\n\nAre you sure you want to delete your account?",
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.white54),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEF3235),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);

                /// 🔥 TODO: Add delete API call here
                debugPrint("Account Deleted");
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: darkBg,
      appBar: CustomAppBar(
        title: "Profile",
        backgroundColor: darkBg,
        titleStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        onBack: () {},
        showBackButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: screenSize.height * 0.016),

              /// 🔹 Profile Card (Dark Mode)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditProfileScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(15, 20, 20, 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              color: accentCyan,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 15),

                          /// 🔹 Text Section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Shiva Sai Chidurala",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              RichText(
                                text: const TextSpan(
                                  text: "Health ID : ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white54,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "shiva@abdm",
                                      style: TextStyle(
                                        color: accentCyan,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 2),
                              RichText(
                                text: const TextSpan(
                                  text: "ABDM : ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white54,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "12-3456-7890-1234",
                                      style: TextStyle(
                                        color: accentCyan,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white24,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: screenSize.height * 0.02),
              _buildPremiumCard(),
              
              SizedBox(height: screenSize.height * 0.02),

              /// 🔹 Settings Section
              _buildSection(
                title: "Settings",
                children: [
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white70,
                    ),
                    title: const Text(
                      "Notifications",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    trailing: Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        padding: EdgeInsets.zero,
                        value: isSwitched,
                        onChanged: (value) =>
                            setState(() => isSwitched = value),
                        activeTrackColor: accentCyan.withAlpha(140),
                        activeThumbColor: accentCyan,
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.white10,
                        trackOutlineColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  const _ListItem(
                    icon: Icons.language,
                    title: "Language",
                    subtitle: "English",
                    trailing: Icons.arrow_forward_ios,
                  ),
                ],
              ),

              SizedBox(height: screenSize.height * 0.02),

              /// 🔹 Password
              _buildSection(
                title: "Password",
                children: [
                  _ListItem(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ChangePasswordScreen(),
                        ),
                      );
                    },
                    icon: Icons.key_outlined,
                    title: "Change Password",
                    trailing: Icons.arrow_forward_ios,
                  ),
                ],
              ),

              SizedBox(height: screenSize.height * 0.02),

              /// 🔹 Help
              _buildSection(
                title: "Help & Support",
                children: const [
                  _ListItem(
                    icon: Icons.info_outline,
                    title: "FAQs",
                    trailing: Icons.keyboard_arrow_down,
                  ),
                  _ListItem(
                    icon: Icons.phone_outlined,
                    title: "Contact Support",
                    subtitle: "User Query",
                    trailing: Icons.keyboard_arrow_down,
                  ),
                  _ListItem(
                    icon: Icons.security,
                    title: "Policies & Terms",
                    subtitle: "Service Terms & Conditions",
                    trailing: Icons.keyboard_arrow_down,
                  ),
                  _ListItem(
                    icon: Icons.report_outlined,
                    title: "Report an Issue",
                  ),
                ],
              ),

              SizedBox(height: screenSize.height * 0.02),

              /// 🔹 Logout
              _buildSection(
                
                children: [
                  _ListItem(
                    icon: Icons.logout,
                    title: "Logout",
                    color: Colors.white70,
                    onTap: _showLogoutDialog, // 👈 ADD THIS,
                    
                  ),
                ],
              ),

              SizedBox(height: screenSize.height * 0.02),

              /// 🔹 Delete
              _buildSection(
                children: [
                  _ListItem(
                    icon: Icons.delete_outline,
                    title: "Delete Account",
                    color: Color(0xFFEF3235),
                    onTap: _showDeleteDialog, // 👈 ADD THIS
                  ),
                ],
              ),

              const SizedBox(height: 100), // Space for bottom bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({String? title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: accentCyan,
                
              ),
            ),
            const SizedBox(height: 6),
          ],
          ...children,
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


}

class _ListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final IconData? trailing;
  final Color? color;
  final GestureTapCallback? onTap;

  const _ListItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, size: 22, color: color ?? Colors.white70),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: color ?? Colors.white,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: const TextStyle(fontSize: 12, color: Colors.white38),
            )
          : null,
      trailing: trailing != null
          ? Icon(trailing, size: 14, color: Colors.white24)
          : null,
      onTap: onTap,
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
