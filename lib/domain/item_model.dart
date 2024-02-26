import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_model.freezed.dart';

@freezed
class ItemModel with _$ItemModel {
  const ItemModel._();
  @Assert('price >= 0', "price must be greater than or equal to zero.")
  @Assert('initialQuantity >= 0', "initialQuantity must be greater than 0")
  const factory ItemModel(
      {required String id,
      required String name,
      required String? description,
      required double price,
      required int initialQuantity,
      required int quantitySold}) = _ItemModel;

  int get remainingQuantity => initialQuantity - quantitySold;
}
