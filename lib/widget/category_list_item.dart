import 'package:flutter/material.dart';
import 'package:simple_store/models/categories.dart';

class CategoryListItem extends StatelessWidget {
  final Categories item;
  final Function(Categories) onPicked;
  const CategoryListItem(
      {super.key, required this.item, required this.onPicked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPicked(item);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Row(
            children: [
              const Icon(
                Icons.shopping_basket_outlined,
                size: 30,
              ),
              const SizedBox(width: 10),
              Text(
                item.name!,
                style: const TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
