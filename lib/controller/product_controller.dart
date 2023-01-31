import 'package:get/get.dart';
import 'package:simple_store/models/products.dart';

class ProductController extends GetxController {
  final allProductList = <Products>[].obs;
  final myProductList = <Products>[].obs;
  final searchProductList = <Products>[].obs;

  setAllProduct(List<Products> param) {
    allProductList(param);
  }

  setAllMyProduct(List<Products> param) {
    myProductList(param);
  }

  setResultProduct(List<Products> param) {
    searchProductList(param);
  }
}
