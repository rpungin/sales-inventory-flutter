import 'package:flutter_test/flutter_test.dart';
import 'package:sale_inventory/features/items/domain/item_model.dart';
import 'package:sale_inventory/features/items/domain/quantity_change_exception.dart';


void main() {
  late ItemModel itemModel;

  setUp(() {
    itemModel = const ItemModel(
      id: "id",
      name: "Test Item",
      description: "Test Item Description",
      price: 10,
      initialQuantity: 2,
      remainingQuantity: 1,
    );
  });

  group("Quantity Changes", () {
    test("Decrement quantity", () async {
      final decremented = itemModel.copyWithDecrementedQuantity();
      expect(decremented.remainingQuantity, 0);
    });

    test("Increment quantity", () async {
      final decremented = itemModel.copyWithIncrementedQuantity();
      expect(decremented.remainingQuantity, 2);
    });

    test("Decrement past zero", () async {
      final decremented = itemModel.copyWithDecrementedQuantity();
      expect(
          () => decremented.copyWithDecrementedQuantity(),
          throwsA(predicate((e) =>
              e is QuantityChangeException &&
              e.errorCode == QuantityChangeErrorCode.decrementError)));
    });

    test("Increment past initial quantity", () async {
      final decremented = itemModel.copyWithIncrementedQuantity();
      expect(
          () => decremented.copyWithIncrementedQuantity(),
          throwsA(predicate((e) =>
              e is QuantityChangeException &&
              e.errorCode == QuantityChangeErrorCode.incrementError)));
    });
  });

  test("Quantity sold", () {
    expect(itemModel.soldQuantity,
        itemModel.initialQuantity - itemModel.remainingQuantity);
  });
}
