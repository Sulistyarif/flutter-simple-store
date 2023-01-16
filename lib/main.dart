import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:simple_store/data/provider_category.dart';
import 'package:simple_store/data/provider_product.dart';
import 'package:simple_store/data/provider_user.dart';
import 'package:simple_store/screens/main_menu_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderUser()),
        ChangeNotifierProvider(create: (context) => ProviderCategory()),
        ChangeNotifierProvider(create: (context) => ProviderProduct()),
      ],
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainMenuPage(),
      ),
    ),
  );
}

/* class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProductListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
} */
