import 'package:flutter/material.dart';
import 'package:sale_inventory/models/Item.dart';

class ItemRow extends StatelessWidget {
  final Item item;
  final VoidCallback onTap;
  const ItemRow({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(item.name),
      subtitle: Text(item.description),
    );
  }
}
