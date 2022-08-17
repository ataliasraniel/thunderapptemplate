///This file should contain all the constants style used in the app
///like texts, fonts, colors, etc.
///you should use the standard naming convention for constants like the following:

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/**FONT CONFIGURATION*/
final kDefaultFontFamily = GoogleFonts.poppins().fontFamily;
/**COLORS */
const Color kPrimaryColor = Color.fromARGB(255, 46, 171, 175);
const Color kBackgroundColor = Color(0xFFF5F5F5);
const Color kSecondaryColor = Color(0xFF00A8C5);
const Color kDetailColor = Color.fromARGB(255, 195, 78, 224);
const Color kOnBackgroundColor = Color.fromARGB(255, 4, 4, 44);
const Color kOnSurfaceColor = Colors.white;
const Color kErrorColor = Colors.red;

/**TEXT STYLES */
const TextStyle kTitle1 = TextStyle(
    fontSize: 32, fontWeight: FontWeight.w900, color: kOnBackgroundColor);
const TextStyle kCaption1 = TextStyle(fontSize: 16, color: kErrorColor);
