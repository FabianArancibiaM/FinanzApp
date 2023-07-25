import 'package:finance_now/models/general_data_model.dart';
import 'package:finance_now/models/period_model.dart';
import 'package:finance_now/models/total_model.dart';
import 'package:finance_now/services/firebase_services.dart';
import 'package:flutter/material.dart';

class RecordsProvider extends ChangeNotifier {
  String documentID = '';
  late GeneralDataModel generalData;
  late List<PeriodModel> periodList = [];

  Future<bool> getRecords(String docID) async {
    try {
      documentID = docID;
      var record = await getRecordsDataFirebase();
      if (record == null) return false;
      var listSub = record.data()['datos_generales']['sub_detalle'];
      List<Map<String, int>> newList = [];
      listSub.forEach((element) {
        var key = element.keys.first;
        var value = element[key];
        newList.add({key: value});
      });
      generalData = GeneralDataModel(
          dicount: record.data()['datos_generales']['descuento'],
          payment: record.data()['datos_generales']['abono'],
          subDetails: newList);
      record.data()['periodos'].forEach((element) {
        periodList.add(PeriodModel(
            movements: [],
            total: TotalModel(
                expense: element['totales']['descuentos'],
                payment: element['totales']['abonos']),
            numberPeriod: element['num_periodo']));
      });

      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
