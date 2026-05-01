import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';

class AppToasts {
  static void showError(BuildContext context, String message) {
    CherryToast.error(
      title: const Text("Error", style: TextStyle(fontWeight: FontWeight.bold)),
      displayIcon: true,
      description: Text(message, style: const TextStyle(fontSize: 12)),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 1000),
      autoDismiss: true,
      // Matching your surfaceColor
      backgroundColor: const Color(0xFF1E1E1E),
      toastPosition: Position.top,
    ).show(context);
  }

  static void showSuccess(BuildContext context, String message) {
    CherryToast.success(
      title: const Text(
        "Success",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      displayIcon: false,
      description: Text(message, style: const TextStyle(color: Colors.white70)),
      animationType: AnimationType.fromTop,
      backgroundColor: const Color(0xFF1E1E1E),
      displayCloseButton: true,
      animationDuration: const Duration(milliseconds: 1000),
      toastPosition: Position.top,
    ).show(context);
  }
}
