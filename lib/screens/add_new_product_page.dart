import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_store/api/client_api.dart';
import 'package:simple_store/controller/user_controller.dart';
import 'package:simple_store/models/categories.dart';
import 'package:simple_store/screens/pick_category_page.dart';
import 'package:simple_store/widget/dialog_yes_no.dart';
import 'dart:io' as Io;

class AddNewProductPage extends StatefulWidget {
  final Function() onProductAdded;
  const AddNewProductPage({super.key, required this.onProductAdded});

  @override
  State<AddNewProductPage> createState() => _AddNewProductPageState();
}

class _AddNewProductPageState extends State<AddNewProductPage> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDesc = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  Categories? itemCategories;
  bool isImageChanged = false;
  Io.File? _image;
  final _picker = ImagePicker();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
        actions: [
          GestureDetector(
            onTap: () {
              _onProductAdd();
            },
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
            const SizedBox(height: 15),
            const Text(
              'Product image',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                _showImagePicker(context);
              },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: !isImageChanged
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.add,
                          ),
                          Text('Add product image'),
                        ],
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8)),
                        child: Image.file(_image!),
                      ),
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

  void _onProductAdd() async {
    Get.dialog(
      DialogYesNo(
          onYes: () async {
            bool isSuccess = await ClientApi.createProduct(
              controllerName.text,
              controllerDesc.text,
              itemCategories!.id!,
              userController.user.value.id!,
              controllerPrice.text,
              'image',
            );
            if (isSuccess) {
              widget.onProductAdded();
              Get.back();
              Get.back();
            } else {
              Get.snackbar('Simple Store', 'Failed to create product');
            }
          },
          title: 'Are you want to add this product?'),
    );
  }

  void _showImagePicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    XFile? image2 =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 20);

    setState(() {
      _image = Io.File(image2!.path);
      isImageChanged = true;
    });
    // uploadImage();
  }

  _imgFromGallery() async {
    XFile? image2 =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 20);

    setState(() {
      _image = Io.File(image2!.path);
      isImageChanged = true;
    });
    // uploadImage();
  }
}
