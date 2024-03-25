import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/app_colors.dart';

/// [ThemeData] を提供する [Provider]
final themeProvider = Provider(
  (ref) {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: AppColors.blue,
      textTheme: kIsWeb
          ? GoogleFonts.sawarabiGothicTextTheme(
              TextTheme(
                bodyLarge: TextStyle(color: AppColors.grey, fontSize: 20.0),
                bodyMedium: TextStyle(color: AppColors.grey, fontSize: 18.0),
                bodySmall: TextStyle(color: AppColors.grey, fontSize: 16.0),
              ),
            )
          : GoogleFonts.sawarabiGothicTextTheme(
              TextTheme(
                bodyLarge: TextStyle(color: AppColors.grey),
                bodyMedium: TextStyle(color: AppColors.grey),
                bodySmall: TextStyle(color: AppColors.grey),
              ),
            ),
      sliderTheme: SliderThemeData(
        overlayShape: SliderComponentShape.noOverlay,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
      ),
    );
  },
);
