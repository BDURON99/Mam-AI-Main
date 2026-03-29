import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff890f2c),
      surfaceTint: Color(0xffad2e44),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffaa2b42),
      onPrimaryContainer: Color(0xffffc7ca),
      secondary: Color(0xff8e4a51),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffaab1),
      onSecondaryContainer: Color(0xff7b3b42),
      tertiary: Color(0xff2b6748),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff45805f),
      onTertiaryContainer: Color(0xfff6fff6),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff251819),
      onSurfaceVariant: Color(0xff584142),
      outline: Color(0xff8b7072),
      outlineVariant: Color(0xffdfbfc0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3b2d2e),
      inversePrimary: Color(0xffffb2b8),
      primaryFixed: Color(0xffffdadb),
      onPrimaryFixed: Color(0xff40000e),
      primaryFixedDim: Color(0xffffb2b8),
      onPrimaryFixedVariant: Color(0xff8c122e),
      secondaryFixed: Color(0xffffdadb),
      onSecondaryFixed: Color(0xff3a0811),
      secondaryFixedDim: Color(0xffffb2b8),
      onSecondaryFixedVariant: Color(0xff71333a),
      tertiaryFixed: Color(0xffb1f1c9),
      onTertiaryFixed: Color(0xff002111),
      tertiaryFixedDim: Color(0xff96d4ae),
      onTertiaryFixedVariant: Color(0xff115134),
      surfaceDim: Color(0xffecd5d5),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0f0),
      surfaceContainer: Color(0xffffe9e9),
      surfaceContainerHigh: Color(0xfffae3e3),
      surfaceContainerHighest: Color(0xfff5ddde),
    );
  }

  ThemeData light() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff720020),
      surfaceTint: Color(0xffad2e44),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffaa2b42),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff5d232a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff9f595f),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003f25),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff3d7958),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff190e0f),
      onSurfaceVariant: Color(0xff463132),
      outline: Color(0xff644c4e),
      outlineVariant: Color(0xff816768),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3b2d2e),
      inversePrimary: Color(0xffffb2b8),
      primaryFixed: Color(0xffc13d52),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xffa0233b),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff9f595f),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff824148),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff3d7958),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff235f41),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd8c1c2),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0f0),
      surfaceContainer: Color(0xfffae3e3),
      surfaceContainerHigh: Color(0xffefd7d8),
      surfaceContainerHighest: Color(0xffe3cccd),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff5f001a),
      surfaceTint: Color(0xffad2e44),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff901531),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff501921),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff74363d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00341e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff145336),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff3b2728),
      outlineVariant: Color(0xff5a4345),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3b2d2e),
      inversePrimary: Color(0xffffb2b8),
      primaryFixed: Color(0xff901531),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff6c001e),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff74363d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff582027),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff145336),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003b23),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc9b4b4),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffffeced),
      surfaceContainer: Color(0xfff5ddde),
      surfaceContainerHigh: Color(0xffe6cfd0),
      surfaceContainerHighest: Color(0xffd8c1c2),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb2b8),
      surfaceTint: Color(0xffffb2b8),
      onPrimary: Color(0xff67001d),
      primaryContainer: Color(0xffaa2b42),
      onPrimaryContainer: Color(0xffffc7ca),
      secondary: Color(0xffffb2b8),
      onSecondary: Color(0xff551e25),
      secondaryContainer: Color(0xff71333a),
      onSecondaryContainer: Color(0xfff29ea5),
      tertiary: Color(0xff96d4ae),
      onTertiary: Color(0xff003921),
      tertiaryContainer: Color(0xff619d7a),
      onTertiaryContainer: Color(0xff00311c),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff1c1011),
      onSurface: Color(0xfff5ddde),
      onSurfaceVariant: Color(0xffdfbfc0),
      outline: Color(0xffa68a8b),
      outlineVariant: Color(0xff584142),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff5ddde),
      inversePrimary: Color(0xffad2e44),
      primaryFixed: Color(0xffffdadb),
      onPrimaryFixed: Color(0xff40000e),
      primaryFixedDim: Color(0xffffb2b8),
      onPrimaryFixedVariant: Color(0xff8c122e),
      secondaryFixed: Color(0xffffdadb),
      onSecondaryFixed: Color(0xff3a0811),
      secondaryFixedDim: Color(0xffffb2b8),
      onSecondaryFixedVariant: Color(0xff71333a),
      tertiaryFixed: Color(0xffb1f1c9),
      onTertiaryFixed: Color(0xff002111),
      tertiaryFixedDim: Color(0xff96d4ae),
      onTertiaryFixedVariant: Color(0xff115134),
      surfaceDim: Color(0xff1c1011),
      surfaceBright: Color(0xff443536),
      surfaceContainerLowest: Color(0xff160b0c),
      surfaceContainerLow: Color(0xff251819),
      surfaceContainer: Color(0xff291c1d),
      surfaceContainerHigh: Color(0xff342727),
      surfaceContainerHighest: Color(0xff403132),
    );
  }

  ThemeData dark() {
    return theme(lightScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffd1d3),
      surfaceTint: Color(0xffffb2b8),
      onPrimary: Color(0xff530015),
      primaryContainer: Color(0xfff06073),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffd1d3),
      onSecondary: Color(0xff47131b),
      secondaryContainer: Color(0xffc87b82),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffabeac3),
      onTertiary: Color(0xff002c19),
      tertiaryContainer: Color(0xff619d7a),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1c1011),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff6d4d6),
      outline: Color(0xffc9aaac),
      outlineVariant: Color(0xffa6898b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff5ddde),
      inversePrimary: Color(0xff8e1430),
      primaryFixed: Color(0xffffdadb),
      onPrimaryFixed: Color(0xff2d0007),
      primaryFixedDim: Color(0xffffb2b8),
      onPrimaryFixedVariant: Color(0xff720020),
      secondaryFixed: Color(0xffffdadb),
      onSecondaryFixed: Color(0xff2c0108),
      secondaryFixedDim: Color(0xffffb2b8),
      onSecondaryFixedVariant: Color(0xff5d232a),
      tertiaryFixed: Color(0xffb1f1c9),
      onTertiaryFixed: Color(0xff001509),
      tertiaryFixedDim: Color(0xff96d4ae),
      onTertiaryFixedVariant: Color(0xff003f25),
      surfaceDim: Color(0xff1c1011),
      surfaceBright: Color(0xff504141),
      surfaceContainerLowest: Color(0xff0e0506),
      surfaceContainerLow: Color(0xff271a1b),
      surfaceContainer: Color(0xff322425),
      surfaceContainerHigh: Color(0xff3d2f30),
      surfaceContainerHighest: Color(0xff493a3b),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffebec),
      surfaceTint: Color(0xffffb2b8),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffadb3),
      onPrimaryContainer: Color(0xff210004),
      secondary: Color(0xffffebec),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffffadb3),
      onSecondaryContainer: Color(0xff210004),
      tertiary: Color(0xffbffed6),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff92d0aa),
      onTertiaryContainer: Color(0xff000e06),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff1c1011),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffffebec),
      outlineVariant: Color(0xffdbbbbc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff5ddde),
      inversePrimary: Color(0xff8e1430),
      primaryFixed: Color(0xffffdadb),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffb2b8),
      onPrimaryFixedVariant: Color(0xff2d0007),
      secondaryFixed: Color(0xffffdadb),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffffb2b8),
      onSecondaryFixedVariant: Color(0xff2c0108),
      tertiaryFixed: Color(0xffb1f1c9),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff96d4ae),
      onTertiaryFixedVariant: Color(0xff001509),
      surfaceDim: Color(0xff1c1011),
      surfaceBright: Color(0xff5c4c4d),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff291c1d),
      surfaceContainer: Color(0xff3b2d2e),
      surfaceContainerHigh: Color(0xff473838),
      surfaceContainerHighest: Color(0xff534344),
    );
  }

  ThemeData darkHighContrast() {
    return theme(lightHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
