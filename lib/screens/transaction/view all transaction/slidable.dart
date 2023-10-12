import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wallet_wise/models/category/category_model.dart';
import 'package:wallet_wise/models/transactions/transaction_model.dart';
import 'package:wallet_wise/provider/transaction_provider.dart';
import 'package:wallet_wise/screens/transaction/edit/edit_trans.dart';

class SlidableTransaction extends StatelessWidget {
  const SlidableTransaction({
    super.key,
    required this.transaction,
  });

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          label: 'edit',
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          onPressed: ((context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) {
                  return EditTransaction(
                    obj: transaction,
                  );
                }),
              ),
            );
          }),
          icon: Icons.edit,
        ),
        SlidableAction(
          label: 'delete',
          backgroundColor: Colors.transparent,
          onPressed: ((context) {
            showDialog(
                context: context,
                builder: ((context) {
                  return AlertDialog(
                    content: const Text(
                      'Do you want to Delete.',
                    ),
                    actions: [
                      TextButton(
                          onPressed: (() {
                            // TransactionDB.instance
                            //     .deleteTransaction(transaction);
                            Provider.of<TransactionProvider>(context,
                                    listen: false)
                                .deleteTransaction(transaction);
                            Navigator.of(context).pop();
                          }),
                          child: const Text(
                            'yes',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          )),
                      TextButton(
                        onPressed: (() {
                          Navigator.of(context).pop();
                        }),
                        child: const Text(
                          'no',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  );
                }));
          }),
          icon: Icons.delete,
          foregroundColor: Colors.red,
        ),
      ]),
      child: Card(
        color:
            transaction.type == CategoryType.income ? Colors.green : Colors.red,
        elevation: 3,
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Text(
              parseDateTime(transaction.date),
              textAlign: TextAlign.center,
            ),
          ),
          title: Text(
            transaction.category.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            transaction.purpose,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          trailing: Text(
            '₹${transaction.amount}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  String parseDateTime(DateTime date) {
    final dateFormatted = DateFormat.MMMd().format(date);
    //using split we split the date into two parts
    final splitedDate = dateFormatted.split(' ');
    //here _splitedDate.last is second word that is month name and other one is the first word
    return "${splitedDate.last}\n${splitedDate.first} ";
  }
}
