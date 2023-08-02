import 'package:finance_now/models/general_data_model.dart';
import 'package:finance_now/models/movement_model.dart';
import 'package:finance_now/models/period_model.dart';
import 'package:finance_now/models/total_model.dart';
import 'package:finance_now/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        var listM = [];
        element['movimientos'].forEach((el) {
          List<String> dateComponents = el['fecha'].split('/');
          int day = int.parse(dateComponents[0]);
          int month = int.parse(dateComponents[1]);
          int year = int.parse(dateComponents[2]);

          DateTime dateTime = DateTime(year, month, day);

          listM.add(MovementModel(
              codCategory: el['codCategoria'],
              codMovementType: el['codTipoMovimiento'],
              value: el['valor'],
              date: dateTime,
              details: el['detalle']));
        });
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

  Future addMovement(MovementModel model) async {
    try {
      var record = await getRecordsDataFirebase();
      if (record == null) return false;
      var periodos = record.data()['periodos'];
      if (periodos == null) return false;
      var index = periodos.length - 1;
      var listMov = periodos[index]['movimientos'];
      var abonoP = periodos[index]['totales']['abonos'];
      var descP = periodos[index]['totales']['descuentos'];
      listMov ??= [];
      listMov.add({
        'detalle': model.details,
        'fecha': DateFormat('dd/MM/yyyy').format(model.date),
        'codCategoria': model.codCategory,
        'codTipoMovimiento': model.codMovementType,
        'valor': model.value
      });
      if (model.codMovementType == "ABO") {
        abonoP = abonoP + model.value;
      } else {
        descP = descP + model.value;
      }
      var allList = periodos;
      allList[0] = {
        'num_periodo': record.data()['ultimo_periodo'],
        'movimientos': listMov,
        'totales': {'abonos': abonoP, 'descuentos': descP}
      };
      await record.reference.update({"periodos": allList});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
