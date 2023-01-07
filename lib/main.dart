import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_store/data/provider_user.dart';
import 'package:simple_store/screens/product_list_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderUser()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductListPage(),
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
