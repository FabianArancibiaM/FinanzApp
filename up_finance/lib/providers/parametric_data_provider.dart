import 'package:flutter/material.dart';
import 'package:up_finance/services/firebase_services.dart';

class ParametricDataProvider extends ChangeNotifier {
  String documentID = '';

  Future<bool> getParametricData(String docID) async {
    documentID = docID;
    // var data = await getParametricDataFirebase();
    // if (data == null) return false;
    // var lstCategory = data.data();
    notifyListeners();
    return true;
  }
}
