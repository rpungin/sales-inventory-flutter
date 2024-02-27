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
      final request = ModelMutations.update(_createItemFromItemModel(itemModel));
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
    final request = ModelMutations.delete<Item>(_createItemFromItemModel(itemModel));
    final response = await Amplify.API.mutate(request: request).response;
    safePrint('Delete response: $response');
  }

  StreamSubscription<GraphQLResponse<Item>>? subscription;

void subscribe() {
  final subscriptionRequest = ModelSubscriptions.onCreate(Item.classType);
  final Stream<GraphQLResponse<Item>> operation = Amplify.API.subscribe(
    subscriptionRequest,
    onEstablished: () => safePrint('Subscription established'),
  );
  subscription = operation.listen(
    (event) {
      safePrint('Subscription event data received: ${event.data}');
    },
    onError: (Object e) => safePrint('Error in subscription stream: $e'),
  );
}

void unsubscribe() {
  subscription?.cancel();
  subscription = null;
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
