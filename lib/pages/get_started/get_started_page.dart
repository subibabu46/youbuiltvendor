import 'package:flutter/material.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('How would you like to get started?'),
          Text('Choose your business type'),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    Text('Store Registration'),
                    Text('Register your store and list products'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
