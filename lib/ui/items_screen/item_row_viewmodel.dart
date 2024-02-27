import 'package:flutter/material.dart';
import 'package:sale_inventory/domain/item_model.dart';
import 'package:sale_inventory/repositories/items_repository.dart';

class ItemRowViewModel {
  final ItemsRepository itemsRepository;
  late final ValueNotifier<ItemModel> itemValueNotifier;
  final errorMessageValueNotifier = ValueNotifier<String?>(null);

  ItemRowViewModel(ItemModel item, this.itemsRepository) {
    itemValueNotifier = ValueNotifier<ItemModel>(item);
  }

  ItemModel get item => itemValueNotifier.value;

  Future<void> incrementQuantity() async {
    try {
      final updatedItem =
          item.copyWithIncrementedQuantity();
      itemsRepository.updateItem(updatedItem);
      itemValueNotifier.value = updatedItem;
    } catch (e) {
      errorMessageValueNotifier.value = e.toString();
    }
  }

  Future<void> decrementQuantity() async {
    try {
      final updatedItem =
          item.copyWithDecrementedQuantity();
      itemsRepository.updateItem(updatedItem);
      itemValueNotifier.value = updatedItem;
    } catch (e) {
      errorMessageValueNotifier.value = e.toString();
    }
  }
}
