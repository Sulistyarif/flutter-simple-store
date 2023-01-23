import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_store/api/client_api.dart';
import 'package:simple_store/controller/product_controller.dart';
import 'package:simple_store/controller/user_controller.dart';
import 'package:simple_store/models/products.dart';
import 'package:simple_store/utlis/utils.dart';
import 'package:simple_store/widget/item_product.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final productController = Get.find<ProductController>();
  final userController = Get.find<UserController>();
  TextEditingController controllerSearch = TextEditingController();
  bool isLoggedIn = false;
  List<Products> listAllProduct = [];
  List<Products> listFoundProduct = [];

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: const Text('Simple Store'),
        actions: [
          GestureDetector(
            onTap: () {
              if (isLoggedIn) {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const ProfileMenuPage(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              }
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ), */
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            /* TextField(
              controller: controllerSearch,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(
                    color: Colors.grey[800], fontStyle: FontStyle.italic),
                hintText: "Search product",
                fillColor: Colors.white70,
                suffixIcon: const Icon(Icons.search),
              ),
            ), */
            CupertinoSearchTextField(
              controller: controllerSearch,
            ),
            const SizedBox(height: 10),
            Expanded(child: Obx(
              () {
                listAllProduct = productController.allProductList;
                return RefreshIndicator(
                  onRefresh: () async {
                    _loadData();
                  },
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      Random rnd = Random();
                      return ItemProduct(
                        key: Key(Utils.getRandomString(6, rnd)),
                        item: productController.allProductList[index],
                      );
                    },
                    itemCount: productController.allProductList.length,
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }

  void _loadData() async {
    isLoggedIn = userController.isLoggedIn.value;
    ClientApi.getAllProducts();
  }
}
