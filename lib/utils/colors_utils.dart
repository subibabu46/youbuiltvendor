import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Neutrals
  static const Color _black = Color(0xFF000000);
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _transparent = Colors.transparent;

  static const Color _neutral1000 = Color(0xff0D0D0D);
  static const Color _neutral900 = Color(0xFF131313);
  static const Color _neutral800 = Color(0xFF2C2C2C);
  static const Color _neutral700 = Color(0xFF282828);
  static const Color _neutral600 = Color(0xFF737373);
  static const Color _neutral550 = Color(0xFF787878);
  static const Color _neutral500 = Color(0xFFA3A3A3);
  static const Color _neutral450 = Color(0xFFC1C1C1);

  static const Color _neutral400 = Color(0xFFD1D5DB);
  static const Color _neutral300 = Color(0xFFD9D9D9);
  static const Color _neutral200 = Color(0xFFE0E0E0);
  static const Color _neutral100 = Color(0xFFF4F4F4);

  // Reds
  static const Color _red600 = Color(0xFFFF3B30);
  static const Color _red700 = Color(0xFFFF0000);

  // Blues
  static const Color _blue500 = Colors.blue;

  // Overlay
  static const Color _overlayDark50 = Color.fromRGBO(0, 0, 0, 0.5);

  // Text
  static const Color textPrimary = _neutral800;
  static const Color textIcon = _neutral550;
  static const Color textSecondary = _neutral600;
  static const Color textHint = _neutral500;
  static const Color textTitleSecondary = _neutral700;
  static const Color textRequired = _red700;
  static const Color textButton = _white;
  static const Color textCheckInternet = _black;
  static const Color textLabelBubbleActive = _neutral1000;
  static const Color textLabelBubbleInactive = _neutral600;
  static const Color textBubbleActive = _white;
  static const Color textBubbleInactive = _neutral600;
  static const Color textTitlePrimary = _neutral900;
  static const Color textOnboardingContent = _overlayDark50;

  // Button
  static const Color buttonDefault = _black;
  static const Color buttonClose = _neutral500;
  static const Color buttonPrimary = _neutral1000;
  static const Color buttonUpload = _neutral100;
  static const Color buttonAction = _red700;
  static const Color buttonInfo = _blue500;

  // Bubble
  static const Color bubbleDivActive = _black;
  static const Color bubbleDivInactive = _neutral400;
  static const Color bubbleActive = _neutral1000;
  static const Color bubbleInactive = _neutral100;

  // Dot
  static const Color dotInactive = _neutral300;
  static const Color dotActive = _black;

  // Borders
  static const Color borderDefault = _neutral400;
  static const Color borderNormal = _neutral450;
  static const Color borderOtp = _neutral500;
  static const Color borderDotted = _neutral450;
  static const Color borderTextField = _neutral600;
  static const Color borderRegisterType = _red600;
  static const Color borderRequired = _red700;

  // Divider
  static const Color divider = _neutral200;

  // Background
  static const Color bottomNavBarBg = _neutral1000;
  static const Color transparent = _transparent;
  static const Color backgroundPlaceholder = _neutral100;

  // Other

  static const Color loading = _white;
}
