import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sale_inventory/domain/item_model.dart';
import 'package:sale_inventory/repositories/amplify_items_repository.dart';
import 'package:sale_inventory/ui/items_screen/item_row.dart';
import 'package:sale_inventory/ui/items_screen/items_viewmodel.dart';
import 'package:sale_inventory/ui/shared/styles.dart';

class ItemsScreen extends StatefulWidget {
  static const quantityWidth = 50.0;
  const ItemsScreen({Key? key}) : super(key: key);

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  final _itemsListViewModel = ItemsViewModel();
  final _repository = AmplifyItemsRepository();

  @override
  void initState() {
    _itemsListViewModel.load();
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
              valueListenable: _itemsListViewModel.itemsValueNotifier,
              builder: (context, items, _) {
                return Column(
                  children: [
                    _buildHeader(context, isEmpty: items.isEmpty),
                    Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Dismissible(
                            direction: DismissDirection.endToStart,
                            key: ValueKey(item),
                            background: const ColoredBox(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child:
                                      Icon(Icons.delete, color: Colors.white),
                                ),
                              ),
                            ),
                            onDismissed: (_) {
                              _repository.deleteItem(item);
                              _refreshItems();
                            },
                            child: ItemRow(
                              item: item,
                              onTap: () => _navigateToItem(item: item),
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
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              Column(
                children: [
                  Text(
                    "Quantity",
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

  Future<void> _navigateToItem({ItemModel? item}) async {
    await context.pushNamed('manage-item', extra: item);
  }

  Future<void> _refreshItems() async {
    await _itemsListViewModel.load();
  }
}
