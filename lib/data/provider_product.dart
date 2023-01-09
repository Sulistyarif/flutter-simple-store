import 'package:flutter/material.dart';
import 'package:simple_store/models/products.dart';

class ProviderProduct extends ChangeNotifier {
  List<Products> products = [];
  List<Products> myProducts = [];

  List<Products> get productList => products;
  List<Products> get myProductList => myProducts;

  void setProductList(List<Products> param) {
    products = param;
    notifyListeners();
  }

  void setMyProductList(List<Products> param) {
    myProducts = param;
    notifyListeners();
  }
}
