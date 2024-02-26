import 'package:flutter/material.dart';
import 'package:sale_inventory/domain/item_model.dart';
import 'package:sale_inventory/ui/items_screen/items_screen.dart';
import 'package:sale_inventory/ui/shared/styles.dart';

class ItemRow extends StatelessWidget {
  final ItemModel item;
  final VoidCallback onTap;
  const ItemRow({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textColor = item.remainingQuantity == 0 ? Colors.red : null;
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Styles.gridSpacing),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: Styles.textStyleLargeBold()
                          .copyWith(color: textColor),
                    ),
                    Text(item.description ?? "",
                        style:
                            Styles.textStyleNormal().copyWith(color: textColor))
                  ],
                ),
              ),
              Row(children: [
                _buildQuantityView(context, item.initialQuantity, textColor),
                _buildQuantityView(context, item.quantitySold, textColor),
                _buildQuantityView(context, item.remainingQuantity, textColor),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityView(
      BuildContext context, int quantity, MaterialColor? textColor) {
    return SizedBox(
      width: ItemsScreen.quantityWidth,
      child: Text(quantity.toString(),
          style: Styles.textStyleLargeBold().copyWith(color: textColor),
          textAlign: TextAlign.right),
    );
  }
}
