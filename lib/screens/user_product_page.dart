import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_store/api/client_api.dart';
import 'package:simple_store/controller/product_controller.dart';
import 'package:simple_store/controller/user_controller.dart';
import 'package:simple_store/screens/add_new_product_page.dart';
import 'package:simple_store/widget/item_product.dart';

class UserProductPage extends StatefulWidget {
  const UserProductPage({super.key});

  @override
  State<UserProductPage> createState() => _UserProductPageState();
}

class _UserProductPageState extends State<UserProductPage> {
  TextEditingController controllerSearch = TextEditingController();
  bool isLoggedIn = false;
  final userController = Get.find<UserController>();
  final productController = Get.find<ProductController>();

  /* @override
  void initState() {
    _loadData();
    super.initState();
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: userController.isLoggedIn.value
            ? FloatingActionButton(
                onPressed: () {
                  Get.to(
                    AddNewProductPage(
                      onProductAdded: () {
                        ClientApi.getMyProducts();
                      },
                    ),
                  );
                },
                child: const Icon(Icons.add),
              )
            : null,
        /* appBar: AppBar(
        title: const Text('My Product'),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => AddNewProductPage(
                    onProductAdded: () {
                      _loadData();
                    },
                  ),
                ),
              );
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
      ), */
        body: Obx(
          () {
            return userController.isLoggedIn.value
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CupertinoSearchTextField(controller: controllerSearch),
                        const SizedBox(height: 10),
                        Expanded(
                          child: productController.myProductList.isNotEmpty
                              ? RefreshIndicator(
                                  onRefresh: () async {
                                    _loadData();
                                  },
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return ItemProduct(
                                        item: productController
                                            .myProductList[index],
                                      );
                                    },
                                    itemCount:
                                        productController.myProductList.length,
                                  ),
                                )
                              : const Center(
                                  child: Text(
                                    'No product found',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: Text('Please login first'),
                  );
          },
        ));
  }

  void _loadData() {
    isLoggedIn = userController.isLoggedIn.value;
    if (isLoggedIn) {
      ClientApi.getMyProducts();
    }
    setState(() {});
  }
}
