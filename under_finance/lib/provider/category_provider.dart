import 'package:flutter/material.dart';
import 'package:under_finance/model/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> list = [];

  Future<List<CategoryModel>?> getAllTypeMovement() async {
    list.add(CategoryModel(id: 1, name: 'Ahorro e Inversiones'));
    list.add(CategoryModel(id: 2, name: 'Transferencia'));
    list.add(CategoryModel(id: 3, name: 'Sueldo y Abonos'));
    list.add(CategoryModel(id: 4, name: 'Extras'));
    list.add(CategoryModel(id: 5, name: 'Suscripciones'));
    list.add(CategoryModel(id: 6, name: 'Gastos ensuales'));
    list.add(CategoryModel(id: 7, name: 'Cuota'));
    list.add(CategoryModel(id: 8, name: 'Tarjetas'));
    notifyListeners();
    return list;
  }
}
