import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MedicationVerificationScreen extends StatefulWidget {
  final String medicineName;
  const MedicationVerificationScreen({super.key, required this.medicineName});

  @override
  State<MedicationVerificationScreen> createState() =>
      _MedicationVerificationScreenState();
}

class _MedicationVerificationScreenState
    extends State<MedicationVerificationScreen> {
  static const Color darkBg = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);
  static const Color accentCyan = Color(0xFF00E5FF);

  File? capturedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _captureProofImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        capturedImage = File(image.path);
      });
    }
  }

  Future<void> _captureSelfie() async {
    final image = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        capturedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "VERIFICATION PROTOCOL",
                style: TextStyle(
                  color: accentCyan,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Today's Schedule",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),

              /// 1. CAMERA SCANNER FRAME
              _buildCameraFrame(),

              const SizedBox(height: 30),

              /// 2. VERIFY BUTTON
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentCyan,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () => _captureProofImage(),
                icon: const Icon(Icons.camera_alt),
                label: const Text(
                  "Verify with Selfie",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 20),

              /// 3. LOGGING INFO
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Colors.white38,
                    size: 14,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      "AUTOMATIC DATE, TIME, AND LOCATION LOGGING ENABLED",
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              /// 4. RECENT ACTIVITY LIST
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "RECENT ACTIVITY",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "View History",
                      style: TextStyle(
                        color: accentCyan,
                        fontSize: 12,
                       
                      ),
                    ),
                  ),
                ],
              ),
              _buildActivityTile(
                "Omega-3",
                "08:30 AM • Verified",
                "TAKEN",
                Colors.teal,
              ),
              _buildActivityTile(
                "Vitamin D3",
                "11:00 AM • Pending",
                "MISSED",
                Colors.redAccent,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  
  Widget _buildCorner({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double angle,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          height: 30,
          width: 30,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: accentCyan, width: 3),
              left: BorderSide(color: accentCyan, width: 3),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityTile(
    String name,
    String desc,
    String status,
    Color statusColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: statusColor.withOpacity(0.1),
            child: Icon(
              name == "Omega-3" ? Icons.link : Icons.history,
              color: statusColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  desc,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: statusColor.withOpacity(0.5)),
            ),
            child: Row(
              children: [
                CircleAvatar(radius: 3, backgroundColor: statusColor),
                const SizedBox(width: 5),
                Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: darkBg,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      title: const Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.white12,
            child: Icon(Icons.person, color: Colors.white, size: 18),
          ),
          SizedBox(width: 10),
          Text(
            "Medikto",
            style: TextStyle(
              color: accentCyan,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none, color: Colors.white),
        ),
      ],
    );
  }


Widget _buildCameraFrame() {
    return Container(
      height: 350,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: capturedImage != null
            ? DecorationImage(
                image: FileImage(capturedImage!),
                fit: BoxFit.cover,
              )
            : null,
        color: surfaceColor,
      ),
      child: Stack(
        children: [
          /// 🌫 Dark overlay for better contrast
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.black.withOpacity(
                capturedImage != null ? 0.2 : 0.45,
              ),
            ),
          ),

          /// 🔥 CORNERS
          _buildCorner(top: 0, left: 0, angle: 0),
          _buildCorner(top: 0, right: 0, angle: 1.57),
          _buildCorner(bottom: 0, left: 0, angle: 4.71),
          _buildCorner(bottom: 0, right: 0, angle: 3.14),

          /// 📷 CENTER CONTENT
          if (capturedImage == null)
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, color: Colors.white54, size: 55),
                  SizedBox(height: 10),
                  Text(
                    "Tap to capture proof",
                    style: TextStyle(
                      color: Colors.white54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

          // /// 📌 BOTTOM INSTRUCTION
          // Positioned(
          //   bottom: 18,
          //   left: 18,
          //   right: 18,
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(
          //       horizontal: 16,
          //       vertical: 10,
          //     ),
          //     decoration: BoxDecoration(
          //       color: Colors.black.withOpacity(0.6),
          //       borderRadius: BorderRadius.circular(16),
          //       border: Border.all(
          //         color: const Color(0xFF00E5FF).withOpacity(0.4),
          //       ),
          //     ),
          //     child: const Text(
          //       "Tap to capture proof of medication",
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //         color: Color(0xFF00E5FF),
          //         fontSize: 12,
          //         fontWeight: FontWeight.w600,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }


}
