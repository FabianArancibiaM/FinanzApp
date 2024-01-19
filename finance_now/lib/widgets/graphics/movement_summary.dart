import 'package:finance_now/models/financial_data_model.dart';
import 'package:finance_now/shared/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MovementSummary extends StatefulWidget {
  const MovementSummary({Key? key}) : super(key: key);

  @override
  State<MovementSummary> createState() => _MovementSummaryState();
}

class _MovementSummaryState extends State<MovementSummary> {
  List<Map<String, dynamic>> tableData = [];
  List<SelectorObject> listType = InfoConst().listType;
  List<SelectorObject> listCategory = InfoConst().listCategory;

  // void deleteRow(int index, FinancialMovement financialProvider) async {
  //   // await financialProvider.deleteById(index);
  //   // await financialProvider.getAllMovement();
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
  //   if (financialProvider.list.isEmpty) {
  //     tableData = [];
  //     return;
  //   }
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
    final amount = element.ammountFormatCLP();
    tableData.add({
      'id': element.id,
      'date': element.dateOperation,
      'title': element.details.isNotEmpty ? element.details : 'Desconocido',
      'details': '\$$amount',
      'icon': element.type == 'A'
          ? FontAwesomeIcons.coins
          : FontAwesomeIcons.cartShopping,
      'clasification': element.type,
      'type': type.first.value,
      'category': category.first.value,
    });
  }

  @override
  Widget build(BuildContext context) {
    // final financialProvider = Provider.of<FinancialMovement>(context);
    // addDataList(financialProvider);

    return Container(
      height: 400,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(4, 6),
                blurRadius: 10),
          ],
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(colors: <Color>[
            Color.fromARGB(255, 218, 207, 250),
            Color.fromARGB(255, 192, 230, 193)
          ])),
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          const Text('Movimientos',
              style: TextStyle(color: Colors.black, fontSize: 20)),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              height: 350,
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: tableData.length,
                  itemBuilder: (context, index) {
                    final itm = tableData[index];
                    return ItemMovement(
                        description: itm['details'],
                        title: itm['title'],
                        id: itm['id'],
                        icon: itm['icon'],
                        type: itm['clasification'],
                        onPress: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Modal(
                                    amount: itm['details'],
                                    title: itm['title'],
                                    id: itm['id'],
                                    icon: itm['icon'],
                                    type: itm['type'],
                                    date: itm['date'],
                                    category: itm['category'],
                                    onPressDelete: () {}
                                    // deleteRow(itm['id'], financialProvider),
                                    );
                              });
                        });
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ItemMovement extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String type;
  final int id;
  final void Function() onPress;

  const ItemMovement(
      {Key? key,
      required this.icon,
      required this.title,
      required this.description,
      required this.id,
      required this.type,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color selected = type == 'A' ? Colors.blue : Colors.red;
    return Container(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: GestureDetector(
        onTap: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const SizedBox(height: 140, width: 30),
            FaIcon(icon, color: selected, size: 40),
            const SizedBox(width: 20),
            Expanded(
                child: ListTile(
              title:
                  Text(title, style: TextStyle(color: selected, fontSize: 18)),
              subtitle: Text(description,
                  style: TextStyle(color: selected, fontSize: 15)),
            )),
            FaIcon(FontAwesomeIcons.chevronRight, color: selected),
            // const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}

class Modal extends StatelessWidget {
  final IconData icon;
  final String title;
  final String amount;
  final String type;
  final String category;
  final String date;
  final int id;
  final void Function() onPressDelete;
  const Modal(
      {Key? key,
      required this.title,
      required this.icon,
      required this.amount,
      required this.type,
      required this.id,
      required this.date,
      required this.category,
      required this.onPressDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 100),
      child: AlertDialog(
        title: Text(title, textAlign: TextAlign.center),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Table(
              border: TableBorder.symmetric(
                inside: BorderSide(width: 0.1, color: Colors.white),
              ),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    TableCell(child: Text('Monto')),
                    TableCell(child: Text('$amount')),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(child: Text('Fecha')),
                    TableCell(child: Text('$date')),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(child: Text('Tipo')),
                    TableCell(child: Text('$type')),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(child: Text('Categoria')),
                    TableCell(child: Text('$category')),
                  ],
                )
              ],
            ),
          ],
        ),
        actions: [
          CupertinoButton(
            color: Colors.red.shade300,
            onPressed: () {
              Navigator.of(context).pop();
              onPressDelete();
            },
            child: const Icon(Icons.delete),
          ),
          // CupertinoButton(

          //   color: Colors.blue.shade300,
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //     Navigator.pushNamed(context, 'form', arguments: id);
          //   },
          //   child: const Icon(Icons.edit),
          // )
        ],
      ),
    );
  }
}
