import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_model.freezed.dart';

@freezed
class ItemModel with _$ItemModel {
  const ItemModel._();
  const factory ItemModel(
      {required String id,
      required String name,
      required String? description,
      required double price,
      required int initialQuantity,
      required int remainingQuantity}) = _ItemModel;

  int get soldQuantity => initialQuantity - remainingQuantity;

  ItemModel copyWithIncrementedQuantity() {
    // assert(remainingQuantity < initialQuantity,
    // "Current quantity is 0 and cannot be incremented");
    if (remainingQuantity < initialQuantity) {
      return copyWith(remainingQuantity: remainingQuantity + 1);
    } else {
      throw Exception(
          "Current quantity is at the inital quantity and cannot be incremented");
    }
  }

  ItemModel copyWithDecrementedQuantity() {
    // assert(remainingQuantity > 0,
    //     "Current quantity is 0 and cannot be incremented");
    if (remainingQuantity > 0) {
      return copyWith(remainingQuantity: remainingQuantity - 1);
    } else {
      throw Exception("Current quantity is 0 and cannot be incremented");
    }
  }
}
