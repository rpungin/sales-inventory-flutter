import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:sale_inventory/domain/item_model.dart';
import 'package:sale_inventory/models/Item.dart';
import 'package:sale_inventory/repositories/amplify_repository.dart';
import 'package:sale_inventory/repositories/items_repository.dart';

class AmplifyItemsRepository extends AmplifyRepository
    implements ItemsRepository {

  @override
  Future<void> createItem(ItemModel itemModel) async {
    final request = ModelMutations.create(_createItemFromItemModel(itemModel));
    final response = await Amplify.API.mutate(request: request).response;
    safePrint('Create result: $response');
  }

  @override
  Future<void> updateItem(ItemModel itemModel) async {
    try {
      final request =
          ModelMutations.update(_createItemFromItemModel(itemModel));
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Update result: $response');
    } on ApiException catch (e) {
      safePrint('Update item failed: $e');
      rethrow;
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
        .map((item) => _createItemModelFromItem(item))
        .toList();
  }

  @override
  Future<void> deleteItem(ItemModel itemModel) async {
    final request =
        ModelMutations.delete<Item>(_createItemFromItemModel(itemModel));
    final response = await Amplify.API.mutate(request: request).response;
    safePrint('Delete response: $response');
  }

  @override
  Stream<ItemModel> onCreate() {
    final Stream<GraphQLResponse<Item>> stream = Amplify.API.subscribe(
      ModelSubscriptions.onCreate(Item.classType),
      onEstablished: () => safePrint('onCreate Subscription established'),
    );
    return stream
//    .where((event) => event.data != null)
    .map((event) => _createItemModelFromItem(event.data!));
  }

    @override
  Stream<ItemModel> onUpdate() {
    final Stream<GraphQLResponse<Item>> stream = Amplify.API.subscribe(
      ModelSubscriptions.onUpdate(Item.classType),
      onEstablished: () => safePrint('onUpdate Subscription established'),
    );
    return stream
//    .where((event) => event.data != null)
    .map((event) => _createItemModelFromItem(event.data!));
  }

    @override
  Stream<ItemModel> onDelete() {
    final Stream<GraphQLResponse<Item>> stream = Amplify.API.subscribe(
      ModelSubscriptions.onDelete(Item.classType),
      onEstablished: () => safePrint('onDelete Subscription established'),
    );
    return stream
 //   .where((event) => event.data != null)
    .map((event) => _createItemModelFromItem(event.data!));
  }

  Item _createItemFromItemModel(ItemModel itemModel) => Item(
      id: itemModel.id,
      name: itemModel.name,
      description: itemModel.description,
      price: itemModel.price,
      initialQuantity: itemModel.initialQuantity,
      remainingQuantity: itemModel.remainingQuantity);

  ItemModel _createItemModelFromItem(Item item) => ItemModel(
      id: item.id,
      name: item.name,
      description: item.description,
      price: item.price,
      initialQuantity: item.initialQuantity,
      remainingQuantity: item.remainingQuantity);
}
