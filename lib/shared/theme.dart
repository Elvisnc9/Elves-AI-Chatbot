import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.primary,
        textTheme: TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 24.sp,
      height: 1.4,
      fontWeight: FontWeight.bold,
    ),
     displayMedium: GoogleFonts.poppins(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      height: 1.4,
     color: AppColors.light
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 17.sp,
      fontWeight: FontWeight.bold,
     color: Colors.white
    ),

    labelMedium: GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
     color: AppColors.light.withOpacity(0.8)
    
    ),
      labelLarge: GoogleFonts.poppins(
      fontSize: 17.sp,
      fontWeight: FontWeight.w500,
     color: AppColors.light.withOpacity(0.95)
    
    ),

  )
    );
  }
}



class AppColors {
  static const Color primary = Color(0xFF6C3082);
  static const Color light = Color(0xFFFEFEFA);
  static const Color dark = Color(0xFF100C08);
  static const Color accent = Color(0xFF301934);
}