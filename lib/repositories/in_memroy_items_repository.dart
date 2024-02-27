import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:sale_inventory/domain/item_model.dart';
import 'package:sale_inventory/repositories/items_repository.dart';

class InMemoryItemsRepository implements ItemsRepository {
  final Map<String, ItemModel> _dataMap = {};
  @override
  Future<void> createItem(ItemModel item) async {
    _dataMap[item.id] = item;
  }

  @override
  String createNewId() {
    return UUID.getUUID();
  }

  @override
  Future<void> deleteItem(ItemModel item) async {
    _dataMap.remove(item.id);
  }

  @override
  Future<List<ItemModel>> getItems() async {
    return _dataMap.values.toList();
  }

  @override
  Future<void> updateItem(ItemModel item) async {
    _dataMap[item.id] = item;
  }
  
  @override
  Stream<ItemModel> onCreate() {
    throw UnimplementedError();
  }
  
  @override
  Stream<ItemModel> onDelete() {
    throw UnimplementedError();
  }
  
  @override
  Stream<ItemModel> onUpdate() {
    throw UnimplementedError();
  }


}
