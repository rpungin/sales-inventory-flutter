import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sale_inventory/domain/item_model.dart';
import 'package:sale_inventory/repositories/amplify_items_repository.dart';
import 'package:sale_inventory/ui/items_screen/items_viewmodel.dart';

class ManageItemScreen extends StatefulWidget {
  const ManageItemScreen({
    required this.item,
    super.key,
  });

  final ItemModel? item;

  @override
  State<ManageItemScreen> createState() => _ManageItemScreenState();
}

class _ManageItemScreenState extends State<ManageItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  late final String _titleText;

  bool get _isCreate => _item == null;
  ItemModel? get _item => widget.item;

  final repository = AmplifyItemsRepository();

  @override
  void initState() {
    super.initState();

    final item = _item;
    if (item != null) {
      _nameController.text = item.name;
      _descriptionController.text = item.description ?? "";
      _priceController.text = item.price.toStringAsFixed(2);
      _quantityController.text = item.initialQuantity.toString();
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
    _quantityController.dispose();
    super.dispose();
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
                          return 'Please enter a price.';
                        }
                        final amount = double.tryParse(value);
                        if (amount == null || amount <= 0) {
                          return 'Please enter a valid price.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _quantityController,
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: false,
                        decimal: false,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Initial Quantity (required)',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the initial quantity.';
                        }
                        final amount = double.tryParse(value);
                        if (amount == null || amount <= 0) {
                          return 'Please enter a valid quantity.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
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

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final title = _nameController.text;
    final description = _descriptionController.text;
    final price = double.parse(_priceController.text);
    final initialQuantity = int.parse(_quantityController.text);
    if (_isCreate) {
      final newItem = ItemModel(
        id: repository.createNewId(),
        name: title,
        description: description.isNotEmpty ? description : "",
        initialQuantity: initialQuantity,
        quantitySold: 0,
        price: price,
      );
      await repository.createItem(newItem);
    } else {
      final updatedItem = _item!.copyWith(
        name: title,
        description: description.isNotEmpty ? description : null,
        initialQuantity: initialQuantity,
        price: price,
      );
      await repository.updateItem(updatedItem);
    }

    await ItemsViewModel().load();
    if (mounted) {
      context.pop();
    }
  }
}
