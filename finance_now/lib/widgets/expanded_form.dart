import 'package:finance_now/models/financial_data_model.dart';
import 'package:finance_now/providers/financial_movement.dart';
import 'package:finance_now/shared/index.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class ExpandedForm extends StatefulWidget {
  const ExpandedForm({Key? key}) : super(key: key);

  @override
  State<ExpandedForm> createState() => _ExpandedFormState();
}

class _ExpandedFormState extends State<ExpandedForm> {
  final TextEditingController _numeroController = TextEditingController();

  final TextEditingController _textoController = TextEditingController();

  final NumberFormat _numberFormat = NumberFormat.currency(
    locale: 'es_CL',
    symbol: '',
    decimalDigits: 0,
  );

  @override
  void dispose() {
    _numeroController.dispose();
    _textoController.dispose();
    super.dispose();
  }

  List<SelectorObject> listType = InfoConst().listType;

  List<SelectorObject> listCategory = InfoConst().listCategory;

  String details = '';
  int ammount = 0;
  SelectorObject selectedType = SelectorObject(key: '', value: '');
  SelectorObject selectedCategory = SelectorObject(key: '', value: '');
  DateTime? selectedDate;

  List<String> savedData = [];
  DateTime date = DateTime.now();

  void _showDemoPicker({
    required BuildContext context,
    required Widget child,
  }) {
    final themeData = CupertinoTheme.of(context);
    final dialogBody = CupertinoTheme(
      data: themeData,
      child: child,
    );

    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => dialogBody,
    );
  }

  @override
  Widget build(BuildContext context) {
    final financialProvider = Provider.of<FinancialMovement>(context);
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ingrese los datos:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              // onChanged: (value) {
              //   setState(() {
              //     details = value;
              //   });
              // },
              controller: _textoController,
              decoration: const InputDecoration(
                labelText: 'Detalle',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _numeroController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(10),
                // _NumberTextInputFormatter(),
              ],
              onChanged: (value) {
                setState(() {
                  ammount =
                      value.isEmpty ? 0 : int.parse(value.replaceAll('.', ''));
                });
              },
              decoration: InputDecoration(
                labelText: 'Monto',
                prefixText: '',
                suffixText:
                    '\$${_numberFormat.format(double.parse(_numeroController.text.isEmpty ? '0' : _numeroController.text.replaceAll('.', '')))}',
              ),
            ),
            const SizedBox(height: 10),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  _showDemoPicker(
                    context: context,
                    child: _BottomPicker(
                      child: CupertinoDatePicker(
                        dateOrder: DatePickerDateOrder.dmy,
                        backgroundColor: CupertinoColors.systemBackground
                            .resolveFrom(context),
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: date,
                        onDateTimeChanged: (newDateTime) {
                          setState(() {
                            date = newDateTime;
                          });
                        },
                      ),
                    ),
                  );
                },
                child: _Menu(
                  children: [
                    const Text('Fecha movimiento',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 46, 45, 45),
                        )),
                    Text(
                      DateFormat('dd/MM/yyyy').format(date),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<SelectorObject>(
              value: selectedType.key.isNotEmpty ? selectedType : null,
              onChanged: (value) {
                setState(() {
                  selectedType = value!;
                });
              },
              items: listType
                  .map(
                    (value) => DropdownMenuItem<SelectorObject>(
                      value: value,
                      child: Text(value.value),
                    ),
                  )
                  .toList(),
              decoration: const InputDecoration(
                labelText: 'Tipo',
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<SelectorObject>(
              value: selectedCategory.key.isNotEmpty ? selectedCategory : null,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              items: listCategory
                  .map(
                    (value) => DropdownMenuItem<SelectorObject>(
                      value: value,
                      child: Text(value.value),
                    ),
                  )
                  .toList(),
              decoration: const InputDecoration(
                labelText: 'Categoria',
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    // financialProvider.newMovement(FinancialDataModel(
                    //     details: details,
                    //     ammount: ammount,
                    //     type: selectedType.key,
                    //     category: selectedCategory.key,
                    //     dateOperation: DateFormat('dd/MM/yyyy').format(date)));
                    details = '';
                    ammount = 0;
                    date = DateTime.now();
                    selectedType = SelectorObject(key: '', value: '');
                    selectedCategory = SelectorObject(key: '', value: '');
                  });
                },
                child: const Text('Guardar'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BottomPicker extends StatelessWidget {
  const _BottomPicker({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 216,
      padding: const EdgeInsets.only(top: 6),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: DefaultTextStyle(
        style: TextStyle(
          color: CupertinoColors.label.resolveFrom(context),
          fontSize: 22,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: child,
          ),
        ),
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  const _Menu({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: CupertinoColors.inactiveGray, width: 0),
          bottom: BorderSide(color: CupertinoColors.inactiveGray, width: 0),
        ),
      ),
      height: 44,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}
