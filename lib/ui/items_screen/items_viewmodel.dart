import 'package:flutter/foundation.dart';
import 'package:sale_inventory/domain/item_model.dart';
import 'package:sale_inventory/repositories/items_repository.dart';

class ItemsViewModel {
  final ItemsRepository repository;

  ItemsViewModel(this.repository);
  final itemsValueNotifier = ValueNotifier<List<ItemModel>>([]);

  Future<void> load() async {
    itemsValueNotifier.value = await repository.getItems();
  }
}
