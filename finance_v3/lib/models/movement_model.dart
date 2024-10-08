import 'package:finance_v3/models/type_movement_model.dart';

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
