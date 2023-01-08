import 'package:flutter/material.dart';
import 'package:simple_store/models/categories.dart';

class ProviderCategory extends ChangeNotifier {
  List<Categories> categoryList = [];

  List<Categories> get categories => categoryList;

  void setCategoryList(List<Categories> param) {
    categoryList = param;
    notifyListeners();
  }
}
