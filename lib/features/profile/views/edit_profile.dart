import 'package:flutter/material.dart';
import 'package:medikto/core/utils/widgets/custom_button.dart';
import 'package:medikto/core/utils/widgets/custom_textfields.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final Size screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF3D3D3D)),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.info_outline_rounded, color: Color(0xFF3D3D3D)),
          ),
        ],
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xFF3D3D3D),
          ),
        ),
      ),

      /// 🔥 Stack kept same (UI unchanged)
      body: Stack(
        children: [
          /// 🔥 Smooth scroll
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenSize.height * 0.016),

                  /// 🔹 Profile Image
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 0,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade100,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 16,
                              color: Color(0xFF7D7D7D),
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
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF263238),
                    ),
                  ),

                  SizedBox(height: screenSize.height * 0.01),

                  /// 🔹 Fields
                  _buildField(
                    title: "First Name",
                    hint: "Enter your first name",
                  ),

                  _buildField(title: "Contact", hint: "+91 - "),

                  _buildField(
                    title: "Blood Group",
                    hint: "Select Blood Group",
                    suffixIcon: Icons.keyboard_arrow_down_rounded,
                  ),

                  /// 🔹 Age + Gender
                  Row(
                    children: [
                      _buildField(title: "Age", hint: "Age", width: 160),
                      SizedBox(width: screenSize.width * 0.05),
                      _buildGender(),
                    ],
                  ),

                  /// 🔹 Height + Weight
                  Row(
                    children: [
                      _buildField(
                        title: "Height",
                        hint: "Cm",
                        width: 160,
                        suffixIcon: Icons.keyboard_arrow_down_outlined,
                      ),
                      SizedBox(width: screenSize.width * 0.02),
                      _buildField(
                        title: "Weight",
                        hint: "Kg's",
                        width: 160,
                        suffixIcon: Icons.keyboard_arrow_down_outlined,
                      ),
                    ],
                  ),

                  SizedBox(height: screenSize.height * 0.05),

                  const Text(
                    "ABHA Health Card",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF263238),
                    ),
                  ),

                  SizedBox(height: screenSize.height * 0.1),
                ],
              ),
            ),
          ),

          /// 🔥 Bottom Button (same UI)
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: CustomButton(
              onPressed: () => Navigator.pop(context),
              buttonColor: const Color(0xFF213598),
              buttonText: "Save Changes",
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔥 Reusable Field (no UI change)
  Widget _buildField({
    required String title,
    required String hint,
    double? width,
    IconData? suffixIcon,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenSize.height * 0.005),
      child: AppTextFormFieldTitled(
        width: width,
        focusColor: Colors.black,
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 16,
          color: Color(0xA3555555),
          fontWeight: FontWeight.w400,
        ),
        borderColor: const Color(0xA3555555),
        fillColor: Colors.white,
        color: Colors.white,
        title: title,
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Color(0xFF555555),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }

  /// 🔥 Gender Widget
  Widget _buildGender() {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Gender",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF555555),
            ),
          ),
          SizedBox(height: screenSize.height * 0.01),
          Row(
            children: [
              _genderOption("Male"),
              SizedBox(width: screenSize.width * 0.04),
              _genderOption("Female"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _genderOption(String text) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF555555)),
          ),
        ),
        SizedBox(width: screenSize.width * 0.02),
        Text(
          text,
          style: const TextStyle(fontSize: 16, color: Color(0xFF555555)),
        ),
      ],
    );
  }
}
