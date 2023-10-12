import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wallet_wise/models/category/category_model.dart';
import 'package:wallet_wise/models/transactions/transaction_model.dart';
import 'package:wallet_wise/provider/transaction_provider.dart';
import 'package:wallet_wise/screens/transaction/view%20all%20transaction/slidable.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
        builder: (BuildContext context, newList, Widget? _) {
      //here we building the list using displayList list
      var displayList = [];

      //here if the showCategory notifier value is income (which will be changed based on the changes in popMenuItem )

      if (newList.showCategory == "Income") {
        //here i am creating an empty list for the transaction,
        //so i can pick the income only through the where function

        List<TransactionModel> incomeTransactionList = [];

        incomeTransactionList = newList.overviewTransactions
            .where((element) => element.type == CategoryType.income)
            .toList();
        //assigning the list into displayList which is the list i declared above
        displayList = incomeTransactionList;
      } else if (newList.showCategory == "Expense") {
        List<TransactionModel> incomeTransactionList = [];

        incomeTransactionList = newList.overviewTransactions
            .where((element) => element.type == CategoryType.expense)
            .toList();
        displayList = incomeTransactionList;
      } else {
        displayList = newList.overviewTransactions;
      }
      return Provider.of<TransactionProvider>(context, listen: false)
              .transactionListProvider
              .isEmpty
          ? SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Lottie.asset(
                        'assets/lotties/animation_ln4pztav.json',
                        width: 200,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                      const Text(
                        'No data found',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              itemCount: displayList.length,
              itemBuilder: (context, index) {
                final transaction = displayList[index];

                return SlidableTransaction(transaction: transaction);
              });
    });
  }
}
