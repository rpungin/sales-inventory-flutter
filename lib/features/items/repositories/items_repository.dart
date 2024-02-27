import 'package:sale_inventory/core/repositories/repository.dart';
import 'package:sale_inventory/features/items/domain/item_model.dart';

abstract class ItemsRepository implements Repository {
  Future<void> createItem(ItemModel item);
  Future<void> updateItem(ItemModel item);
  Future<List<ItemModel>> getItems();
  Future<void> deleteItem(ItemModel item);

  Stream<ItemModel> onCreate();
  Stream<ItemModel> onUpdate();
  Stream<ItemModel> onDelete();
}
