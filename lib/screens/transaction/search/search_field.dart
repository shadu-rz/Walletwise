import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:wallet_app/provider/transaction_provider.dart';

class SearchField extends StatelessWidget {
  SearchField({super.key});
  final TextEditingController _searchQueryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextField(
            controller: _searchQueryController,
            onChanged: (query) {
              searchResult(query, context);
              
            },
            decoration: InputDecoration(
              hintText: 'Search.. ',
              border: InputBorder.none,
              icon: const Icon(
                Icons.search,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  _searchQueryController.clear();
                  context.read<TransactionProvider>().overviewTransactions =
                      Provider.of<TransactionProvider>(context, listen: false)
                          .transactionListProvider;
                  context.read<TransactionProvider>().notifyListeners();
                },
                icon: const Icon(
                  Icons.close,
                  // color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  searchResult(String query, BuildContext context) {
    if (query.isEmpty) {
      Provider.of<TransactionProvider>(context, listen: false)
              .overviewTransactions =
          Provider.of<TransactionProvider>(context, listen: false)
              .transactionListProvider;
      context.read<TransactionProvider>().notifyListeners();
    } else {
      Provider.of<TransactionProvider>(context, listen: false)
              .overviewTransactions =
          Provider.of<TransactionProvider>(context, listen: false)
              .overviewTransactions
              .where((element) =>
                  element.category.name.toLowerCase().contains(query) ||
                  element.amount.toString().contains(query) ||
                  element.purpose.toLowerCase().contains(query))
              .toList();
      Provider.of<TransactionProvider>(context, listen: false)
          .notifyListeners();
    }
  }
}
