import 'package:go_router/go_router.dart';
import 'package:sale_inventory/features/items/domain/item_model.dart';
import 'package:sale_inventory/features/items/ui/manage_item_screen/manage_item_screen.dart';
import 'package:sale_inventory/features/items/ui/navigation_screen/navigation_screen.dart';

class AppRouter {
  static final _routes = [
    GoRoute(
      path: '/',
      builder: (context, state) => const NavigationScreen(),
    ),
    GoRoute(
      path: '/manage-item',
      name: 'manage-item',
      builder: (context, state) => ManageItemScreen(
        item: state.extra as ItemModel?,
      ),
    ),
  ];

  final router = GoRouter(routes: _routes);
}
