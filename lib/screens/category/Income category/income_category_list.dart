import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_wise/provider/category_provider.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    return Consumer<CategoryProvider>(
      builder: (ctx, provider, child) {
        return GridView.builder(
          itemCount: provider.incomeCategoryProvider.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
              childAspectRatio: 1.6),
          itemBuilder: (context, index) {
            final category = provider.incomeCategoryProvider[index];
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                elevation: 5,
                margin: const EdgeInsets.all(10),
                color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          category.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: ((context) {
                                  return AlertDialog(
                                    content: const Text(
                                      'Do you want to Delete',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: (() {
                                              Navigator.of(context).pop();
                                            }),
                                            child: const Text(
                                              'No',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: (() {
                                              provider
                                                  .deleteCategory(category.id);
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
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
