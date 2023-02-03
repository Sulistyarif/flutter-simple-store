import 'package:flutter/material.dart';
import 'package:simple_store/screens/product_list_page.dart';
import 'package:simple_store/screens/profile_page.dart';

import 'package:simple_store/screens/user_product_page.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  List<BottomNavigationBarItem> menuPageList = [];
  int currentIndex = 0;

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
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: menuPageList,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
      body: Center(child: _content()),
    );
  }

  void _loadData() {
    menuPageList = const [
      BottomNavigationBarItem(
        label: 'Search',
        icon: Icon(
          Icons.search,
        ),
      ),
      BottomNavigationBarItem(
        label: 'My Product',
        icon: Icon(
          Icons.shopping_basket_outlined,
        ),
      ),
      BottomNavigationBarItem(
        label: 'Profile',
        icon: Icon(
          Icons.person_outline,
        ),
      ),
    ];
  }

  Widget _content() {
    switch (currentIndex) {
      case 0:
        return const ProductListPage();
      case 1:
        return const UserProductPage();
      case 2:
        return const ProfilePage();

      default:
        return const ProductListPage();
    }
  }
}
