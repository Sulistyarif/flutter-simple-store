import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_store/api/client_api.dart';
import 'package:simple_store/data/provider_category.dart';
import 'package:simple_store/models/categories.dart';
import 'package:simple_store/widget/category_list_item.dart';
import 'package:simple_store/widget/dialog_new_category.dart';

class PickCategoryPage extends StatefulWidget {
  final Function(Categories) onPickCategory;
  PickCategoryPage({super.key, required this.onPickCategory});

  @override
  State<PickCategoryPage> createState() => _PickCategoryPageState();
}

class _PickCategoryPageState extends State<PickCategoryPage> {
  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category List'),
        actions: [
          GestureDetector(
            onTap: () {
              _onAddNewTapped();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ProviderCategory>(
          builder: (context, value, child) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return CategoryListItem(
                  item: value.categories[index],
                  onPicked: (Categories param) {
                    widget.onPickCategory(param);
                    Navigator.of(context).pop();
                  },
                );
              },
              itemCount: value.categories.length,
            );
          },
        ),
      ),
    );
  }

  void _onAddNewTapped() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogNewCategory(
          onAdded: () {
            _loadData();
          },
        );
      },
    );
  }

  void _loadData() {
    ClientApi.getCategories(context);
  }
}
