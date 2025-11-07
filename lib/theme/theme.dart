import 'package:flutter/material.dart';

const _seedPortal = Color(0xFF18DB5A);
const _seedSpace  = Color(0xFF0B0F14);

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color alive, dead, unknown;
  const AppColors({required this.alive, required this.dead, required this.unknown});

  static const light = AppColors(
    alive: Color(0xFF1B5E20),
    dead:  Color(0xFFC62828),
    unknown: Color(0xFF6D6D6D),
  );
  static const dark = AppColors(
    alive: Color(0xFF81C784),
    dead:  Color(0xFFE57373),
    unknown: Color(0xFFBDBDBD),
  );

  @override
  AppColors copyWith({Color? alive, Color? dead, Color? unknown}) =>
      AppColors(alive: alive ?? this.alive, dead: dead ?? this.dead, unknown: unknown ?? this.unknown);

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      alive:   Color.lerp(alive,   other.alive,   t)!,
      dead:    Color.lerp(dead,    other.dead,    t)!,
      unknown: Color.lerp(unknown, other.unknown, t)!,
    );
  }
}

TextTheme _txt(TextTheme base) => base.copyWith(
  titleMedium: base.titleMedium?.copyWith(fontWeight: FontWeight.w600),
);

ThemeData buildLightTheme() {
  final cs = ColorScheme.fromSeed(
    seedColor: _seedPortal,
    brightness: Brightness.light,
    surfaceTint: _seedPortal,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: cs,
    scaffoldBackgroundColor: cs.background,
    textTheme: _txt(const TextTheme()).apply(
      bodyColor: cs.onSurface,
      displayColor: cs.onSurface,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: cs.surface,
      foregroundColor: cs.onSurface,
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: cs.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    chipTheme: ChipThemeData(
      side: BorderSide(color: cs.outlineVariant),
      selectedColor: cs.primaryContainer,
      labelStyle: TextStyle(color: cs.onSurface),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    extensions: const [AppColors.light],
  );
}

ThemeData buildDarkTheme() {
  final cs = ColorScheme.fromSeed(
    seedColor: _seedPortal,
    brightness: Brightness.dark,
    surface: _seedSpace,
    background: _seedSpace,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: cs,
    scaffoldBackgroundColor: _seedSpace,
    textTheme: _txt(const TextTheme()).apply(
      bodyColor: cs.onSurface,
      displayColor: cs.onSurface,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _seedSpace,
      foregroundColor: cs.onSurface,
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: cs.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    chipTheme: ChipThemeData(
      side: BorderSide(color: cs.outlineVariant),
      selectedColor: cs.primaryContainer.withOpacity(0.25),
      labelStyle: TextStyle(color: cs.onSurface),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    extensions: const [AppColors.dark],
  );
}
