import 'package:flutter/material.dart';
import 'package:under_finance/model/type_movement_model.dart';

class TypeMovementProvider extends ChangeNotifier {
  List<TypeMovementModel> list = [];

  Future getAllTypeMovement() async {
    list = [];
    list.add(TypeMovementModel(id: 1, name: 'Abono'));
    list.add(TypeMovementModel(id: 2, name: 'Descuento'));
    notifyListeners();
  }
}
