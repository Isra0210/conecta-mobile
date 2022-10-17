import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> getSnackBar(
  BuildContext context, {
  required String title,
  required String message,
  Color? backgroundColor,
}) async {
  Get.snackbar(
    title,
    message,
    duration: const Duration(seconds: 2),
    backgroundColor: backgroundColor ?? Colors.deepOrangeAccent.shade400,
    margin:const EdgeInsets.all(10),
    backgroundGradient: backgroundColor != null
        ? null
        : const LinearGradient(
            colors: [
              Color(0XFFf44336),
              Color(0XFFec8d2f),
            ],
          ),
  );
}
