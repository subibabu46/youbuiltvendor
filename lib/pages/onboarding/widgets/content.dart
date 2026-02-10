import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  const Content({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          textAlign: TextAlign.center,
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 33,
            color: Color(0xFF131313),
          ),
        ),
        SizedBox(height: 10),
        Text(
          textAlign: TextAlign.center,
          content,
          style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5), fontSize: 16),
        ),
      ],
    );
  }
}
