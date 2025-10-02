import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: const ColorScheme.light(
      surface: AppColors.lightBackground,
      onSurface: AppColors.lightText,
      primary: AppColors.lightPrimary,
      onPrimary: Colors.white,
      secondary: AppColors.lightSecondary,
      onSecondary: Colors.black,
      error: AppColors.lightError,
      onError: Colors.white,
    ),
    cardColor: AppColors.lightCard,
    textTheme: ThemeData.light().textTheme.apply(
      bodyColor: AppColors.lightText,
      displayColor: AppColors.lightText,
    ),
    fontFamily: "SF Pro Display",
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: const ColorScheme.dark(
      surface: AppColors.darkBackground,
      onSurface: AppColors.darkText,
      primary: AppColors.darkPrimary,
      onPrimary: AppColors.darkBackground,
      secondary: AppColors.darkSecondary,
      onSecondary: Colors.white,
      error: AppColors.darkError,
      onError: Colors.white,
    ),
    cardColor: AppColors.darkCard,
    textTheme: ThemeData.dark().textTheme.apply(
      bodyColor: AppColors.darkText,
      displayColor: AppColors.darkText,
    ),
    fontFamily: "SF Pro Display",
  );
}
