import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:design_task_1/providers/connectivity_provider.dart';
import 'package:design_task_1/utils/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckInternetScreen extends ConsumerStatefulWidget {
  const CheckInternetScreen({super.key});
  @override
  ConsumerState<CheckInternetScreen> createState() => _CheckInternetScreen();
}

class _CheckInternetScreen extends ConsumerState<CheckInternetScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off_outlined, size: 50),
              SizedBox(height: 8),
              Text(
                'Check internet connection',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: NextButton(
                  buttonText: 'Retry',
                  loading: isLoading,
                  onPressed: () async {
                    if (isLoading) return;
                    setState(() {
                      isLoading = true;
                    });
                    final isConnected = await ref
                        .read(connectivityServiceProvider)
                        .isConnected();
                    await Future.delayed(Duration(seconds: 2));
                    if (!context.mounted) return;
                    setState(() {
                      isLoading = false;
                    });

                    if (isConnected) {
                      messageTost('Internet connection restored', context);
                      Navigator.pop(context);
                    } else {
                      messageTost('No internet connection', context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
