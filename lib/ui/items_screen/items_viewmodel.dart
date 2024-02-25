import 'package:flutter/foundation.dart';
import 'package:sale_inventory/models/Item.dart';
import 'package:sale_inventory/services/amplify_persistance_service.dart';

class ItemsViewModel {
  ItemsViewModel._internal();
  static final ItemsViewModel _instance = ItemsViewModel._internal();
  factory ItemsViewModel() => _instance;
  
  final itemsValueNotifier = ValueNotifier<List<Item>>([]);
  final persistanceService = AmplifyPersistanceService();

  Future<void> load() async {
    itemsValueNotifier.value = await persistanceService.getItems();
  }
}
