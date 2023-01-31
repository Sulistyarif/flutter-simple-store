import 'package:get/get.dart';
import 'package:simple_store/models/categories.dart';

class CategoryController extends GetxController {
  final categoryList = <Categories>[].obs;

  void setCategoryList(List<Categories> param) {
    categoryList(param);
  }

  Categories getCategoriesDetail(String catName) {
    Categories res =
        categoryList.firstWhere((element) => element.name == catName);
    return res;
  }
}
