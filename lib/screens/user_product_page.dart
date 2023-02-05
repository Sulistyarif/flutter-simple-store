import 'package:firebase_analytics/firebase_analytics.dart';
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

  @override
  void initState() {
    FirebaseAnalytics.instance
        .setCurrentScreen(screenName: 'user_product_list_page');
    super.initState();
  }

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
        body: Obx(
          () {
            return userController.isLoggedIn.value
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // CupertinoSearchTextField(controller: controllerSearch),
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.teal[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Text('You`ve been sell'),
                              Expanded(
                                child: Text(
                                  '${productController.myProductList.length} product(s)',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: productController.myProductList.isNotEmpty
                              ? RefreshIndicator(
                                  onRefresh: () async {
                                    _loadData();
                                  },
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(
                                        parent:
                                            AlwaysScrollableScrollPhysics()),
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
