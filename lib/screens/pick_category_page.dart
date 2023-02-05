import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_store/api/client_api.dart';
import 'package:simple_store/controller/category_controller.dart';
import 'package:simple_store/models/categories.dart';
import 'package:simple_store/widget/category_list_item.dart';
import 'package:simple_store/widget/dialog_new_category.dart';

class PickCategoryPage extends StatefulWidget {
  final Function(Categories) onPickCategory;
  const PickCategoryPage({super.key, required this.onPickCategory});

  @override
  State<PickCategoryPage> createState() => _PickCategoryPageState();
}

class _PickCategoryPageState extends State<PickCategoryPage> {
  final categoryController = Get.find<CategoryController>();

  @override
  void initState() {
    FirebaseAnalytics.instance
        .setCurrentScreen(screenName: 'pick_category_page');
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
          child: Obx(
            () {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return CategoryListItem(
                    item: categoryController.categoryList[index],
                    onPicked: (Categories param) {
                      widget.onPickCategory(param);
                      Navigator.of(context).pop();
                    },
                  );
                },
                itemCount: categoryController.categoryList.length,
              );
            },
          )),
    );
  }

  void _onAddNewTapped() {
    Get.dialog(DialogNewCategory(
      onAdded: () {
        _loadData();
      },
    ));
  }

  void _loadData() {
    ClientApi.getCategories();
  }
}
