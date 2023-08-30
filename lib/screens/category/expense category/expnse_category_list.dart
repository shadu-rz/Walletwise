import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/provider/category_provider.dart';
import 'package:wallet_app/screens/category/Edit%20Category/edit_category_popup.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (ctx, provider, _) {
        return ListView.separated(
          itemBuilder: (context, index) {
            final category = provider.expenseCategoryProvider[index];
            return Slidable(
              key: Key(category.id),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (ctx) {
                      showEditCategoryPopup(context);
                    },
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                  SlidableAction(
                    onPressed: (ctx) {
                      showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                            content: const Text(
                              'Do you want to Delete',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: (() {
                                      Navigator.of(context).pop();
                                    }),
                                    child: const Text(
                                      'No',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: (() {
                                      // CategoryDB.instance
                                      //     .deleteCategory(category.id);
                                      provider.deleteCategory(category.id);
                                      Navigator.of(context).pop();
                                    }),
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                      );
                    },
                    icon: Icons.delete,
                    label: 'Delete',
                    foregroundColor: Colors.red,
                  ),
                ],
              ),
              child: Card(
                elevation: 5,
                margin: const EdgeInsets.all(10),
                color: Colors.red,
                child: ListTile(
                  title: Text(
                    category.name,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 0,
            );
          },
          itemCount: provider.expenseCategoryProvider.length,
        );
      },
    );
  }
}
