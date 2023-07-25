import 'package:finance_now/models/movement_model.dart';
import 'package:finance_now/models/total_model.dart';

class PeriodModel {
  PeriodModel(
      {required this.movements,
      required this.total,
      required this.numberPeriod});

  List<MovementModel> movements;
  int numberPeriod;
  TotalModel total;
}
