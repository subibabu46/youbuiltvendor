import 'package:design_task_1/pages/error/check_internet_screen.dart';
import 'package:design_task_1/providers/connectivity_provider.dart';
import 'package:design_task_1/utils/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<bool> checkConnection(BuildContext context, WidgetRef ref) async {
  final isConnected = await ref.read(connectivityServiceProvider).isConnected();
  if (!isConnected) {
    if (context.mounted) {
      messageTost("No internet connection", context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CheckInternetScreen()),
      );
    }
    return false;
  }
  return true;
}
