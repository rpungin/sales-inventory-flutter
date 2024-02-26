import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:sale_inventory/domain/item_model.dart';
import 'package:sale_inventory/models/Item.dart';
import 'package:sale_inventory/repositories/amplify_repository.dart';
import 'package:sale_inventory/repositories/items_repository.dart';

class AmplifyItemsRepository extends AmplifyRepository implements ItemsRepository {


  @override
  Future<void> createItem(ItemModel itemModel) async {
    final request = ModelMutations.create(_createItem(itemModel));
    final response = await Amplify.API.mutate(request: request).response;
    safePrint('Create result: $response');
  }

  @override
  Future<void> updateItem(ItemModel itemModel) async {
    try {
      final request = ModelMutations.update(_createItem(itemModel));
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Update result: $response');
    } on ApiException catch (e) {
      safePrint('Update item failed: $e');
    }
  }

  @override
  Future<List<ItemModel>> getItems() async {
    final request = ModelQueries.list(Item.classType);
    final response = await Amplify.API.query(request: request).response;
    if (response.hasErrors) {
      safePrint('errors: ${response.errors}');
      return [];
    }
    final items = response.data?.items;

    return items!
        .whereType<Item>()
        .map((item) => _createItemModel(item))
        .toList();
  }

  @override
  Future<void> deleteItem(ItemModel itemModel) async {
    final request = ModelMutations.delete<Item>(_createItem(itemModel));
    final response = await Amplify.API.mutate(request: request).response;
    safePrint('Delete response: $response');
  }

  Item _createItem(ItemModel itemModel) => Item(
      id: itemModel.id,
      name: itemModel.name,
      description: itemModel.description,
      price: itemModel.price,
      initialQuantity: itemModel.initialQuantity,
      quantitySold: itemModel.quantitySold);

  ItemModel _createItemModel(Item item) => ItemModel(
      id: item.id,
      name: item.name,
      description: item.description,
      price: item.price,
      initialQuantity: item.initialQuantity,
      quantitySold: item.quantitySold);
}
