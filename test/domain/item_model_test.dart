import 'package:flutter_test/flutter_test.dart';
import 'package:sale_inventory/domain/item_model.dart';

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
      expect(() => decremented.copyWithDecrementedQuantity(), throwsException);
    });

    test("Increment past initial quantity", () async {
      final decremented = itemModel.copyWithIncrementedQuantity();
      expect(() => decremented.copyWithIncrementedQuantity(), throwsException);
    });
  });

  test("Quantity sold", () {
    expect(itemModel.soldQuantity,
        itemModel.initialQuantity - itemModel.remainingQuantity);
  });
}
