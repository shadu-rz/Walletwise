

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:wallet_app/provider/transaction_provider.dart';
// import '../../models/category/category_model.dart';
// import '../../models/transactions/transaction_model.dart';

// ValueNotifier expenseTotal = ValueNotifier(0.0);

// ValueNotifier incomeTotal = ValueNotifier(0.0);

// ValueNotifier totalBalance = ValueNotifier(0.0);
// void incomeAndExpense() {
//   incomeTotal.value = 0;
//   expenseTotal.value = 0;
//   totalBalance.value = 0;
//   final List<TransactionModel> value =
//       Provider.of<TransactionProvider>(context, listen: false)
//           .transactionListProvider;
//   // TransactionDB.instance.transactionListNotifier.value;

//   for (int i = 0; i < value.length; i++) {
//     if (CategoryType.income == value[i].category.type) {
//       incomeTotal.value = incomeTotal.value + value[i].amount;
//     } else {
//       expenseTotal.value = expenseTotal.value + value[i].amount;
//     }
//   }
//   totalBalance.value = incomeTotal.value - expenseTotal.value;
// }
