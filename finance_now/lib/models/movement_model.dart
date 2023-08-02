class MovementModel {
  MovementModel(
      {required this.details,
      required this.codCategory,
      required this.codMovementType,
      required this.date,
      required this.value});
  DateTime date;
  String details;
  String codCategory;
  String codMovementType;
  int value;
}
