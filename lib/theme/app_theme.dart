import 'package:flutter/cupertino.dart';

class AppTheme {
  static const primaryBlue = CupertinoColors.systemBlue;
  
  static CupertinoThemeData get lightTheme {
    return const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
      barBackgroundColor: Color(0xCCF9F9F9), // Semi-transparent for blur effect
      textTheme: CupertinoTextThemeData(
        navLargeTitleTextStyle: TextStyle(
          inherit: false,
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: CupertinoColors.label,
          letterSpacing: -0.4,
        ),
      ),
    );
  }

  static CupertinoThemeData get darkTheme {
    return const CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: CupertinoColors.black,
      barBackgroundColor: Color(0xCC1C1C1E), // Semi-transparent for blur effect
      textTheme: CupertinoTextThemeData(
        navLargeTitleTextStyle: TextStyle(
          inherit: false,
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: CupertinoColors.white,
          letterSpacing: -0.4,
        ),
      ),
    );
  }
}
