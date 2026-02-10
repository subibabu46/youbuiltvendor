import 'package:design_task_1/pages/get_started/get_started_screen.dart';
import 'package:design_task_1/pages/onboarding/widgets/page_view_widget.dart';
import 'package:design_task_1/utils/next_button.dart';
import 'package:design_task_1/pages/onboarding/widgets/skip_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SkipButton(
                    onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GetStartedScreen(),
                      ),
                      (route) => false,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(child: PageViewWidget(pageController: pageController)),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 64, left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SmoothPageIndicator(
              controller: pageController,
              count: items.length,
              effect: WormEffect(
                dotHeight: 8,
                dotWidth: 8,
                spacing: 8,
                activeDotColor: Color(0xFF000000),
                dotColor: Color(0xFFD9D9D9),
              ),
            ),
            SizedBox(height: 24),
            NextButton(
              buttonText: 'Next',
              onPressed: () {
                pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
                if (pageController.page == 2) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => GetStartedScreen()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
