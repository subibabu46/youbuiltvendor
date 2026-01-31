import 'package:flutter/material.dart';

void messageTost(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(color: Color(0xffffffff))),
      duration: Duration(seconds: 2),
      backgroundColor: Color(0xff737373),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    ),
  );
}
