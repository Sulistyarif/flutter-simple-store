import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_store/api/client_api.dart';
import 'package:simple_store/data/provider_user.dart';
import 'package:simple_store/models/products.dart';
import 'package:simple_store/utlis/utils.dart';
import 'package:simple_store/widget/custom_rounded_button.dart';
import 'package:simple_store/widget/dialog_yes_no.dart';

class ProductDetailPage extends StatefulWidget {
  final Products item;
  const ProductDetailPage({
    super.key,
    required this.item,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isMyProduct = false;

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
    bool isLoggedIn =
        Provider.of<ProviderUser>(context, listen: false).getStatusLogin();

    if (isLoggedIn) {
      String sellerName =
          Provider.of<ProviderUser>(context, listen: false).user!.username!;
      if (sellerName == widget.item.seller) {
        isMyProduct = true;
      }
    }
    setState(() {});
  }

  void _onDeleteProduct() {
    // delete product
    showDialog(
      context: context,
      builder: (context) {
        return DialogYesNo(
          onYes: () async {
            bool res = await ClientApi.deleteProduct(context, widget.item.id);
            if (res) {
              ClientApi.getMyProducts(
                context,
                Provider.of<ProviderUser>(context, listen: false).user!.id!,
              );
            }
            Navigator.of(context).pop();
          },
          title: 'Are you wan to delete this product?',
        );
      },
    );
  }
}