import 'package:get/get.dart';
import 'package:simple_store/models/products.dart';

class ProductController extends GetxController {
  final allProductList = <Products>[].obs;

  setAllProduct(List<Products> param) {
    allProductList.value = param;
  }
}