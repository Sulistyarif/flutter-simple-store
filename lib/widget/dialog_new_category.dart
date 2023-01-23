import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_store/api/client_api.dart';

class DialogNewCategory extends StatefulWidget {
  final Function() onAdded;
  const DialogNewCategory({super.key, required this.onAdded});

  @override
  State<DialogNewCategory> createState() => _DialogNewCategoryState();
}

class _DialogNewCategoryState extends State<DialogNewCategory> {
  TextEditingController controllerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add new category',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: controllerName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "category name",
                  fillColor: Colors.white70),
            ),
            ElevatedButton(
              onPressed: () async {
                bool res = await ClientApi.createCategory(controllerName.text);
                if (res) {
                  widget.onAdded();
                  Get.back();
                } else {
                  Get.snackbar('Simple Store', 'New category added.');
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
