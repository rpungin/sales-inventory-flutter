import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:sale_inventory/models/Item.dart';
import 'package:sale_inventory/services/persistance_service.dart';

class AmplifyPersistanceService implements PersistanceService {
  @override
  Future<void> createItem(Item item) async {
    final request = ModelMutations.create(item);
    final response = await Amplify.API.mutate(request: request).response;
    safePrint('Create result: $response');
  }

  @override
  Future<void> updateItem(Item item) async {
    try {
      final request = ModelMutations.update(item);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Update result: $response');
    } on ApiException catch (e) {
      safePrint('Update item failed: $e');
    }
  }

  @override
  Future<List<Item>> getItems() async {
    final request = ModelQueries.list(Item.classType);
    final response = await Amplify.API.query(request: request).response;
    if (response.hasErrors) {
      safePrint('errors: ${response.errors}');
      return [];
    }
    final items = response.data?.items;
    return items!.whereType<Item>().toList();
  }

  @override
  Future<void> deleteItem(Item item) async {
    final request = ModelMutations.delete<Item>(item);
    final response = await Amplify.API.mutate(request: request).response;
    safePrint('Delete response: $response');
  }
}
