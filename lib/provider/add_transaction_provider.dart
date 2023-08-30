import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallet_app/models/category/category_model.dart';

class AddTransactionProvider extends ChangeNotifier {
  
  DateTime selectedDate = DateTime.now();
  CategoryType? selectedCategoryType = CategoryType.income;
  CategoryModel? selectedCategoryModel;
  String? categoryID;
  int value = 0;

  incomeChoiceChip() {
    value = 0;
    selectedCategoryType = CategoryType.income;
    categoryID = null;
    notifyListeners();
  }

  expenseChoiceChip() {
    value = 1;
    selectedCategoryType = CategoryType.expense;
    categoryID = null;
    notifyListeners();
  }

  dateSelection(DateTime? selectedDateTemp) {
    if (selectedDateTemp == null) {
      selectedDate = DateTime.now();
      notifyListeners();
    } else {
      selectedDate = selectedDateTemp;
      notifyListeners();
    }
    notifyListeners();
  }
}

