import 'package:flutter_test/flutter_test.dart';
import 'package:sale_inventory/domain/item_model.dart';

void main() {
  setUp(() {});

  test("Remaining quantity", () async {
    const itemModel = ItemModel(
      id: "id",
      name: "Test Item",
      description: "Test Item Description",
      price: 10,
      initialQuantity: 20,
      quantitySold: 4,
    );
    expect(itemModel.remainingQuantity, 20 - 4);
  });
}
