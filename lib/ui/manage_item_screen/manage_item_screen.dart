import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sale_inventory/models/Item.dart';
import 'package:sale_inventory/services/amplify_persistance_service.dart';
import 'package:sale_inventory/ui/items_screen/items_viewmodel.dart';

class ManageItemScreen extends StatefulWidget {
  const ManageItemScreen({
    required this.item,
    super.key,
  });

  final Item? item;

  @override
  State<ManageItemScreen> createState() => _ManageItemScreenState();
}

class _ManageItemScreenState extends State<ManageItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  late final String _titleText;

  bool get _isCreate => _item == null;
  Item? get _item => widget.item;

  final persistanceService = AmplifyPersistanceService();

  @override
  void initState() {
    super.initState();

    final item = _item;
    if (item != null) {
      _nameController.text = item.name;
      _descriptionController.text = item.description;
      _priceController.text = item.price.toStringAsFixed(2);
      _titleText = 'Update Item';
    } else {
      _titleText = 'Create Item';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final title = _nameController.text;
    final description = _descriptionController.text;
    final amount = double.parse(_priceController.text);

    if (_isCreate) {
      final newItem = Item(
        name: title,
        description: description.isNotEmpty ? description : "",
        initialQuantity: 10,
        currentQuantity: 10,
        price: amount,
      );
      await persistanceService.createItem(newItem);
    } else {
      final updatedItem = _item!.copyWith(
        name: title,
        description: description.isNotEmpty ? description : null,
        price: amount,
      );
      await persistanceService.updateItem(updatedItem);
    }

    await ItemsViewModel().load();
    if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleText),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name (required)',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                    ),
                    TextFormField(
                      controller: _priceController,
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: false,
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Price (required)',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a price';
                        }
                        final amount = double.tryParse(value);
                        if (amount == null || amount <= 0) {
                          return 'Please enter a valid price';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: submitForm,
                      child: Text(_titleText),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
