import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:up_finance/bloc/movement/movement_cubit.dart';
import 'package:intl/intl.dart';
import 'package:up_finance/model/movement_model.dart';
import 'package:up_finance/model/type_movement_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:up_finance/providers/provider.dart';

class AddMovementScreen extends StatefulWidget {
  const AddMovementScreen({super.key});

  @override
  State<AddMovementScreen> createState() => _AddMovementScreenState();
}

class _AddMovementScreenState extends State<AddMovementScreen> {
  Future<void> _selectDate(BuildContext context, MovementCubit cubit) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      cubit.dateChange(DateFormat('dd/MM/yyyy').format(pickedDate));
      _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }

  final TextEditingController _dateController = TextEditingController();
  late List<TypeMovementModel> listTypeMovementModel = [];
  TypeMovementModel? dropdownValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => MovementCubit(),
        child: const SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Center(child: FormCustom()),
            ),
          ),
        ),
      ),
    );
  }
}

class FormCustom extends StatefulWidget {
  const FormCustom({super.key, this.onChange});
  final Function(bool)? onChange;

  @override
  State<FormCustom> createState() => _FormCustomState();
}

class _FormCustomState extends State<FormCustom> {
  Future<void> _selectDate(BuildContext context, MovementCubit cubit) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      locale: const Locale('es', 'ES'),
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      cubit.dateChange(DateFormat('dd/MM/yyyy').format(pickedDate));
      _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _controllerNumber = TextEditingController();
  late List<TypeMovementModel> listTypeMovementModel = [];
  TypeMovementModel? dropdownValue;
  final NumberFormat _numberFormat = NumberFormat('#,##0', 'en_US');
  late bool spinnerShow = true;

  Color setColor = Colors.white;

  @override
  void initState() {
    super.initState();

    final categoryProvider =
        Provider.of<TypeMovementProvider>(context, listen: false);
    setState(() {
      spinnerShow = true;
    });
    getListTypeMovement(categoryProvider);
  }

  Future<void> getListTypeMovement(
      TypeMovementProvider categoryProvider) async {
    listTypeMovementModel = await categoryProvider.getListTypeMovement();
    setState(() {
      dropdownValue = listTypeMovementModel.first;
      spinnerShow = false;
    });
  }

  void changeColor(Color colorSelect) {
    setState(() {
      setColor = colorSelect;
    });
  }

  String _formatNumber(String value) {
    if (value.isEmpty) return '';

    // Eliminar caracteres no numéricos
    value = value.replaceAll(RegExp('[^0-9]'), '');
    if (value.isEmpty) return '';
    if (value.length > 10) {
      value = value.substring(0, 10);
    }
    // Formatear el número con separación de miles
    final number = int.parse(value);
    final formatNew = _numberFormat.format(number).replaceAll(',', '.');
    return '\$ $formatNew';
  }

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).colorScheme;

    final movementProvider =
        Provider.of<MovementProvider>(context, listen: false);
    final movementCubi = context.watch<MovementCubit>();
    final description = movementCubi.state.description;
    final amount = movementCubi.state.amount;
    final dateMoviment = movementCubi.state.date;
    final typeMovement = movementCubi.state.typeMovement;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Stack(
        children: [
          Visibility(
            visible: spinnerShow,
            child: Center(
                child: Container(
              margin: const EdgeInsets.only(top: 250),
              child: const CircularProgressIndicator(
                strokeWidth: 8,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            )),
          ),
          if (!spinnerShow)
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Tipo de Movimiento',
                    style: TextStyle(fontSize: 34),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: customTheme.primaryFixed,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  20), // Esquina superior izquierda redondeada
                              bottomLeft: Radius.circular(
                                  20), // Esquina inferior izquierda redondeada
                              topRight: Radius.circular(
                                  0), // Esquina superior derecha recta
                              bottomRight: Radius.circular(
                                  0), // Esquina inferior derecha recta
                            ),
                          ),
                        ),
                        onPressed: () {
                          changeColor(customTheme.primaryFixed);
                        },
                        child: Text('Ingreso'),
                      ),
                      // Botón derecho
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: customTheme.secondaryFixed,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(
                                  20), // Esquina superior derecha redondeada
                              bottomRight: Radius.circular(
                                  20), // Esquina inferior derecha redondeada
                              topLeft: Radius.circular(
                                  0), // Esquina superior izquierda recta
                              bottomLeft: Radius.circular(
                                  0), // Esquina inferior izquierda recta
                            ),
                          ),
                        ),
                        onPressed: () {
                          changeColor(customTheme.secondaryFixed);
                        },
                        child: Text('Gasto'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _controllerNumber,
                    onChanged: (value) {
                      final formattedValue = _formatNumber(value);
                      _controllerNumber.value = TextEditingValue(
                        text: formattedValue,
                        selection: TextSelection.collapsed(
                            offset: formattedValue.length),
                      );
                      movementCubi.amountChange(formattedValue);
                    },
                    decoration: InputDecoration(
                      label: Text('Monto'),
                      errorText: amount.errorMessages,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Categoria',
                        style: TextStyle(fontSize: 16),
                      ),
                      DropdownButtonExample(
                        listTypeMovementModel: listTypeMovementModel,
                        dropdownValue: dropdownValue,
                        onChanged: (newValue) {
                          movementCubi
                              .typeMovementChange(newValue!.description);
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _dateController,
                    readOnly: true,
                    onTap: () => _selectDate(context, movementCubi),
                    decoration: InputDecoration(
                      label: const Text('Fecha'),
                      errorText: dateMoviment.errorMessages != null
                          ? dateMoviment.errorMessages
                          : null, // Asegura que solo muestra el error si existe
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    onChanged: movementCubi.descriptionChange,
                    decoration: InputDecoration(
                        errorText: description.errorMessages,
                        label: Text('Descripción')),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: setColor,
                    ),
                    onPressed: movementCubi.state.formStatus ==
                                FormStatus.invalid ||
                            setColor == Colors.white
                        ? null
                        : () async {
                            if (movementCubi.state.formStatus ==
                                FormStatus.invalid) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Modal(
                                      onPress: () {},
                                      title: 'Debe completar todos los campos',
                                    );
                                  });
                              return;
                            }
                            setState(() {
                              spinnerShow = true;
                            });
                            var amount = _controllerNumber.value.text
                                .replaceAll(RegExp('[^0-9]'), '');
                            var typeMovementModel = TypeMovementModel(
                                code: dropdownValue!.code,
                                description: dropdownValue!.description);
                            await movementProvider.addListMovement(
                                MovementModel(
                                    amount: int.parse(amount),
                                    date: _dateController.value.text,
                                    description: description.value,
                                    typeMovementModel: typeMovementModel));
                            var list = await movementProvider.getListMovement();

                            setState(() {
                              spinnerShow = false;
                            });
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Modal(
                                    onPress: () {
                                      Navigator.pushNamed(context, 'menu');
                                    },
                                    title: 'Guardado Correctamente',
                                  );
                                });
                          },
                    child: Text(
                      'Agregar Movimiento',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, 'home');
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black, // Color del texto del enlace
                        decoration: TextDecoration.underline, // Subrayado
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}

class DropdownButtonExample extends StatelessWidget {
  const DropdownButtonExample({
    super.key,
    required this.listTypeMovementModel,
    required this.dropdownValue,
    required this.onChanged,
  });

  final List<TypeMovementModel> listTypeMovementModel;
  final TypeMovementModel? dropdownValue;
  final ValueChanged<TypeMovementModel?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: DropdownButton<TypeMovementModel>(
        value: dropdownValue,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (TypeMovementModel? newValue) {
          if (listTypeMovementModel.indexOf(newValue!) != 0) {
            onChanged(newValue); // Solo permite cambiar si no es el primer ítem
          }
        },
        items: listTypeMovementModel
            .asMap()
            .entries
            .map<DropdownMenuItem<TypeMovementModel>>((entry) {
          int index = entry.key;
          TypeMovementModel value = entry.value;

          return DropdownMenuItem<TypeMovementModel>(
            value: value,
            enabled: index != 0, // Deshabilita el primer ítem
            child: Text(
              value.description,
              style: TextStyle(
                fontSize: 16,
                color: index == 0
                    ? Colors.grey
                    : Colors.black, // Opción gris para ítems deshabilitados
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class Modal extends StatelessWidget {
  final String title;
  final void Function() onPress;
  const Modal({Key? key, required this.onPress, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme.secondary;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 100),
      child: AlertDialog(
        title: Text(title, textAlign: TextAlign.center),
        actions: [
          CupertinoButton(
            color: colors,
            onPressed: () {
              Navigator.of(context).pop();
              onPress();
            },
            child: const Row(children: [
              Icon(Icons.check_circle),
              SizedBox(
                width: 5,
              ),
              Text('Continuar')
            ]),
          )
        ],
      ),
    );
  }
}
