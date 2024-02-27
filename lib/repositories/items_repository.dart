import 'package:sale_inventory/domain/item_model.dart';
import 'package:sale_inventory/repositories/repository.dart';

abstract class ItemsRepository implements Repository {
  Future<void> createItem(ItemModel item);
  Future<void> updateItem(ItemModel item);
  Future<List<ItemModel>> getItems();
  Future<void> deleteItem(ItemModel item);

  Stream<ItemModel> onCreate();
  Stream<ItemModel> onUpdate();
  Stream<ItemModel> onDelete();
}
