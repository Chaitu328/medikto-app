import 'package:flutter/material.dart';
import 'package:medikto/core/utils/widgets/custom_appbar.dart';
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
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset("assets/images/health-premium.png"),
              ),

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
                        value: isSwitched,
                        onChanged: (value) =>
                            setState(() => isSwitched = value),
                        activeTrackColor: accentCyan.withOpacity(0.3),
                        activeColor: accentCyan,
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
                children: const [
                  _ListItem(
                    icon: Icons.logout,
                    title: "Logout",
                    color: Colors.white70,
                  ),
                ],
              ),

              SizedBox(height: screenSize.height * 0.02),

              /// 🔹 Delete
              _buildSection(
                children: const [
                  _ListItem(
                    icon: Icons.delete_outline,
                    title: "Delete Account",
                    color: Color(0xFFEF3235),
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
