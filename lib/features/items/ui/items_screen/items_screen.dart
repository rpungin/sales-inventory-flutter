import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sale_inventory/core/ui/styles.dart';
import 'package:sale_inventory/features/items/domain/item_model.dart';
import 'package:sale_inventory/main.dart';
import 'package:sale_inventory/features/items/repositories/amplify_items_repository.dart';
import 'package:sale_inventory/features/items/repositories/items_repository.dart';
import 'package:sale_inventory/features/items/ui/items_screen/item_row.dart';
import 'package:sale_inventory/features/items/ui/items_screen/items_viewmodel.dart';

class ItemsScreen extends ConsumerStatefulWidget {
  static const quantityWidth = 50.0;
  const ItemsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends ConsumerState<ItemsScreen> {
  late final ItemsViewModel _itemsViewModel;
  final ItemsRepository _repository = AmplifyItemsRepository();

  @override
  void initState() {
    _itemsViewModel = ref.read(itemsViewModelProvider);
    _itemsViewModel.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: RefreshIndicator(
          onRefresh: _refreshItems,
          child: ValueListenableBuilder<List<ItemModel>>(
              valueListenable: _itemsViewModel.itemsValueNotifier,
              builder: (context, items, _) {
                return Column(
                  children: [
                    _buildHeader(context, isEmpty: items.isEmpty),
                    Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              extentRatio: 0.5,
                              children: [
                                SlidableAction(
                                    label: "Edit",
                                    backgroundColor: Colors.green,
                                    icon: Icons.edit,
                                    onPressed: (context) async {
                                      _navigateToItem(item);
                                    }),
                                SlidableAction(
                                    label: "Delete",
                                    backgroundColor: Colors.red,
                                    icon: Icons.delete,
                                    onPressed: (context) async {
                                      _deleteItem(item);
                                    }),
                              ],
                            ),
                            child: ItemRow(
                              key: UniqueKey(),
                              item: item,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, {required bool isEmpty}) {
    if (isEmpty) {
      return Text(
        'Use the \u002b sign to add new items',
        style: Styles.textStyleNormal(),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(Styles.gridSpacing),
      child: Padding(
        padding: const EdgeInsets.only(right: Styles.gridSpacing * 2),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: Styles.gridSpacing),
                  child: Text(
                    "Item".toUpperCase(),
                    style: Styles.textStyleNormalBold(),
                  ),
                )),
                Column(
                  children: [
                    Text(
                      "Quantity".toUpperCase(),
                      style: Styles.textStyleNormalBold(),
                    ),
                    Row(
                      children: [
                        _buildQuantityHeaderText(context, "Orig."),
                        _buildQuantityHeaderText(context, "Sold"),
                        _buildQuantityHeaderText(context, "Rem."),
                      ],
                    )
                  ],
                )
              ],
            ),
            const Divider()
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityHeaderText(BuildContext context, String text) {
    return SizedBox(
      width: ItemsScreen.quantityWidth,
      child: Text(
        text,
        style: Styles.textStyleSmall(),
        textAlign: TextAlign.end,
      ),
    );
  }

  Future<void> _navigateToItem(ItemModel? item) async {
    await context.pushNamed('manage-item', extra: item);
  }

  Future<void> _deleteItem(ItemModel item) async {
    _repository.deleteItem(item);
    _refreshItems();
  }

  Future<void> _refreshItems() async {
    await _itemsViewModel.load();
  }
}
