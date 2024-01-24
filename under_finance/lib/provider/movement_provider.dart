import 'package:flutter/material.dart';
import 'package:under_finance/model/movement_model.dart';

class MovementProvider extends ChangeNotifier {
  List<MovementModel> list = [];

  Future<List<MovementModel>?> getAllMovements() async {
    notifyListeners();
    return list;
  }
}
