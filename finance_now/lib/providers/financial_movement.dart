import 'package:finance_now/models/financial_data_model.dart';
import 'package:finance_now/providers/db_provider.dart';
import 'package:flutter/material.dart';

class FinancialMovement extends ChangeNotifier {
  List<FinancialDataModel> list = [];
  int period = 0;

  FinancialMovement();

  void setPeriod() {
    period = period + 1;
  }

  Future<FinancialDataModel> newMovement(FinancialDataModel model) async {
    final id = await DBProvider.db.nuevoMovement(model);
    model.id = id;
    list.add(model);
    notifyListeners();
    return model;
  }

  Future loadDataUser() async {
    var rest = await DBProvider.db.getFinancialMovementWithMaxPeriodNumber();
    period = rest == null ? 0 : rest.period;
    if (rest != null) {
      await listToPeriod();
    }
    notifyListeners();
    return;
  }

  Future<List<FinancialDataModel>> listToPeriod() async {
    final lst = await DBProvider.db.getDataToPeriod(period);
    lst.sort((a, b) =>
        b.getDateOperationFormat().compareTo(a.getDateOperationFormat()));
    list = lst;
    notifyListeners();
    return lst;
  }

  updateMovement(FinancialDataModel model) async {
    await DBProvider.db.updateMovement(model);
    var old = list.where((element) => element.id == model.id).first;
    old = model;
    notifyListeners();
  }

  Future getAllMovement() async {
    final all = await DBProvider.db.getAllFinancialData();
    list = [...all];
    notifyListeners();
    return;
  }

  deleteById(int id) async {
    await DBProvider.db.deleteMovement(id);
    list.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  List<FinancialDataModel> getAllMovementMonth() {
    final now = DateTime.now();
    final currentMonth = now.month;
    return list.toList();
  }
}
