import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

// ✅ PDF imports
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart'; // 🔥 THIS FIXES PdfColors ERROR

class MedicalRecordsScreen extends StatefulWidget {
  const MedicalRecordsScreen({super.key});

  @override
  State<MedicalRecordsScreen> createState() => _MedicalRecordsScreenState();
}

class _MedicalRecordsScreenState extends State<MedicalRecordsScreen> {
  static const Color darkBg = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);
  static const Color accentCyan = Color(0xFF81DEEA);

  List<Map<String, dynamic>> records = [
    {
      "name": "Atorvastatin",
      "dose": "10",
      "unit": "mg",
      "time": "08:30 AM",
      "date": DateTime.now(),
      "image": null,
    },
    {
      "name": "Metformin",
      "dose": "500",
      "unit": "mg",
      "time": "12:00 PM",
      "date": DateTime.now().subtract(const Duration(days: 1)),
      "image": null,
    },
    {
      "name": "Lisinopril",
      "dose": "20",
      "unit": "mg",
      "time": "09:00 PM",
      "date": DateTime.now().subtract(const Duration(days: 3)),
      "image": null,
    },
  ];

  List<Map<String, dynamic>> filteredRecords = [];

  @override
  void initState() {
    super.initState();
    filteredRecords = records;
  }

  /// 🔹 FILTER LOGIC
  void _applyFilter(String filter) {
    DateTime now = DateTime.now();

    setState(() {
      if (filter == "Today") {
        filteredRecords = records
            .where((e) => _isSameDay(e["date"], now))
            .toList();
      } else if (filter == "Yesterday") {
        filteredRecords = records
            .where(
              (e) =>
                  _isSameDay(e["date"], now.subtract(const Duration(days: 1))),
            )
            .toList();
      } else if (filter == "Last 3 Days") {
        filteredRecords = records
            .where(
              (e) => e["date"].isAfter(now.subtract(const Duration(days: 3))),
            )
            .toList();
      } else if (filter == "Last 7 Days") {
        filteredRecords = records
            .where(
              (e) => e["date"].isAfter(now.subtract(const Duration(days: 7))),
            )
            .toList();
      } else {
        filteredRecords = records
            .where(
              (e) => e["date"].isAfter(now.subtract(const Duration(days: 30))),
            )
            .toList();
      }
    });
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// 🔹 SHARE POPUP
  void _showShareFilter() {
    showModalBottomSheet(
      context: context,
      backgroundColor: surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select Filter",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              ...[
                "Today",
                "Yesterday",
                "Last 3 Days",
                "Last 7 Days",
                "Last 1 Month",
              ].map((filter) {
                return ListTile(
                  title: Text(
                    filter,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    _applyFilter(filter);
                    await _generateAndSharePDF();
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  /// 🔥 PDF GENERATION + SHARE
  Future<void> _generateAndSharePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(24),
        build: (context) => [
          /// 🔹 HEADER
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "Medical Report",
                    style: pw.TextStyle(
                      fontSize: 22,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.blue100,
                      borderRadius: pw.BorderRadius.circular(6),
                    ),
                    child: pw.Text(
                      "Medikto",
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.blue800,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 6),

              pw.Text(
                "Generated on: ${_formatDate(DateTime.now())}",
                style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
              ),

              pw.SizedBox(height: 12),
              pw.Divider(thickness: 1),
              pw.SizedBox(height: 16),
            ],
          ),

          /// 🔹 LIST OF RECORDS
          ...filteredRecords.map((e) {
            return pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 12),
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(10),
                border: pw.Border.all(color: PdfColors.grey300),
              ),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  /// 🔹 LEFT ICON (instead of image for now)
                  pw.Container(
                    height: 40,
                    width: 40,
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey200,
                      borderRadius: pw.BorderRadius.circular(8),
                    ),
                    child: pw.Icon(
                      pw.IconData(0xe3d0), // generic icon
                      size: 20,
                    ),
                  ),

                  pw.SizedBox(width: 12),

                  /// 🔹 TEXT CONTENT
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        /// NAME
                        pw.Text(
                          e["name"] ?? "",
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),

                        pw.SizedBox(height: 4),

                        /// DOSE
                        pw.Text(
                          "Dose: ${e["dose"] ?? "--"} ${e["unit"] ?? ""}",
                          style: pw.TextStyle(
                            fontSize: 12,
                            color: PdfColors.grey700,
                          ),
                        ),

                        pw.SizedBox(height: 2),

                        /// TIME
                        pw.Text(
                          "Time: ${e["time"]}",
                          style: pw.TextStyle(
                            fontSize: 11,
                            color: PdfColors.grey600,
                          ),
                        ),

                        pw.SizedBox(height: 2),

                        /// DATE
                        pw.Text(
                          "Date: ${_formatDate(e["date"])}",
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 🔹 VERIFIED BADGE
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.green100,
                      borderRadius: pw.BorderRadius.circular(20),
                    ),
                    child: pw.Text(
                      "VERIFIED",
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.green800,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),

          /// 🔹 FOOTER
          pw.SizedBox(height: 20),
          pw.Divider(),
          pw.SizedBox(height: 6),
          pw.Text(
            "Generated by Medikto",
            style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
          ),
        ],
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/medical_report.pdf");
    await file.writeAsBytes(await pdf.save());

    await Share.shareXFiles([XFile(file.path)]);
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: 60,
        backgroundColor: darkBg,
        title: const Text("Medical Records"),
        actionsPadding: const EdgeInsets.only(right: 20),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: accentCyan),
            onPressed: _showShareFilter,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredRecords.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          final item = filteredRecords[index];

          return RepaintBoundary(
            // 🔥 reduces jank
            child: _buildPremiumMedicalCard(item),
          );
        },
      ),
    );
  }

  Widget _buildPremiumMedicalCard(Map<String, dynamic> item) {
    final imagePath = item["image"];

    return Container(
      margin: const EdgeInsets.only(bottom: 14, left: 20, right: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// 🔹 LEFT → IMAGE (SMALL THUMBNAIL)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: imagePath != null
                    ? Image.file(
                        File(imagePath),
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                        cacheWidth: 200, // 🔥 performance optimization
                      )
                    : Container(
                        height: 60,
                        width: 60,
                        color: Colors.black12,
                        child: const Icon(
                          Icons.medication,
                          color: Colors.white24,
                          size: 28,
                        ),
                      ),
              ),

              const SizedBox(width: 12),

              /// 🔹 CENTER → TEXT CONTENT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🟢 MEDICINE NAME
                    Text(
                      item["name"] ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    /// 💊 DOSE
                    Row(
                      children: [
                        const Icon(
                          Icons.local_hospital,
                          size: 14,
                          color: accentCyan,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "${item["dose"] ?? "--"} ${item["unit"] ?? ""}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    /// ⏰ TIME + DATE
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 13,
                          color: Colors.white38,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${item["time"]} • ${_formatDate(item["date"])}",
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          /// 🔹 VERIFIED BADGE (TOP RIGHT)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: accentCyan.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified, color: accentCyan, size: 12),
                  SizedBox(width: 4),
                  Text(
                    "VERIFIED",
                    style: TextStyle(
                      color: accentCyan,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
