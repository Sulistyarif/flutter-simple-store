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
  bool searchProductList = false;

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
            CupertinoSearchTextField(
              controller: controllerSearch,
              onSubmitted: (value) {
                // add get product with contain
                ClientApi.searchProduct(value);
                searchProductList = true;
                if (value == '') {
                  searchProductList = false;
                }
                setState(() {});
              },
              onSuffixTap: () {
                // when suffix tap, will change to all list data
                controllerSearch.clear();
                searchProductList = false;
                productController.searchProductList.clear();
                setState(() {});
              },
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
                        item: !searchProductList
                            ? productController.allProductList[index]
                            : productController.searchProductList[index],
                      );
                    },
                    itemCount: !searchProductList
                        ? productController.allProductList.length
                        : productController.searchProductList.length,
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
