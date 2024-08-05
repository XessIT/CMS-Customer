import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFFFF3F5FD),
    textTheme: TextTheme(
      // Define your custom text styles here
      displayLarge: GoogleFonts.tajawal(
        textStyle: const TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      displayMedium: GoogleFonts.tajawal(
        textStyle: const TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
      ),
      displaySmall: GoogleFonts.tajawal(
        textStyle: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),
      bodyLarge: GoogleFonts.tajawal(
        textStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
      ),
      bodyMedium: GoogleFonts.tajawal(
        textStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          color: Colors.black54,
        ),
      ),
      titleMedium: GoogleFonts.tajawal(
        textStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
      titleSmall: GoogleFonts.tajawal(
        textStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
      bodySmall: GoogleFonts.tajawal(
        textStyle: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
      ),
      labelLarge: GoogleFonts.tajawal(
        textStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.orange.shade100,
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedLabelStyle: TextStyle(color: Colors.white),
      unselectedLabelStyle: TextStyle(color: Colors.white),
      selectedIconTheme: IconThemeData(color: Colors.red),
    ),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: CustomButtonTheme.primaryButtonStyle(),
    // ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      // Define your custom text styles here
      displayLarge: GoogleFonts.tajawal(
        textStyle: const TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      displayMedium: GoogleFonts.tajawal(
        textStyle: const TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
      ),
      displaySmall: GoogleFonts.tajawal(
        textStyle: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),
      bodyLarge: GoogleFonts.tajawal(
        textStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
      ),
      bodyMedium: GoogleFonts.tajawal(
        textStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          color: Colors.black54,
        ),
      ),
      titleMedium: GoogleFonts.tajawal(
        textStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
      titleSmall: GoogleFonts.tajawal(
        textStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
      bodySmall: GoogleFonts.tajawal(
        textStyle: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
      ),
      labelLarge: GoogleFonts.tajawal(
        textStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.orange,
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      unselectedIconTheme: IconThemeData(color: Colors.white),
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.red,
      selectedIconTheme: IconThemeData(color: Colors.red),
    ),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: CustomButtonTheme.primaryButtonStyle(),
    // ),
  );
}
