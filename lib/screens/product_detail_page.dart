import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_store/api/client_api.dart';
import 'package:simple_store/controller/user_controller.dart';
import 'package:simple_store/models/products.dart';
import 'package:simple_store/utlis/utils.dart';
import 'package:simple_store/widget/custom_rounded_button.dart';
import 'package:simple_store/widget/dialog_yes_no.dart';

class ProductDetailPage extends StatefulWidget {
  final Products item;
  final Function() onAction;
  const ProductDetailPage({
    super.key,
    required this.item,
    required this.onAction,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isMyProduct = false;
  final userController = Get.find<UserController>();

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Image.network(
              'https://picsum.photos/200',
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(height: 20),
            Text(
              'Rp ${Utils.formatDecimal(widget.item.price!)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.item.name!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Description',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              widget.item.description!,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            SizedBox(
              child: isMyProduct
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomRoundedButton(
                          warna: Colors.green,
                          onTap: () {},
                          buttonTitle: 'Edit product',
                        ),
                        CustomRoundedButton(
                          warna: Colors.red,
                          onTap: () {
                            _onDeleteProduct();
                          },
                          buttonTitle: 'Delete product',
                        ),
                      ],
                    )
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }

  void _loadData() {
    bool isLoggedIn = userController.isLoggedIn.value;

    if (isLoggedIn) {
      String? sellerName = userController.user.value.username;
      if (sellerName == widget.item.seller) {
        isMyProduct = true;
      }
    }
    setState(() {});
  }

  void _onDeleteProduct() {
    Get.dialog(
      DialogYesNo(
          onYes: () async {
            bool res = await ClientApi.deleteProduct(context, widget.item.id);
            if (res) {
              _onAction();
            }
          },
          title: 'Are you want to delete this product?'),
    );
  }

  void _onAction() {
    ClientApi.getAllProducts();
    ClientApi.getMyProducts();
    Get.back();
    Get.back();
    Get.back();
  }
}
