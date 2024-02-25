import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sale_inventory/models/Item.dart';
import 'package:sale_inventory/services/amplify_persistance_service.dart';
import 'package:sale_inventory/ui/items_screen/item_row.dart';
import 'package:sale_inventory/ui/items_screen/items_viewmodel.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({Key? key}) : super(key: key);

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  final _itemsListViewModel = ItemsViewModel();
  final _persistanceService = AmplifyPersistanceService();

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
          child: ValueListenableBuilder(
              valueListenable: _itemsListViewModel.itemsValueNotifier,
              builder: (context, items, _) {
                return Column(
                  children: [
                    if (items.isEmpty)
                      const Text('Use the \u002b sign to add new items')
                    else
                      Container(),
                    const Divider(),
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
                              _persistanceService.deleteItem(item);
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

  Future<void> _navigateToItem({Item? item}) async {
    await context.pushNamed('manage', extra: item);
    await _itemsListViewModel.load();
  }

  Future<void> _refreshItems() async {
    await _itemsListViewModel.load();
  }
}
