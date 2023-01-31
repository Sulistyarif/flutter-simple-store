import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_store/controller/category_controller.dart';
import 'dart:io' as Io;
import '../api/client_api.dart';
import '../controller/user_controller.dart';
import '../models/categories.dart';
import '../models/products.dart';
import 'pick_category_page.dart';

class EditProductPage extends StatefulWidget {
  final Products item;
  const EditProductPage({super.key, required this.item});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDesc = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  Categories? itemCategories;
  bool isImageChanged = false;
  Io.File? _image;
  final _picker = ImagePicker();
  final userController = Get.find<UserController>();
  final categoriesController = Get.find<CategoryController>();

  @override
  void initState() {
    controllerName.text = widget.item.name!;
    controllerDesc.text = widget.item.description!;
    controllerPrice.text = widget.item.price!.toString();
    itemCategories =
        categoriesController.getCategoriesDetail(widget.item.category!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit product'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Image.network(
              '${ClientApi.uri}/${widget.item.image}',
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width / 2,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.grey,
                      ),
                      Text(
                        'No picture available',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
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
              keyboardType: TextInputType.number,
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
          ],
        ),
      ),
    );
  }

  void _onPickCategory() {
    Get.to(
      PickCategoryPage(
        onPickCategory: (item) {
          itemCategories = item;
          setState(() {});
        },
      ),
    );
  }
}
