import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_wise/models/category/category_model.dart';
import 'package:wallet_wise/provider/category_provider.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showEditCategoryPopup(BuildContext context) async {
  final nameEditingController = TextEditingController();

  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text(
            'Edit category',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: nameEditingController,
                    decoration: const InputDecoration(
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Category name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () async {
                  final name = nameEditingController.text;
                  if (name.isEmpty) {
                    return;
                  }
                  // final type = selectedCategoryNotifier.value;

                  // final category = CategoryModel(
                  //   id: DateTime.now().microsecondsSinceEpoch.toString(),
                  //   name: name,
                  //   type: type,
                  // );
                  // await CategoryDB.instance.refreshUiCategory();
                  Provider.of<CategoryProvider>(context, listen: false)
                      .refreshUiCategory();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
                child: const Text('Add'),
              ),
            )
          ],
        );
      });
}
