import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:sale_inventory/core/ui/app_router.dart';
import 'package:sale_inventory/features/items/repositories/amplify_items_repository.dart';
import 'package:sale_inventory/features/items/repositories/items_repository.dart';
import 'package:sale_inventory/core/services/amplify_service.dart';
import 'package:sale_inventory/features/items/ui/items_screen/items_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Dependency Injection
final itemsRepositoryProvider =
    Provider<ItemsRepository>((ref) => AmplifyItemsRepository());

final itemsViewModelProvider = Provider<ItemsViewModel>((ref) => ItemsViewModel(ref.read(itemsRepositoryProvider)));


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AmplifyService().initialize();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp.router(
        routerConfig: AppRouter().router,
        debugShowCheckedModeBanner: false,
        builder: Authenticator.builder(),
      ),
    );
  }
}
