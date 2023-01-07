import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  TextEditingController controllerSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product list'),
      ),
      body: Column(
        children: [
          TextField(
            controller: controllerSearch,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "Product name..",
                fillColor: Colors.white70),
          ),
          ListView.builder(
            itemBuilder: (context, index) {
              return const Text('data');
            },
            itemCount: 10,
          ),
        ],
      ),
    );
  }
}
