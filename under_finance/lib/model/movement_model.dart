import 'package:under_finance/model/category_model.dart';
import 'package:under_finance/model/type_movement_model.dart';

class MovementModel {
  MovementModel(
      {required this.id,
      required this.description,
      required this.amount,
      required this.category,
      required this.categoryMovementModel,
      required this.date});

  int id;
  String description;
  int amount;
  CategoryModel category;
  TypeMovementModel categoryMovementModel;
  DateTime date;
}
