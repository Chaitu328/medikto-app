import 'package:flutter/material.dart';
import 'package:medikto/features/home/add_reports/health_data/add_blood_pressure.dart';
import 'package:medikto/features/home/add_reports/health_data/add_body_temparature.dart';
import 'package:medikto/features/home/add_reports/health_data/add_heart_rate.dart';
import 'package:medikto/features/home/add_reports/health_data/add_sugar_levels.dart';
import 'package:medikto/features/home/add_reports/health_records/add_lab_reports.dart';
import 'package:medikto/features/home/add_reports/health_records/add_prescription_file.dart';
import 'package:medikto/features/home/add_reports/health_records/add_vaccination_reports.dart';
import 'package:medikto/features/home/home_view/home_screen.dart';
import 'package:medikto/features/home/add_reports/health_records/add_medicine_reports.dart';
import 'package:medikto/features/home/widgets/health_data_card.dart';
import 'package:medikto/features/profile/views/profile_screen.dart';
import 'package:medikto/features/reports/views/reports_screen.dart';
import 'package:medikto/features/vitals/views/vitals_screen.dart';

class BaseBottomNavigationPage extends StatefulWidget {
  const BaseBottomNavigationPage({super.key});

  @override
  State<BaseBottomNavigationPage> createState() =>
      _BaseBottomNavigationPageState();
}

class _BaseBottomNavigationPageState extends State<BaseBottomNavigationPage> {
  int _currentIndex = 0;

  /// 🔥 Keep screens alive (NO rebuild → smooth UI)
  final List<Widget> _tabs = const [
    HomeScreen(),
    ReportsScreen(),
    VitalsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    if (_currentIndex == index) return;
    setState(() => _currentIndex = index);
  }

  /// 🔹 Static data (const → better performance)
  final List<Map<String, String>> healthData = const [
    {"name": "Blood Pressure", "image": "assets/images/blood-drop.png"},
    {"name": "Heart Rate", "image": "assets/images/blood-pressure.png"},
    {"name": "Body Temperature", "image": "assets/images/thermometer.png"},
    {"name": "Sugar Levels", "image": "assets/images/diabets-test.png"},
  ];

  final List<Map<String, String>> healthRecords = const [
    {"name": "Medical Reports", "image": "assets/images/profile.png"},
    {"name": "Vaccination", "image": "assets/images/syringe.png"},
    {"name": "Lab Reports", "image": "assets/images/dna-tests.png"},
    {"name": "Prescription", "image": "assets/images/diabets-test.png"},
  ];


  Widget _getHealthDataScreen(int index) {
    switch (index) {
      case 0:
        return const AddBloodPressureScreen();
      case 1:
        return const AddHeartRateScreen();
      case 2:
        return const AddBodyTemparatureScreen();
      case 3:
        return const AddSugarLevelsScreen();
      default:
        return const SizedBox();
    }
  }

  Widget _getHealthRecordScreen(int index) {
    switch (index) {
      case 0:
        return const AddMedicalReportsScreen();
      case 1:
        return const AddVaccinationReportsScreen();
      case 2:
        return const AddLabReportsScreen();
      case 3:
        return const AddPrescriptionFileScreen();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,

      /// 🔥 Smooth tab switching
      body: IndexedStack(index: _currentIndex, children: _tabs),

      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          /// 🔹 Bottom Bar (unchanged UI)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.only(top: 10),
            child: Theme(
              data: Theme.of(
                context,
              ).copyWith(splashFactory: NoSplash.splashFactory),
              child: BottomNavigationBar(
                currentIndex: _currentIndex > 2
                    ? _currentIndex + 1
                    : _currentIndex,
                onTap: (index) {
                  if (index == 2) return;
                  _onItemTapped(index > 2 ? index - 1 : index);
                },
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                backgroundColor: Colors.white,
                selectedItemColor: const Color(0xFF213598),
                unselectedItemColor: const Color(0xFF5F6368),
                showSelectedLabels: true,
                selectedLabelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                items: [
                  BottomNavigationBarItem(
                    icon: _currentIndex == 0
                        ? Image.asset(
                            "assets/images/item1_selected.png",
                            width: 18,
                          )
                        : Image.asset("assets/images/item1.png", width: 18),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/item2.png",
                      width: 20,
                      color: _currentIndex == 1
                          ? const Color(0xFF213598)
                          : const Color(0xFF5F6368),
                    ),
                    label: "Reports",
                  ),
                  const BottomNavigationBarItem(
                    icon: SizedBox.shrink(),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: _currentIndex == 2
                        ? Image.asset(
                            "assets/images/item3_selected.png",
                            width: 20,
                          )
                        : Image.asset("assets/images/item3.png", width: 20),
                    label: "Vitals",
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/item4.png",
                      width: 20,
                      color: _currentIndex == 3
                          ? const Color(0xFF213598)
                          : const Color(0xFF5F6368),
                    ),
                    label: "Profile",
                  ),
                ],
              ),
            ),
          ),

          /// 🔥 Center Button (optimized)
          Positioned(
            bottom: 6,
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () => _openBottomSheet(context, size),
              child: Container(
                height: 54,
                width: 54,
                decoration: const BoxDecoration(
                  color: Color(0xFF213598),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔥 BottomSheet (optimized scrolling)
  void _openBottomSheet(BuildContext context, Size size) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.01),
                  Center(
                    child: Container(
                      height: 5,
                      width: 50,
                      color: const Color(0xFFCDCFD0),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),

                  /// 🔹 Health Data
                  const Text(
                    "Health Data",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF263238),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),

                  _buildGrid(healthData, true),

                  SizedBox(height: size.height * 0.02),

                  /// 🔹 Health Records
                  const Text(
                    "Health Records",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF263238),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),

                  _buildGrid(healthRecords, false),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// 🔥 Reusable Grid (less rebuild cost)
  Widget _buildGrid(List<Map<String, String>> data, bool isHealthData) {
    return GridView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        mainAxisExtent: 90,
      ),
      itemBuilder: (context, index) {
        return HealthDataCard(
          title: data[index]["name"]!,
          image: data[index]["image"]!,
          onTap: () {
            Navigator.pop(context); // close sheet first
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => isHealthData
                    ? _getHealthDataScreen(index)
                    : _getHealthRecordScreen(index),
              ),
            );
          },
        );
      },
    );
  }
}
