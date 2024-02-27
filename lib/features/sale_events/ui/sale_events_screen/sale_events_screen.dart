import 'package:flutter/material.dart';
import 'package:sale_inventory/core/ui/styles.dart';

class SaleEventsScreen extends StatefulWidget {
  const SaleEventsScreen({Key? key}) : super(key: key);

  @override
  State<SaleEventsScreen> createState() => _SaleEventsScreenState();
}

class _SaleEventsScreenState extends State<SaleEventsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Sale Events", style: Styles.textStyleLargeBold(),));
  }
}