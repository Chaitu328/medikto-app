import 'package:flutter/material.dart';
import 'package:medikto/core/utils/widgets/custom_appbar.dart';
import 'package:medikto/features/profile/views/edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context); // ✅ correct
    

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: CustomAppBar(title: "Profile"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(), // 🔥 smooth scroll
          child: Column(
            children: [
              SizedBox(height: screenSize.height * 0.016),

              /// 🔹 Profile Card
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
                  padding: const EdgeInsets.fromLTRB(10, 20, 20, 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Color(0xFF5F6368),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 20),

                          /// 🔹 Text Section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Shiva Sai Chidurala",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF3D3D3D),
                                ),
                              ),
                              SizedBox(height: screenSize.height * 0.005),

                              RichText(
                                text: TextSpan(
                                  text: "Health ID : ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF5F6368),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "shiva@abdm",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF213598),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: screenSize.height * 0.005),

                              RichText(
                                text: TextSpan(
                                  text: "ABDM : ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF5F6368),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "12-3456-7890-1234",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF213598),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios, color: Colors.black),
                    ],
                  ),
                ),
              ),

              SizedBox(height: screenSize.height * 0.01),
              Image.asset("assets/images/health-premium.png"),

              SizedBox(height: screenSize.height * 0.01),

              /// 🔹 Settings Section
              _buildSection(
                title: "Settings",
                children: [
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Notifications", // Your existing title
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF3D3D3D),
                      ),
                    ),

                    /// 🔵 LEADING ICON
                    leading: const Icon(
                      Icons.notifications_outlined,
                      color: Color(0xFF5F6368),
                    ),

                    /// 🟢 TRAILING SWITCH INTEGRATION
                    trailing: Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },

                        /// 🔵 Thumb (circle)
                        thumbColor: WidgetStateProperty.resolveWith<Color>((
                          states,
                        ) {
                          if (states.contains(WidgetState.selected)) {
                            return const Color(0xFF213598); // ON thumb
                          }
                          return const Color(0xFF929292); // OFF thumb
                        }),

                        /// 🟦 Track (background)
                        trackColor: WidgetStateProperty.resolveWith<Color>((
                          states,
                        ) {
                          if (states.contains(WidgetState.selected)) {
                            return const Color(
                              0xFF213598,
                            ).withAlpha(50); // ON background
                          }
                          return Colors.white; // OFF background
                        }),

                        /// 🔥 Border
                        trackOutlineColor:
                            WidgetStateProperty.resolveWith<Color>((states) {
                              if (states.contains(WidgetState.selected)) {
                                return const Color(0xFF213598); // ON border
                              }
                              return const Color(0xFF929292); // OFF border
                            }),
                        trackOutlineWidth: WidgetStateProperty.all(2),
                      ),
                    ),
                  ),
                  _ListItem(
                    icon: Icons.wordpress_outlined,
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
                children: const [
                  _ListItem(
                    icon: Icons.key,
                    title: "Change Password",
                    trailing: Icons.arrow_forward_ios,
                  ),
                ],
              ),

              SizedBox(height: screenSize.height * 0.02),

              /// 🔹 Refer
              _buildSection(
                title: "Refer & Earn",
                children: const [
                  _ListItem(
                    icon: Icons.card_giftcard,
                    title: "Get 50rs",
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
                  _ListItem(icon: Icons.logout, title: "Logout"),
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

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔥 Reusable Section (NO UI CHANGE)
  Widget _buildSection({String? title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xFF3D3D3D),
              ),
            ),
            const SizedBox(height: 10),
          ],
          ...children,
        ],
      ),
    );
  }
}

/// 🔥 Optimized ListTile (Reusable)
class _ListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final IconData? trailing;
  final Color? color;

  const _ListItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, size: 24, color: color ?? const Color(0xFF5F6368)),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: color ?? const Color(0xFF3D3D3D),
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: const TextStyle(fontSize: 14, color: Color(0xFF6C6B69)),
            )
          : null,
      trailing: trailing != null
          ? Icon(trailing, size: 20, color: const Color(0xFF5F6368))
          : null,
      onTap: () {},
    );
  }
}
