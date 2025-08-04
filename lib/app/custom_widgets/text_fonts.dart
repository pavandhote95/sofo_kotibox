import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  /// Montserrat font with customizable size, color, and weight.
  static TextStyle montserrat({
    double fs = 13,                         // font size (default 13)
    Color c = Colors.black,                // color (default black)
    FontWeight fw = FontWeight.w500,       // font weight (default medium)
    TextDecoration? decoration,            // optional text decoration
  }) {
    return GoogleFonts.montserrat(
      fontSize: fs,
      color: c,
      fontWeight: fw,
      decoration: decoration,
    );
  }

  /// Manrope font with customizable size, color, and weight.
  static TextStyle manRope({
    double fs = 13,
    Color c = Colors.black,
    FontWeight fw = FontWeight.w500,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.manrope(
      fontSize: fs,
      color: c,
      fontWeight: fw,
      decoration: decoration,
    );
  }
}
