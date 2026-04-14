import 'package:flutter/material.dart';
import 'package:medikto/core/utils/widgets/custom_button.dart';
import 'package:medikto/core/utils/widgets/custom_textfields.dart';
import 'package:medikto/features/auth/widgets/gender_selection_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Theme Colors
  static const Color darkBg = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);
  static const Color accentCyan = Color(0xFF81DEEA);
  static const Color primaryBlue = Color(0xFF213598);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: 60,
        backgroundColor: darkBg,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.info_outline_rounded, color: Colors.white),
          ),
        ],
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenSize.height * 0.016),

                  /// 🔹 Profile Image (Dark Mode Styling)
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            color: surfaceColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white10, width: 2),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.white24,
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: Container(
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                              color: accentCyan,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenSize.height * 0.04),

                  const Text(
                    "Basic Details",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: screenSize.height * 0.02),

                  /// 🔹 Input Fields
                  _buildField(
                    title: "First Name",
                    hint: "Enter your first name",
                  ),

                  const SizedBox(height: 15),

                  AppTextFormFieldTitled(
                    
                    title: "Contact",
                    hintText: "Enter phone number",
                    focusColor: accentCyan,
                    fillColor: surfaceColor,
                    color: Colors.white,
                    textInputType: TextInputType.phone,
                    prefix: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "+91",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: accentCyan,
                        ),
                      ),
                    ),
                    borderColor: Colors.white10,
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white24,
                    ),
                    titleTextStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
                  
                  const SizedBox(height: 15),

                  _buildField(
                    title: "Blood Group",
                    hint: "Select Blood Group",
                    suffixIcon: Icons.keyboard_arrow_down_rounded,
                  ),

                  const SizedBox(height: 15),

                  /// 🔹 Age + Gender
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: _buildField(title: "Age", hint: "Age"),
                      ),
                      const SizedBox(width: 15),
                      const Expanded(
                        flex: 2,
                        child:
                            GenderSection(), // Ensure internal widget supports Dark Mode
                      )
                    ],
                  ),

                  const SizedBox(height: 15),

                  /// 🔹 Height + Weight
                  Row(
                    children: [
                      Expanded(
                        child: _buildField(
                          title: "Height",
                          hint: "Cm",
                          suffixIcon: Icons.height,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildField(
                          title: "Weight",
                          hint: "Kg's",
                          suffixIcon: Icons.monitor_weight_outlined,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: screenSize.height * 0.15,
                  ), // Spacing for bottom button
                ],
              ),
            ),
          ),

          /// 🔥 Bottom Save Button
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: CustomButton(
              onPressed: () => Navigator.pop(context),
              buttonColor: accentCyan, // Cyan pops better in Dark Mode
              buttonText: "Save Changes",
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔥 Dark Mode Field Helper
  Widget _buildField({
    required String title,
    required String hint,
    IconData? suffixIcon,
  }) {
    return AppTextFormFieldTitled(
      focusColor: accentCyan,
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white24,
        fontWeight: FontWeight.w400,
      ),
      borderColor: Colors.white10,
      fillColor: surfaceColor,
      color: Colors.white,
      title: title,
      titleTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
      ),
      suffixIcon: suffixIcon,
    );
  }
}
