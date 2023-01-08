import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_store/models/categories.dart';
import 'package:simple_store/screens/pick_category_page.dart';

class AddNewProductPage extends StatefulWidget {
  const AddNewProductPage({super.key});

  @override
  State<AddNewProductPage> createState() => _AddNewProductPageState();
}

class _AddNewProductPageState extends State<AddNewProductPage> {
  TextEditingController controllerName = TextEditingController();
  Categories? itemCategories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const Text(
              'Product name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: controllerName,
            ),
            const SizedBox(height: 15),
            const Text(
              'Product descriptions',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: controllerName,
              minLines: 3,
              maxLines: 7,
            ),
            const SizedBox(height: 15),
            const Text(
              'Product category',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                _onPickCategory();
              },
              child: Text(itemCategories == null
                  ? 'Select category'
                  : itemCategories!.name!),
            ),
            const SizedBox(height: 15),
            const Text(
              'Product price',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: controllerName,
            ),
            const SizedBox(height: 15),
            const Text(
              'Product image',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.add,
                  ),
                  Text('Add product image'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onPickCategory() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => PickCategoryPage(
          onPickCategory: (item) {
            itemCategories = item;
            setState(() {});
          },
        ),
      ),
    );
  }
}
