// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:wallet_wise/models/transactions/transaction_model.dart';

// const transactionDbName = 'transaction-db';

// abstract class TransactionDbFunctions {
  // Future<void> addTransaction(TransactionModel obj);
  // Future<List<TransactionModel>> getAllTransactions();
  // Future<void> deleteTransaction(String id);
  // Future<void> deleteAllTransaction();
  // Future<void> editTransaction(TransactionModel value);
  // Future<void> refreshTransAndCat();
// }

// class TransactionDB implements TransactionDbFunctions {
//   TransactionDB._internal();

//   static TransactionDB instance = TransactionDB._internal();

//   factory TransactionDB() {
//     return instance;
//   }

  // ValueNotifier<List<TransactionModel>> transactionListNotifier =
  //     ValueNotifier([]);
  // ValueNotifier<List<TransactionModel>> transactionFilterNotifier =
  //     ValueNotifier([]);

  // @override
  // Future<void> addTransaction(TransactionModel obj) async {
  //   final db = await Hive.openBox<TransactionModel>(transactionDbName);
  //   await db.put(obj.id, obj);
  // }

  // Future<void> refreshUiTransaction() async {
  //   final list = await getAllTransactions();

  //   list.sort((first, second) => second.date.compareTo(first.date));

  //   transactionListNotifier.value.clear();
  //   transactionFilterNotifier.value.clear();

  //   transactionListNotifier.value.addAll(list);
  //   transactionFilterNotifier.value.addAll(list);

  //   // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  //   transactionListNotifier.notifyListeners();
  //   // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  //   transactionFilterNotifier.notifyListeners();

  //   incomeAndExpense();
  // }

  // @override
  // Future<List<TransactionModel>> getAllTransactions() async {
  //   final db = await Hive.openBox<TransactionModel>(transactionDbName);
  //   return db.values.toList();
  // }

  // @override
  // Future<void> deleteTransaction(String id) async {
  //   final db = await Hive.openBox<TransactionModel>(transactionDbName);
  //   await db.delete(id);
  //   refreshUiTransaction();
  // }

  // @override
  // Future<void> editTransaction(TransactionModel value) async {
  //   final db = await Hive.openBox<TransactionModel>(transactionDbName);
  //   await db.put(value.id, value);
  //   refreshUiTransaction();
  // }

  // @override
  // Future<void> deleteAllTransaction() async {
  //   final db = await Hive.openBox<TransactionModel>(transactionDbName);
  //   await db.clear();
  //   await db.close();
  //   refreshUiTransaction();
  // }
  // @override
  // Future<void> refreshTransAndCat(context) async {
  //   // CategoryDB.instance.refreshUiCategory();
  //   Provider.of<CategoryProvider>(context,listen: false).refreshUiCategory();

  //   TransactionDB.instance.refresh();
  // }
// }
