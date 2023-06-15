import 'package:intl/intl.dart';

class FinancialDataModel {
  FinancialDataModel(
      {this.id,
      required this.details,
      required this.period,
      required this.ammount,
      required this.type,
      required this.category,
      required this.dateOperation});

  int? id;
  String details;
  int ammount;
  int period;
  String type;
  String category;
  String dateOperation;

  String ammountFormatCLP() {
    return NumberFormat.currency(
      locale: 'es_CL',
      symbol: '',
      decimalDigits: 0,
    ).format(ammount);
  }

  DateTime getDateOperationFormat() {
    // String dateString = '17-05-2023';
    return DateTime.parse(
        '${dateOperation.substring(6)}-${dateOperation.substring(3, 5)}-${dateOperation.substring(0, 2)}');
  }

  factory FinancialDataModel.fromJson(Map<String, dynamic> json) =>
      FinancialDataModel(
        id: json["id"],
        period: json["periodNumber"],
        details: json["details"],
        ammount: json["ammount"],
        type: json["type"],
        category: json["category"],
        dateOperation: json["dateOperation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "periodNumber": period,
        "details": details,
        "ammount": ammount,
        "type": type,
        "category": category,
        "dateOperation": dateOperation
      };
}
