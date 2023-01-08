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
  TextEditingController controllerDesc = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
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
              'Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: controllerName,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: const TextStyle(
                    color: Colors.grey, fontStyle: FontStyle.italic),
                hintText: "product name",
                fillColor: Colors.white70,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Description',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: controllerDesc,
              minLines: 3,
              maxLines: 7,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: const TextStyle(
                    color: Colors.grey, fontStyle: FontStyle.italic),
                hintText: "product description",
                fillColor: Colors.white70,
              ),
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
              'Price',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: controllerPrice,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: const TextStyle(
                    color: Colors.grey, fontStyle: FontStyle.italic),
                hintText: "product price",
                fillColor: Colors.white70,
              ),
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
