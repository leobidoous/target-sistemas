import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_theme_factory.dart';
import 'typography/typography_constants.dart';

class AppTheme {
  static Color get grey1 => Colors.grey.shade50;
  static Color get grey2 => Colors.grey.shade300;
  static Color get primary => const Color(0xFF183D4F);
  static Color get secondary => const Color(0xFF1B685E);

  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          fontSize: AppFontSize.bodyLarge.value,
          fontWeight: AppFontWeight.regular.value,
          color: colorScheme.onBackground,
        ),
        bodyMedium: TextStyle(
          fontSize: AppFontSize.bodyMedium.value,
          fontWeight: AppFontWeight.regular.value,
          color: colorScheme.onBackground,
        ),
        bodySmall: TextStyle(
          fontSize: AppFontSize.bodySmall.value,
          fontWeight: AppFontWeight.regular.value,
          color: colorScheme.onBackground,
        ),
        titleLarge: TextStyle(
          fontSize: AppFontSize.titleLarge.value,
          fontWeight: AppFontWeight.bold.value,
          color: colorScheme.onBackground,
        ),
        titleMedium: TextStyle(
          fontSize: AppFontSize.titleMedium.value,
          fontWeight: AppFontWeight.bold.value,
          color: colorScheme.onBackground,
        ),
        titleSmall: TextStyle(
          fontSize: AppFontSize.titleSmall.value,
          fontWeight: AppFontWeight.bold.value,
          color: colorScheme.onBackground,
        ),
        displayLarge: TextStyle(
          fontSize: AppFontSize.displayLarge.value,
          fontWeight: AppFontWeight.regular.value,
          color: colorScheme.onBackground,
        ),
        displayMedium: TextStyle(
          fontSize: AppFontSize.displayMedium.value,
          fontWeight: AppFontWeight.regular.value,
          color: colorScheme.onBackground,
        ),
        displaySmall: TextStyle(
          fontSize: AppFontSize.displaySmall.value,
          fontWeight: AppFontWeight.regular.value,
          color: colorScheme.onBackground,
        ),
        headlineLarge: TextStyle(
          fontSize: AppFontSize.headlineLarge.value,
          fontWeight: AppFontWeight.bold.value,
          color: colorScheme.onBackground,
        ),
        headlineMedium: TextStyle(
          fontSize: AppFontSize.headlineMedium.value,
          fontWeight: AppFontWeight.regular.value,
          color: colorScheme.onBackground,
        ),
        headlineSmall: TextStyle(
          fontSize: AppFontSize.headlineSmall.value,
          fontWeight: AppFontWeight.regular.value,
          color: colorScheme.onBackground,
        ),
        labelLarge: TextStyle(
          fontSize: AppFontSize.labelLarge.value,
          fontWeight: AppFontWeight.light.value,
          color: colorScheme.onBackground,
        ),
        labelMedium: TextStyle(
          fontSize: AppFontSize.labelMedium.value,
          fontWeight: AppFontWeight.light.value,
          color: colorScheme.onBackground,
        ),
        labelSmall: TextStyle(
          fontSize: AppFontSize.labelSmall.value,
          fontWeight: AppFontWeight.light.value,
          color: colorScheme.onBackground,
        ),
      );

  static ThemeData createLightTheme() {
    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: const Color(0xFFF4EDFF),
      primaryContainer: const Color(0xFF8A76FC),
      onPrimaryContainer: const Color(0xFF36297D),
      secondary: const Color(0xffFA7200),
      onSecondary: const Color(0xFFFFF8E1),
      secondaryContainer: Colors.white,
      onSecondaryContainer: const Color(0xFFFFCE1C),
      tertiary: const Color(0xff00BF53),
      onTertiary: Colors.white,
      tertiaryContainer: const Color(0xFFE1F3FF),
      onTertiaryContainer: const Color(0xFF00BDFF),
      error: const Color(0xFFC73B51),
      onError: Colors.white,
      errorContainer: const Color(0xFFFFE1E2),
      onErrorContainer: const Color(0xFFFC4E69),
      background: Colors.white,
      onBackground: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
      surfaceVariant: const Color(0xFFF5F5F5),
      onSurfaceVariant: const Color(0xFF979797),
      outline: const Color(0xFF78767F),
      onInverseSurface: const Color(0xFFD6F6FF),
      inverseSurface: const Color(0xFF00363F),
      inversePrimary: const Color(0xFFC8BFFF),
      shadow: const Color(0xFFF1F1F1),
      surfaceTint: const Color(0xFF666666),
      outlineVariant: const Color(0xFFC9C9C9),
      scrim: Colors.black,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor: Colors.white,
      primaryColorLight: Colors.black,
      primaryColorDark: Colors.white,
      cardColor: Colors.white,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        color: colorScheme.primary,
        elevation: 0,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
        size: AppFontSize.iconButton.value,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: const MaterialStatePropertyAll(Colors.black),
          iconSize: MaterialStatePropertyAll(AppFontSize.iconButton.value),
        ),
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      shadowColor: Colors.transparent,
      colorScheme: colorScheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: textTheme(colorScheme),
    );
  }

  static ThemeData createDarkTheme() {
    final colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: primary,
      onPrimary: const Color(0xFF36297D),
      onPrimaryContainer: primary,
      primaryContainer: const Color(0xFF8A76FC),
      secondary: const Color(0xFFFFF8E1),
      onSecondary: const Color(0xffFA7200),
      onSecondaryContainer: const Color(0xFFFFF8E1),
      secondaryContainer: const Color(0xFFFFCE1C),
      tertiary: Colors.white,
      onTertiary: const Color(0xff00BF53),
      tertiaryContainer: const Color(0xFF00BDFF),
      onTertiaryContainer: const Color(0xFFE1F3FF),
      error: Colors.white,
      onError: const Color(0xFFC73B51),
      errorContainer: const Color(0xFFFC4E69),
      onErrorContainer: const Color(0xFFFFE1E2),
      background: Colors.black,
      onBackground: Colors.white,
      surface: Colors.black,
      onSurface: Colors.white,
      onSurfaceVariant: const Color(0xFFF5F5F5),
      surfaceVariant: const Color(0xFF979797),
      outline: const Color(0xFFD6F6FF),
      onInverseSurface: const Color(0xFF78767F),
      inverseSurface: const Color(0xFFC8BFFF),
      inversePrimary: const Color(0xFF00363F),
      shadow: const Color(0xFFF1F1F1),
      surfaceTint: const Color(0xFFC9C9C9),
      outlineVariant: const Color(0xFF666666),
      scrim: Colors.white,
    );
    final themeData = createLightTheme();

    return themeData.copyWith(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor: Colors.black,
      primaryColorLight: Colors.white,
      primaryColorDark: Colors.black,
      cardColor: const Color(0xff202020),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        color: colorScheme.primary,
        elevation: 0,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
        size: AppFontSize.iconButton.value,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: const MaterialStatePropertyAll(Colors.black),
          iconSize: MaterialStatePropertyAll(AppFontSize.iconButton.value),
        ),
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      shadowColor: Colors.transparent,
      colorScheme: colorScheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: textTheme(colorScheme),
    );
  }

  static void initAppThemes() {
    AppThemeFactory.instance.currentLightTheme = createLightTheme();
    AppThemeFactory.instance.currentDarkTheme = createDarkTheme();
  }
}
