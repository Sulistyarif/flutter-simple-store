import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:simple_store/controller/product_controller.dart';
import 'package:simple_store/controller/user_controller.dart';
import 'package:simple_store/data/provider_category.dart';
import 'package:simple_store/data/provider_product.dart';
import 'package:simple_store/data/provider_user.dart';
import 'package:simple_store/screens/main_menu_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderUser()),
        ChangeNotifierProvider(create: (context) => ProviderCategory()),
        ChangeNotifierProvider(create: (context) => ProviderProduct()),
      ],
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final productController = Get.put(ProductController());
  final userController = Get.put(UserController());

  @override
  void initState() {
    userController.loginStatusCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainMenuPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
