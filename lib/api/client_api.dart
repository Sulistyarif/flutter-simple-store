import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:simple_store/controller/category_controller.dart';
import 'package:simple_store/controller/user_controller.dart';
import 'package:simple_store/models/categories.dart' as category_class;
import 'package:simple_store/models/products.dart' as product_class;
import 'package:simple_store/models/users.dart' as user_class;

import '../controller/product_controller.dart';

class ClientApi {
  static final Uri uri = Uri.parse('http://api.zakia-dev.my.id');
  // static final Uri uri = Uri.parse('http://192.168.18.6:5004');
  static final client = http.Client();
  static final productController = Get.find<ProductController>();
  static final userController = Get.find<UserController>();
  static final categoryController = Get.find<CategoryController>();

  static Future<Map<String, dynamic>> login(username, password, context) async {
    var response = await client.post(
      Uri.parse('$uri/login'),
      headers: {
        "content-type": "application/x-www-form-urlencoded",
      },
      body: {
        'username': username,
        'password': password,
      },
    );
    Map<String, dynamic> resJson = json.decode(response.body);
    userController
        .changeLoggedInUser(user_class.Users.fromJson(resJson['data']));
    log(response.body);
    return resJson;
  }

  static Future<bool> register(username, email, password) async {
    var response = await client.post(
      Uri.parse('$uri/crud'),
      headers: {
        "content-type": "application/x-www-form-urlencoded",
      },
      body: {
        'username': username,
        'email': email,
        'password': password,
      },
    );
    Map<String, dynamic> resJson = json.decode(response.body);
    log(response.body);
    if (resJson['success']) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> forgot(username) async {
    var response = await client.post(
      Uri.parse('$uri/password'),
      headers: {
        "content-type": "application/x-www-form-urlencoded",
      },
      body: {
        'username': username,
      },
    );
    Map<String, dynamic> resJson = json.decode(response.body);
    log(response.body);
    return resJson['message'];
  }

  static Future<void> getCategories() async {
    var response = await client.get(
      Uri.parse('$uri/category'),
      headers: {
        "content-type": "application/x-www-form-urlencoded",
      },
    );
    var resJson = json.decode(response.body).cast<Map<String, dynamic>>();
    List<category_class.Categories> responseList = [];
    responseList = resJson != null
        ? resJson
            .map<category_class.Categories>(
                (json) => category_class.Categories.fromJson(json))
            .toList()
        : [];
    categoryController.setCategoryList(responseList);
    log(response.body);
  }

  static Future<bool> createCategory(name) async {
    var response = await client.post(
      Uri.parse('$uri/category'),
      headers: {
        "content-type": "application/x-www-form-urlencoded",
      },
      body: {
        'name': name,
      },
    );
    Map<String, dynamic> resJson = json.decode(response.body);
    log(response.body);
    if (resJson['success']) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> getAllProducts() async {
    var response = await client.get(
      Uri.parse('$uri/product'),
      headers: {
        "content-type": "application/x-www-form-urlencoded",
      },
    );
    var resJson = json.decode(response.body).cast<Map<String, dynamic>>();
    List<product_class.Products> responseList = [];
    responseList = resJson != null
        ? resJson
            .map<product_class.Products>(
                (json) => product_class.Products.fromJson(json))
            .toList()
        : [];
    productController.setAllProduct(responseList);
    log(response.body);
  }

  static Future<bool> createProduct(String name, String desc, int categoryId,
      int sellerId, String price, String image) async {
    var response = await client.post(
      Uri.parse('$uri/product'),
      headers: {
        "content-type": "application/x-www-form-urlencoded",
      },
      body: {
        'name': name,
        'description': desc,
        'category_id': categoryId.toString(),
        'seller_id': sellerId.toString(),
        'price': price.toString(),
        'image': image,
      },
    );
    Map<String, dynamic> resJson = json.decode(response.body);
    log(response.body);
    if (resJson['success']) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> getMyProducts() async {
    var response = await client.get(
      Uri.parse('$uri/product/${userController.user.value.id}'),
      headers: {
        "content-type": "application/x-www-form-urlencoded",
      },
    );
    var resJson = json.decode(response.body).cast<Map<String, dynamic>>();
    List<product_class.Products> responseList = [];
    responseList = resJson != null
        ? resJson
            .map<product_class.Products>(
                (json) => product_class.Products.fromJson(json))
            .toList()
        : [];
    productController.setAllMyProduct(responseList);
    log(response.body);
  }

  static Future<bool> deleteProduct(context, productId) async {
    var response = await client.delete(
      Uri.parse('$uri/product/$productId'),
      headers: {
        "content-type": "application/x-www-form-urlencoded",
      },
    );
    // var resJson = json.decode(response.body).cast<Map<String, dynamic>>();
    Map<String, dynamic> resJson = json.decode(response.body);
    if (resJson['success']) {
      return true;
    } else {
      return false;
    }
  }

  static Future<Map<String, dynamic>> loginOrRegister(
      username, password, email, context) async {
    var response = await client.post(
      Uri.parse('$uri/loginorregister'),
      headers: {
        "content-type": "application/x-www-form-urlencoded",
      },
      body: {
        'username': username,
        'password': password,
        'email': email,
        'name': username,
      },
    );
    Map<String, dynamic> resJson = json.decode(response.body);
    user_class.Users newUser = user_class.Users.fromJson(resJson['data']);
    await userController.changeLoggedInUser(newUser);
    log(response.body);
    return resJson;
  }

  static Future<bool> createProductWImage(String name, String desc,
      int categoryId, int sellerId, String price, String imagePath) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$uri/productwimage'));
    request.files.add(
      await http.MultipartFile.fromPath('image', imagePath),
    );
    request.fields.addAll(<String, String>{
      'name': name,
      'description': desc,
      'category_id': categoryId.toString(),
      'seller_id': sellerId.toString(),
      'price': price.toString(),
    });
    var response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> editProduct(int id, String name, String desc,
      int categoryId, int sellerId, String price) async {
    var response = await client.put(
      Uri.parse('$uri/product/$id'),
      headers: {
        "content-type": "application/x-www-form-urlencoded",
      },
      body: {
        'name': name,
        'description': desc,
        'category_id': categoryId.toString(),
        'seller_id': sellerId.toString(),
        'price': price.toString(),
      },
    );
    Map<String, dynamic> resJson = json.decode(response.body);
    log(response.body);
    if (resJson['success']) {
      return true;
    } else {
      return false;
    }
  }
}
