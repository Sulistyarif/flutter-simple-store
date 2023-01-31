import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_store/models/products.dart';
import 'package:simple_store/screens/product_detail_page.dart';
import 'package:simple_store/utlis/utils.dart';

import '../api/client_api.dart';

class ItemProduct extends StatefulWidget {
  final Products item;
  const ItemProduct({super.key, required this.item});

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ProductDetailPage(
              item: widget.item,
              onAction: () {
                // ClientApi.getAllProducts();
                // ClientApi.getMyProducts();
              },
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              SizedBox(
                child: widget.item.image != null
                    ? Image.network(
                        '${ClientApi.uri}/${widget.item.image}',
                        height: MediaQuery.of(context).size.width / 7,
                        width: MediaQuery.of(context).size.width / 7,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.grey,
                                ),
                                Text(
                                  'No pict',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.grey,
                            ),
                            Text(
                              'No pict',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.item.name!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.item.description!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Rp${Utils.formatDecimal(widget.item.price!)}',
                      style: const TextStyle(),
                    ),
                    Text(
                      widget.item.seller.toString(),
                      textAlign: TextAlign.end,
                      style: const TextStyle(color: Colors.blue, fontSize: 12),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
