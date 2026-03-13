import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// Gerencia os diferentes temas visuais do aplicativo baseados no tipo de loja.
/// Temas disponíveis: Pizzaria (Padrão Stitch), Doces (Rosa) e Açaí (Roxo).
class AppTheme {
  // Cores da Pizzaria (baseado no AppColors)
  static const Color pizzeriaPrimary = AppColors.primaryColor;
  static const Color pizzeriaBgLight = AppColors.backgroundLight;
  static const Color pizzeriaBgDark = Color(0xFF211112);

  // Cores da loja de Doces
  static const Color sweetsPrimary = Color(0xFFE91E63);
  static const Color sweetsBgLight = Color(0xFFFFF7FA);
  static const Color sweetsBgDark = Color(0xFF3B0B1D);

  // Cores da loja de Açaí
  static const Color acaiPrimary = Color(0xFF5E215C);
  static const Color acaiBgLight = Color(0xFFF9F7FA);
  static const Color acaiBgDark = Color(0xFF1B0B1A);

  /// Retorna o ThemeData da Pizzaria
  static ThemeData getPizzeriaTheme({bool isDark = false}) {
    return _buildTheme(
      pizzeriaPrimary,
      isDark ? pizzeriaBgDark : pizzeriaBgLight,
      isDark,
    );
  }

  /// Retorna o ThemeData da loja de Doces
  static ThemeData getSweetsTheme({bool isDark = false}) {
    return _buildTheme(
      sweetsPrimary,
      isDark ? sweetsBgDark : sweetsBgLight,
      isDark,
    );
  }

  /// Retorna o ThemeData da lanchonete de Açaí
  static ThemeData getAcaiTheme({bool isDark = false}) {
    return _buildTheme(acaiPrimary, isDark ? acaiBgDark : acaiBgLight, isDark);
  }

  /// Método utilitário para construir o [ThemeData] com as cores e fonte Inter
  static ThemeData _buildTheme(Color primary, Color background, bool isDark) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary:
            primary, // Force the exact primary color hex (Material 3 alters it otherwise)
        brightness: isDark ? Brightness.dark : Brightness.light,
        surface: background,
      ),
      primaryColor: primary, // Explicitly set it on the theme object
      scaffoldBackgroundColor: background,
      textTheme: GoogleFonts.interTextTheme(
        isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme,
      ),
    );
  }
}
