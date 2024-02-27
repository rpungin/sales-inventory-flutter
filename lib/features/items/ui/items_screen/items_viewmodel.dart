import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sale_inventory/features/items/domain/item_model.dart';
import 'package:sale_inventory/features/items/repositories/items_repository.dart';

class ItemsViewModel {
  final ItemsRepository repository;

  StreamSubscription? _onCreateSubscription;
  StreamSubscription? _onUpdateSubscription;
  StreamSubscription? _onDeleteSubscription;

  ItemsViewModel(this.repository) {
    _onCreateSubscription = repository.onCreate().listen((item) {
      final items = itemsValueNotifier.value;
      items.add(item);
      _setItems(items);
    });

    _onUpdateSubscription = repository.onUpdate().listen((item) {
      final items = itemsValueNotifier.value;
      items.removeWhere((element) => element.id == item.id);
      items.add(item);
      _setItems(items);
    });

    _onDeleteSubscription = repository.onDelete().listen((item) {
      final items = itemsValueNotifier.value;
      items.remove(item);
      _setItems(items);
    });
  }
  final itemsValueNotifier = ValueNotifier<List<ItemModel>>([]);

  Future<void> load() async {
    _setItems(await repository.getItems());
  }

  void _setItems(List<ItemModel> items) {
    final sortedItems = items.toList();
    sortedItems.sort(
      (a, b) => a.name.compareTo(b.name),
    );
    itemsValueNotifier.value = sortedItems;
  }

  void dispose() {
    _onCreateSubscription?.cancel();
    _onCreateSubscription = null;
    _onUpdateSubscription?.cancel();
    _onUpdateSubscription = null;
    _onDeleteSubscription?.cancel();
    _onDeleteSubscription = null;
  }
}
