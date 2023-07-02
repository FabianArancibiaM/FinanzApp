class CategoryDataModel {
  CategoryDataModel({this.id, required this.details});

  int? id;
  String details;

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) =>
      CategoryDataModel(
        id: json["id"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "details": details,
      };
}
