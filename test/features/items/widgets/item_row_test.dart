import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sale_inventory/features/items/domain/item_model.dart';

import 'package:sale_inventory/features/items/ui/items_screen/item_row.dart';

void main() {
  testWidgets('Red text if remaining quantity is zero',
      (WidgetTester tester) async {
    const item = ItemModel(
        id: "id",
        name: "test",
        description: "description",
        price: 1,
        initialQuantity: 10,
        remainingQuantity: 0);
    await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ItemRow(item: item))));

    for (final widget in tester.allWidgets) {
      if (widget is Text) {
        expect(widget.style!.color!.value, Colors.red.value);
      }
    }
  });

    testWidgets('Non=red text if remaining quantity is not zero',
      (WidgetTester tester) async {
    const item = ItemModel(
        id: "id",
        name: "test",
        description: "description",
        price: 1,
        initialQuantity: 10,
        remainingQuantity: 1);
    await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ItemRow(item: item))));

    for (final widget in tester.allWidgets) {
      if (widget is Text) {
        expect(widget.style!.color!.value, isNot(equals( Colors.red.value)));
      }
    }
  });
}
