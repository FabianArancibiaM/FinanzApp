import 'package:finance_now/models/parametric_data_model.dart';
import 'package:finance_now/services/firebase_services.dart';
import 'package:flutter/material.dart';

class ParametricDataProvider extends ChangeNotifier {
  String documentID = '';
  List<ParametricDataModel> listCategory = [];
  List<ParametricDataModel> listTypeMovement = [];

  Future<bool> getParametricData(String docID) async {
    documentID = docID;
    var data = await getParametricDataFirebase();
    if (data == null) return false;
    var lstCategory = data.data()['Categorias'];
    lstCategory.forEach((element) {
      listCategory.add(ParametricDataModel(
          code: element['codigo'], value: element['valor']));
    });
    var lstTypeMovements = data.data()['tipos_movimientos'];
    lstTypeMovements.forEach((element) {
      listTypeMovement.add(ParametricDataModel(
          code: element['codigo'], value: element['valor']));
    });
    notifyListeners();
    return true;
  }
}
