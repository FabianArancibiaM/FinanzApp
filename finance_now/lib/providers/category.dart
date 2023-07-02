import 'package:finance_now/models/category_data_model.dart';
import 'package:finance_now/providers/db_category.dart';
import 'package:flutter/material.dart';

class Category extends ChangeNotifier {
  List<CategoryDataModel> list = [];

  Category();

  Future<CategoryDataModel> newMovement(CategoryDataModel model) async {
    final id = await DBCategory.db.newCategory(model);
    model.id = id;
    list.add(model);
    notifyListeners();
    return model;
  }

  Future getAllMovement() async {
    final all = await DBCategory.db.getAllCategoryData();
    list = [...all];
    notifyListeners();
    return;
  }
}
