import 'package:finance_v3/models/movement_model.dart';
import 'package:flutter/material.dart';

class MovementProvider extends ChangeNotifier {
  List<MovementModel> list = [];

  Future<List<MovementModel>> getListMovement() async {
    return Future.delayed(const Duration(seconds: 1), () => list);
  }

  Future<bool> addListMovement(MovementModel model) async {
    list.add(model);
    return Future.delayed(const Duration(seconds: 1), () => true);
  }
}
