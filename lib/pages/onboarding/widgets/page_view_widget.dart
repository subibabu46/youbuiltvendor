import 'package:design_task_1/pages/onboarding/widgets/content.dart';
import 'package:flutter/material.dart';

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

class PageViewWidget extends StatefulWidget {
  final PageController pageController;
  const PageViewWidget({super.key, required this.pageController});

  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.pageController,
      itemCount: items.length,
      itemBuilder: (context, i) => Column(
        mainAxisAlignment: MainAxisAlignment.center,

        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Image.asset(items[i][0], fit: BoxFit.contain),
            ),
          ),

          Content(title: items[i][1], content: items[i][2]),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
