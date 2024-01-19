import 'package:finance_now/models/financial_data_model.dart';
import 'package:finance_now/shared/index.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TableSummary extends StatefulWidget {
  const TableSummary({super.key});

  @override
  _TableSummaryState createState() => _TableSummaryState();
}

class _TableSummaryState extends State<TableSummary> {
  List<SelectorObject> listType = InfoConst().listType;

  List<SelectorObject> listCategory = InfoConst().listCategory;

  List<Map<String, dynamic>> tableData = [];

  // void deleteRow(int index, FinancialMovement financialProvider) async {
  //   await financialProvider.deleteById(index);
  //   setState(() {
  //     tableData.removeWhere((element) => element['id'] == index);
  //   });
  // }

  void editRow(int index) {
    setState(() {
      tableData[index]['nombre'] = 'Editado';
    });
  }

  // void addDataList(FinancialMovement financialProvider) {
  //   for (var element in financialProvider.list) {
  //     if (tableData.isEmpty) {
  //       addToList(element);
  //     } else {
  //       var first = tableData.where((dta) => dta['id'] == element.id);
  //       if (first.isEmpty) {
  //         addToList(element);
  //       }
  //     }
  //   }
  // }

  void addToList(FinancialDataModel element) {
    var category = listCategory.where((data) => data.key == element.category);
    var type = listType.where((data) => data.key == element.type);

    tableData.add({
      'id': element.id,
      'detalle': element.details,
      'monto': element.ammount.toString(),
      'fecha': element.dateOperation,
      'tipo': type.first.value,
      'categoria': category.first.value,
    });
  }

  @override
  Widget build(BuildContext context) {
    // final financialProvider = Provider.of<FinancialMovement>(context);
    // addDataList(financialProvider);
    if (tableData.isEmpty) {
      return Container();
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: const EdgeInsets.only(bottom: 20),
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Detalle')),
              DataColumn(label: Text('Monto')),
              DataColumn(label: Text('Fecha')),
              DataColumn(label: Text('Tipo')),
              DataColumn(label: Text('Categoria')),
              DataColumn(label: Text('Acción')),
            ],
            rows: tableData.map(
              (data) {
                final rowColor = data['tipo'] == 'Abono'
                    ? Color.fromARGB(255, 92, 231, 97)
                    : Color.fromARGB(255, 255, 102, 91);
                return DataRow(
                  cells: [
                    DataCell(Text(data['detalle'])),
                    DataCell(Text(data['monto'])),
                    DataCell(Text(data['fecha'])),
                    DataCell(Text(data['tipo'])),
                    DataCell(Text(data['categoria'])),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                              icon: const Icon(Icons.delete), onPressed: () {}
                              // deleteRow(data['id'], financialProvider),
                              ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => editRow(tableData.indexOf(data)),
                          ),
                        ],
                      ),
                    ),
                  ],
                  color: MaterialStateColor.resolveWith((states) => rowColor),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
