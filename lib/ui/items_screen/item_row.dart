import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sale_inventory/domain/item_model.dart';
import 'package:sale_inventory/main.dart';
import 'package:sale_inventory/ui/items_screen/item_row_viewmodel.dart';
import 'package:sale_inventory/ui/items_screen/quantity_view.dart';
import 'package:sale_inventory/ui/shared/styles.dart';

final itemRowViewModelProvider = Provider.family<ItemRowViewModel, ItemModel>(
    (ref, item) => ItemRowViewModel(item, ref.read(itemsRepositoryProvider)));

class ItemRow extends ConsumerStatefulWidget {
  final ItemModel item;
   const ItemRow({
    super.key,
    required this.item,
  });

  @override
  ConsumerState<ItemRow> createState() => _ItemRowState();
}

class _ItemRowState extends ConsumerState<ItemRow> {
  late final ItemRowViewModel _itemRowViewModel;

  @override
  void initState() {
    _itemRowViewModel = ref.read(itemRowViewModelProvider(widget.item));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Styles.gridSpacing),
        child: ValueListenableBuilder<ItemModel>(
            valueListenable: _itemRowViewModel.itemValueNotifier,
            builder: (context, item, _) {
              final textColor =
                  item.remainingQuantity == 0 ? Colors.red.shade500 : null;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            style: Styles.textStyleNormal()
                                .copyWith(color: textColor))
                      ],
                    ),
                  ),
                  QuantityView(
                    itemRowViewModel: _itemRowViewModel,
                    textColor: textColor,
                  )
                ],
              );
            }),
      ),
    );
  }
}
