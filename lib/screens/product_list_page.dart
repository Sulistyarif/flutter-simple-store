import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_store/data/provider_user.dart';
import 'package:simple_store/screens/login_page.dart';
import 'package:simple_store/screens/profile_menu_page.dart';

import '../models/users.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  TextEditingController controllerSearch = TextEditingController();
  bool isLoggedIn = false;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Padding(
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
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return const Text('data');
                },
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _loadData() async {
    isLoggedIn =
        Provider.of<ProviderUser>(context, listen: false).getStatusLogin();
  }
}
