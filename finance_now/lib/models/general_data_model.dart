class GeneralDataModel {
  GeneralDataModel(
      {required this.payment, required this.dicount, required this.subDetails});

  int payment;
  int dicount;
  List<Map<String, int>> subDetails;
}
