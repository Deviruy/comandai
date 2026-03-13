import 'package:go_router/go_router.dart';
import '../../screens/menu_screen.dart';
import '../../screens/store_not_found_screen.dart';
import '../../screens/cart_screen.dart';
import '../../screens/checkout_screen.dart';

/// Configuração do roteador via GoRouter
final GoRouter appRouter = GoRouter(
  initialLocation: '/loja-da-ana-1234', // Início padrão pra testes
  routes: [
    GoRoute(
      path: '/error',
      name: 'error',
      builder: (context, state) => const StoreNotFoundScreen(),
    ),
    GoRoute(
      path: '/:store_slug/cart',
      name: 'cart',
      builder: (context, state) {
        final slug = state.pathParameters['store_slug'];
        return CartScreen(storeSlug: slug ?? '');
      },
    ),
    GoRoute(
      path: '/:store_slug/checkout',
      name: 'checkout',
      builder: (context, state) {
        final slug = state.pathParameters['store_slug'];
        return CheckoutScreen(storeSlug: slug ?? '');
      },
    ),
    GoRoute(
      path: '/:store_slug',
      name: 'store',
      builder: (context, state) {
        final slug = state.pathParameters['store_slug'];
        return MenuScreen(storeSlug: slug ?? '');
      },
    ),
  ],
);
