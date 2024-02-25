import 'package:flutter/foundation.dart';
import 'package:sale_inventory/models/Item.dart';
import 'package:sale_inventory/repository/amplify_repository.dart';

class ItemsViewModel {
  ItemsViewModel._internal();
  static final ItemsViewModel _instance = ItemsViewModel._internal();
  factory ItemsViewModel() => _instance;

  final itemsValueNotifier = ValueNotifier<List<Item>>([]);
  final repository = AmplifyRepository();

  Future<void> load() async {
    itemsValueNotifier.value = await repository.getItems();
  }
}
