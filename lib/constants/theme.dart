import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// The app's main accent colour
const Color accent = Color(0xFFDB8C39);

// The accent for light themes
const Color lightAccent = Color(0xFFdf984d);

// The primary background color for dark mode;
// Inversely this is the foreground color for light mode
const Color bgDark = Color(0xFF111015);

// The primary background color for light mode;
// Inversely this is the foreground color for dark mode
const Color fgDark = Color(0xFFE7E7E8);

// Surface's are used for Cards and ListTile elements
const Color darkSurface = Color(0xFF29282c);
const Color lightSurface = Color(0xFFf5f5f6);

final ThemeData theme = ThemeData();
final lightTheme = ThemeData(
  scaffoldBackgroundColor: fgDark,
  appBarTheme: AppBarTheme(
    color: fgDark,
    elevation: 0,
  ),
  disabledColor: Color(0xFFd0d0d1),
  bottomAppBarTheme: BottomAppBarTheme(
    color: fgDark,
    elevation: 0.0,
  ),
  canvasColor: lightSurface,
  colorScheme: theme.colorScheme.copyWith(secondary: lightAccent),
  splashColor: Colors.transparent,
  iconTheme: IconThemeData(color: bgDark),
  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
  textTheme: TextTheme(
    labelLarge: TextStyle(color: bgDark),
    titleLarge: GoogleFonts.varelaRound(
      color: bgDark.withOpacity(0.75),
    ),
    // Used for the TimerCountdown text
    bodyLarge: GoogleFonts.varelaRound(
      fontSize: 32.0,
      color: bgDark,
    ),
    headlineSmall: GoogleFonts.montserrat(
      color: lightAccent,
      fontWeight: FontWeight.w500,
    ),
    displayLarge: GoogleFonts.varelaRound(
      color: bgDark,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    ),
    displayMedium: GoogleFonts.varelaRound(
      color: bgDark.withOpacity(0.8),
    ),
    headlineMedium: GoogleFonts.varelaRound(
      color: bgDark,
    ),
    displaySmall: GoogleFonts.montserrat(
      color: bgDark,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.varelaRound(
      color: bgDark,
      fontSize: 13.0,
    ),
    labelMedium: GoogleFonts.varelaRound(
      color: bgDark,
      fontSize: 13.0,
    ),
    titleMedium: GoogleFonts.varelaRound(
      color: bgDark,
      fontSize: 15.0,
    ),
  ),
);

final darkTheme = ThemeData(
  scaffoldBackgroundColor: bgDark,
  appBarTheme: AppBarTheme(
    color: bgDark,
    elevation: 0,
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: bgDark,
    elevation: 0.0,
  ),
  canvasColor: darkSurface,
  colorScheme: theme.colorScheme.copyWith(secondary: lightAccent),
  splashColor: Colors.transparent,
  disabledColor: Color(0xFF29282c),
  iconTheme: IconThemeData(color: fgDark),
  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
  textTheme: TextTheme(
    labelLarge: TextStyle(color: fgDark),
    titleLarge: GoogleFonts.varelaRound(
      color: fgDark.withOpacity(0.75),
    ),
    bodyLarge: GoogleFonts.varelaRound(
      fontSize: 32.0,
      color: bgDark,
    ),
    /* bodyLarge: GoogleFonts.montserrat(
      color: accent,
      fontWeight: FontWeight.w500,
    ),*/
    headlineSmall: GoogleFonts.montserrat(
      color: fgDark,
      fontWeight: FontWeight.w500,
    ),
    displayLarge: GoogleFonts.varelaRound(
      color: fgDark,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    ),
    displayMedium: GoogleFonts.varelaRound(
      color: fgDark.withOpacity(0.8),
    ),
    headlineMedium: GoogleFonts.varelaRound(
      color: fgDark,
    ),
    displaySmall: GoogleFonts.montserrat(
      color: accent,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.varelaRound(
      color: fgDark,
      fontSize: 13.0,
    ),
    labelMedium: GoogleFonts.varelaRound(
      color: fgDark,
      fontSize: 13.0,
    ),
    titleMedium: GoogleFonts.varelaRound(
      color: fgDark,
      fontSize: 15.0,
    ),
  ),
);
