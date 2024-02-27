import 'package:flutter/material.dart';
import 'package:sale_inventory/features/items/domain/item_model.dart';
import 'package:sale_inventory/features/items/ui/items_screen/item_row_viewmodel.dart';
import 'package:sale_inventory/features/items/ui/items_screen/items_screen.dart';
import 'package:sale_inventory/features/items/ui/shared/button.dart';
import 'package:sale_inventory/features/items/ui/shared/styles.dart';

class QuantityView extends StatelessWidget {
  final ItemRowViewModel itemRowViewModel;
  final Color? textColor;
  const QuantityView(
      {super.key, required this.itemRowViewModel, required this.textColor});

  ItemModel get _item => itemRowViewModel.item;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ItemModel>(
        valueListenable: itemRowViewModel.itemValueNotifier,
        builder: (context, item, _) {
          return Column(children: [
            Row(
              children: [
                _buildQuantityView(context, item.initialQuantity, textColor),
                _buildQuantityView(context, item.soldQuantity, textColor),
                _buildQuantityView(context, item.remainingQuantity, textColor)
              ],
            ),
            _buildChangeQuantityView(context),
          ]);
        });
  }

  Widget _buildQuantityView(
      BuildContext context, int quantity, Color? textColor) {
    return SizedBox(
      width: ItemsScreen.quantityWidth,
      child: Text(quantity.toString(),
          style: Styles.textStyleLargeBold().copyWith(color: textColor),
          textAlign: TextAlign.right),
    );
  }

  Widget _buildChangeQuantityView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Styles.gridSpacing),
      child: Row(
        children: [
          Button(
            isEnabled: _item.remainingQuantity < _item.initialQuantity,
            onPressed: () {
              itemRowViewModel.incrementQuantity();
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: Styles.gridSpacing,
          ),
          Button(
            isEnabled: _item.remainingQuantity > 0,
            onPressed: () {
              itemRowViewModel.decrementQuantity();
            },
            icon: const Icon(Icons.remove, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
