import 'package:flutter/material.dart';

class StoreFinanceScreen extends StatefulWidget {
  const StoreFinanceScreen({super.key});

  @override
  State<StoreFinanceScreen> createState() => _StoreFinanceScreenState();
}

class _StoreFinanceScreenState extends State<StoreFinanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Finance', style: TextStyle(color: Colors.black)),
    );
  }
}
