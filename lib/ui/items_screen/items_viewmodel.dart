import 'package:flutter/foundation.dart';
import 'package:sale_inventory/domain/item_model.dart';
import 'package:sale_inventory/repositories/amplify_items_repository.dart';

class ItemsViewModel {
  ItemsViewModel._internal();
  static final ItemsViewModel _instance = ItemsViewModel._internal();
  factory ItemsViewModel() => _instance;

  final itemsValueNotifier = ValueNotifier<List<ItemModel>>([]);
  final repository = AmplifyItemsRepository();

  Future<void> load() async {
    itemsValueNotifier.value = await repository.getItems();
  }
}
