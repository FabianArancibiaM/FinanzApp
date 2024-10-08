import 'package:up_finance/model/type_movement_model.dart';

class MovementModel {
  MovementModel(
      {required this.description,
      required this.amount,
      required this.date,
      required this.typeMovementModel});
  String description;
  int amount;
  String date;
  TypeMovementModel typeMovementModel;
}
