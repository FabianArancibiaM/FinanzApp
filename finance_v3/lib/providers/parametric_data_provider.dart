import 'package:finance_v3/services/firebase_services.dart';
import 'package:flutter/material.dart';

class ParametricDataProvider extends ChangeNotifier {
  String documentID = '';

  Future<bool> getParametricData(String docID) async {
    documentID = docID;
    var data = await getParametricDataFirebase();
    if (data == null) return false;
    print(data.data());
    var lstCategory = data.data()['Categorias'];

    notifyListeners();
    return true;
  }
}
