import 'package:design_task_1/pages/onboarding/widgets/description.dart';
import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

const items = [
  [
    'assets/splash1 1.png',
    'Purchase',
    'Shop building materials \n& machinery with ease.',
  ],
  [
    'assets/splash3 1.png',
    'Services',
    'Book trusted construction \nservices anytime, anywhere.',
  ],
  [
    'assets/splash2 1.png',
    'Projects',
    'Manage your project, budget \n& tasks in one place.',
  ],
];

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: pageController,
          itemCount: items.length,
          itemBuilder: (context, i) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(items[i][0], fit: BoxFit.contain),
              ),
              SizedBox(height: 50),
              Description(title: items[i][1], content: items[i][2]),
              SizedBox(height: 50),
            ],
          ),
        ),
        Positioned(
          bottom: 100,
          right: MediaQuery.of(context).size.width / 2 - 20,

          child: SmoothPageIndicator(
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
        ),
        Positioned(
          bottom: 10,
          right: 8,
          left: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: NextButton(
              buttonText: 'Next',
              onPressed: () {
                pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
