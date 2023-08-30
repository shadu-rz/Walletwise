import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/models/category/category_model.dart';
import 'package:wallet_app/provider/category_provider.dart';
import 'package:wallet_app/provider/transaction_provider.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showAddCategoryPopup(BuildContext context) async {
  final nameEditingController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text(
            'Add category',
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
                    maxLength: 15,
                    controller: nameEditingController,
                    decoration: const InputDecoration(
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Category name',
                      counterText: "",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RadioButton(
                    title: 'income',
                    type: CategoryType.income,
                  ),
                  RadioButton(
                    title: 'expense',
                    type: CategoryType.expense,
                  ),
                ],
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
                  final type = selectedCategoryNotifier.value;

                  final category = CategoryModel(
                    id: DateTime.now().microsecondsSinceEpoch.toString(),
                    name: name.toUpperCase(),
                    type: type,
                  );

                  await Provider.of<CategoryProvider>(context, listen: false)
                      .insertCategory(category);

                  // ignore: use_build_context_synchronously
                  context.read<CategoryProvider>().refreshUiCategory();
                  // ignore: use_build_context_synchronously
                  context.read<TransactionProvider>().refreshUiTransaction();

                  Navigator.of(context).pop();
                },
                child: const Text('Add'),
              ),
            )
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategoryNotifier,
            builder: (
              BuildContext ctx,
              CategoryType newCategory,
              Widget? _,
            ) {
              return Radio<CategoryType>(
                value: type,
                groupValue: newCategory,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  selectedCategoryNotifier.value = value;
                  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                  selectedCategoryNotifier.notifyListeners();
                },
              );
            }),
        Text(title),
      ],
    );
  }
}
