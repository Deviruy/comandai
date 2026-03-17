import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'controllers/store_controller.dart';
import 'controllers/cart_controller.dart';
import 'controllers/user_controller.dart';
import 'models/store_model.dart';
import 'package:flutter_web_plugins/url_strategy.dart'; // Necessário para ocultar o '#' no Flutter Web

void main() {
  // Esconde o '#' da URL no Flutter Web
  usePathUrlStrategy();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StoreController()),
        ChangeNotifierProvider(create: (_) => CartController()),
        ChangeNotifierProvider(create: (_) => UserController()),
      ],
      child: const ComandaiApp(),
    ),
  );
}

/// Widget principal do aplicativo
class ComandaiApp extends StatelessWidget {
  const ComandaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Escutamos o StoreController para alterar o tema globalmente
    // Toda vez que a loja mudar, a árvore é recarregada com o tema correto.
    final storeController = context.watch<StoreController>();

    ThemeData appTheme = AppTheme.getPizzeriaTheme(); // Tema base fallback

    if (storeController.currentStore != null) {
      switch (storeController.currentStore!.themeType) {
        case StoreThemeType.pizzeria:
          appTheme = AppTheme.getPizzeriaTheme();
          break;
        case StoreThemeType.sweets:
          appTheme = AppTheme.getSweetsTheme();
          break;
        case StoreThemeType.acai:
          appTheme = AppTheme.getAcaiTheme();
          break;
      }
    }

    return MaterialApp.router(
      title: 'Lakes Delivery',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      routerConfig: appRouter,
    );
  }
}
