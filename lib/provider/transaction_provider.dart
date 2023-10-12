import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wallet_wise/models/category/category_model.dart';
import 'package:wallet_wise/models/transactions/transaction_model.dart';

class TransactionProvider extends ChangeNotifier {
  double incomeTotal = 0;
  double expenseTotal = 0;
  double totalBalance = 0;

  String showCategory = ("All");
  var transactionDbName = 'transaction-db';
  String dateFilterTitle = "All";

  List<TransactionModel> transactionListProvider = [];
  List<TransactionModel> transactionFilterProvider = [];

  List<TransactionModel> overviewGraphTransactions = [];
  List<TransactionModel> overviewTransactions = [];

  set setOverviewTransactions(List<TransactionModel> overViewNewList) {
    overviewTransactions = overViewNewList;

    notifyListeners();
  }

  set setOverViewGraphTransactions(
      List<TransactionModel> overViewGraphTransactionsNewList) {
    overviewGraphTransactions = overViewGraphTransactionsNewList;

    notifyListeners();
  }

  set setTransactionListNotifier(List<TransactionModel> transactionNewList) {
    transactionListProvider = transactionNewList;
    notifyListeners();
  }

  set setDateFilterTitle(String dateFilterTitleNewList) {
    dateFilterTitle = dateFilterTitleNewList;

    notifyListeners();
  }

  set setShowCategory(String overShowCategory) {
    showCategory = overShowCategory;
    notifyListeners();
  }

  // -------------------------DATABASE FUNCTIONS--------------------------------

  Future<void> addTransaction(TransactionModel obj) async {
    final db = await Hive.openBox<TransactionModel>(transactionDbName);
    await db.put(obj.id, obj);
    refreshUiTransaction();
    notifyListeners();
  }

  Future<void> refreshUiTransaction() async {
    final list = await getAllTransactions();

    list.sort((first, second) => second.date.compareTo(first.date));

    transactionListProvider.clear();
    transactionFilterProvider.clear();

    transactionListProvider.addAll(list);
    transactionFilterProvider.addAll(list);
    incomeAndExpense();

    notifyListeners();
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await Hive.openBox<TransactionModel>(transactionDbName);
    return db.values.toList();
  }

  Future<void> deleteTransaction(TransactionModel obj) async {
    final db = await Hive.openBox<TransactionModel>(transactionDbName);
    await db.delete(obj.id);
    notifyListeners();
    refreshUiTransaction();
  }

  Future<void> editTransaction(TransactionModel value) async {
    final db = await Hive.openBox<TransactionModel>(transactionDbName);
    await db.put(value.id, value);

    refreshUiTransaction();
  }

  Future<void> deleteAllTransaction() async {
    final db = await Hive.openBox<TransactionModel>(transactionDbName);
    await db.clear();
    await db.close();
    notifyListeners();
    refreshUiTransaction();
  }

  void incomeAndExpense() {
    incomeTotal = 0;
    expenseTotal = 0;
    totalBalance = 0;
    final List<TransactionModel> value = transactionListProvider;

    for (int i = 0; i < value.length; i++) {
      if (CategoryType.income == value[i].category.type) {
        incomeTotal = incomeTotal + value[i].amount;
      } else {
        expenseTotal = expenseTotal + value[i].amount;
      }
    }
    totalBalance = incomeTotal - expenseTotal;

    notifyListeners();
  }
}
