import 'package:finance_v3/models/type_movement_model.dart';
import 'package:flutter/material.dart';

class TypeMovementProvider extends ChangeNotifier {
  List<TypeMovementModel> list = [];

  Future<List<TypeMovementModel>> getListTypeMovement() async {
    list = [];
    list.add(TypeMovementModel(code: 000, description: "Seleccionar"));
    list.add(TypeMovementModel(code: 001, description: "Sueldo"));
    list.add(TypeMovementModel(code: 002, description: "Inversion"));
    list.add(TypeMovementModel(code: 003, description: "Extras"));
    list.add(TypeMovementModel(code: 004, description: "Tarjeta"));
    return Future.delayed(const Duration(seconds: 1), () => list);
  }
}
