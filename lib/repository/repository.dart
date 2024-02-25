import 'package:sale_inventory/models/Item.dart';

abstract class Repository {
  Future<void> createItem(Item item);
  Future<void> updateItem(Item item);
  Future<List<Item>> getItems();
  Future<void> deleteItem(Item item);
}
