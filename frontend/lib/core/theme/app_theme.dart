// app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Định nghĩa màu sắc mới
  static const Color primaryColor = Color(0xFF00B0FF); // Xanh da trời
  static const Color surfaceColor = Color(0xFFF5F5F5); // Xám rất nhạt
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Color(0xFF333333);
  static const Color textLightColor = Color(0xFF757575);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    
    // Áp dụng bảng màu mới
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      surface: surfaceColor,
      background: backgroundColor,
      onPrimary: Colors.white,
      onBackground: textColor,
      onSurface: textColor,
    ),

    // Sử dụng font Poppins cho toàn bộ ứng dụng
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: textColor,
      displayColor: textColor,
    ),

    // Nâng cấp style cho AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundColor,
      foregroundColor: textColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20, 
        fontWeight: FontWeight.w600, 
        color: textColor
      ),
    ),

    // Nâng cấp style cho ElevatedButton
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold
        ),
      ),
    ),

    // Nâng cấp style cho trường nhập liệu
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      hintStyle: const TextStyle(color: textLightColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: primaryColor, width: 2.0),
      ),
    ),
    
    // ĐÃ SỬA ĐÚNG: CardThemeData
    cardTheme: CardThemeData(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
    ),
  );
}