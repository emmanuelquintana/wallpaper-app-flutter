import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.negroProfundo,
      primaryColor: AppColors.azulNoche2,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.azulNoche1,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.blanco),
        titleTextStyle: TextStyle(color: AppColors.blanco, fontSize: 20),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.blanco),
        bodyMedium: TextStyle(color: AppColors.blanco),
        titleMedium: TextStyle(color: AppColors.blanco),
      ),
      fontFamily: 'Roboto',
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.azulNoche3,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }
}
