import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wallet_wise/models/category/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  final categoryDbName = 'category-database';

  List<CategoryModel> incomeCategoryProvider = [];
  List<CategoryModel> expenseCategoryProvider = [];

  Future<List<CategoryModel>> getCategories() async {
    final categoryDB = await Hive.openBox<CategoryModel>(categoryDbName);
    notifyListeners();
    return categoryDB.values.toList();
  }

  Future<void> refreshUiCategory() async {
    final allCategeries = await getCategories();
    incomeCategoryProvider.clear();
    expenseCategoryProvider.clear();
    await Future.forEach(
      allCategeries,
      (
        CategoryModel category,
      ) {
        if (category.type == CategoryType.income) {
          incomeCategoryProvider.add(category);
        } else {
          expenseCategoryProvider.add(category);
        }
      },
    );
    notifyListeners();
  }

  Future<void> insertCategory(CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>(categoryDbName);
    await categoryDB.put(value.id, value);
    refreshUiCategory();
  }

  Future<void> deleteCategory(String categoryID) async {
    final categoryDB = await Hive.openBox<CategoryModel>(categoryDbName);
    await categoryDB.delete(categoryID);
    refreshUiCategory();
  }

  Future<void> editCategory(CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>(categoryDbName);
    await categoryDB.put(value.id, value);
    refreshUiCategory();
    notifyListeners();
  }

  Future<void> deleteAllCategory() async {
    final categoryDB = await Hive.openBox<CategoryModel>(categoryDbName);
    await categoryDB.clear();
    await categoryDB.close();
    refreshUiCategory();
    notifyListeners();
  }

  // void tabcontroller(tabController) {
  //   tabController = TabController(length: 2, vsync: this);
  //   refreshUiCategory();
  // }
}
