import 'package:flutter/material.dart';
import 'package:simple_store/models/products.dart';

class ProviderProduct extends ChangeNotifier {
  List<Products> products = [];

  List<Products> get productList => products;

  void setProductList(List<Products> param) {
    products = param;
    notifyListeners();
  }
}
