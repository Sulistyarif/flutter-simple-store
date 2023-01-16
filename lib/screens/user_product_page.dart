import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_store/api/client_api.dart';
import 'package:simple_store/data/provider_product.dart';
import 'package:simple_store/data/provider_user.dart';
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

  /* @override
  void initState() {
    _loadData();
    super.initState();
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: isLoggedIn
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
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
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Consumer<ProviderProduct>(
                      builder: (context, value, child) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            _loadData();
                          },
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return ItemProduct(
                                  item: value.myProductList[index]);
                            },
                            itemCount: value.myProductList.length,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : const Center(child: Text('Please login first')),
    );
  }

  void _loadData() {
    isLoggedIn = Provider.of<ProviderUser>(context).getStatusLogin();
    if (isLoggedIn) {
      ClientApi.getMyProducts(
          context, Provider.of<ProviderUser>(context, listen: false).user!.id);
    }
  }
}
