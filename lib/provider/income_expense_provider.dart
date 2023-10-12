// import 'package:flutter/material.dart';
// import 'package:wallet_wise/models/category/category_model.dart';
// import 'package:wallet_wise/models/transactions/transaction_model.dart';

// class IncomeAndExpense extends ChangeNotifier {
//   double incomeTotal = 0;
//   double expenseTotal = 0;
//   double totalBalance = 0;
//   void incomeAndExpense(List<TransactionModel> listOfModal) {
    
//     final List<TransactionModel> value = listOfModal;

//     for (int i = 0; i < value.length; i++) {
//       if (CategoryType.income == value[i].category.type) {
//         incomeTotal = incomeTotal + value[i].amount;
//       } else {
//         expenseTotal = expenseTotal + value[i].amount;
//       }
//     }
//     totalBalance = incomeTotal - expenseTotal;

//     notifyListeners();
//   }
// }
