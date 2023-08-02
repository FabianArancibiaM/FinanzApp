import 'package:finance_now/bloc/forms/movement/movement_cubit.dart';
import 'package:finance_now/providers/parametric_data_provider.dart';
import 'package:finance_now/providers/records_provider.dart';
import 'package:finance_now/shared/index.dart';
import 'package:finance_now/widgets/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class FormMovementScreen extends StatefulWidget {
  const FormMovementScreen({Key? key}) : super(key: key);

  @override
  State<FormMovementScreen> createState() => _FormMovementScreenState();
}

class _FormMovementScreenState extends State<FormMovementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario'),
      ),
      body: BlocProvider(
          create: (context) => MovementCubit(),
          child: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: Center(
                  child: Column(
                    children: [
                      const Icon(
                        Icons.monetization_on_rounded,
                        color: Colors.amber,
                        size: 58,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _RegisterForm()
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  _RegisterForm({Key? key}) : super(key: key);

  late List<SelectorObject> listType = [];

  late List<SelectorObject> listCategory = [];

  @override
  Widget build(BuildContext context) {
    final parametric = Provider.of<ParametricDataProvider>(context);
    final recordsProvider = Provider.of<RecordsProvider>(context);
    listCategory = [];
    for (var e in parametric.listCategory) {
      listCategory.add(SelectorObject(key: e.code, value: e.value));
    }
    listType = [];
    for (var e in parametric.listTypeMovement) {
      listType.add(SelectorObject(key: e.code, value: e.value));
    }
    final colors = Theme.of(context).colorScheme.primary;
    final movementCubi = context.watch<MovementCubit>();

    final description = movementCubi.state.description;
    final amount = movementCubi.state.amount;
    final date = movementCubi.state.date;
    final category = movementCubi.state.category;
    final type = movementCubi.state.type;

    var spinnerShow = false;

    return Stack(
      children: [
        Visibility(
          visible: movementCubi.state.formStatus == FormStatus.validating ||
              spinnerShow,
          child: Center(
              child: Container(
            margin: const EdgeInsets.only(top: 250),
            child: CircularProgressIndicator(
              strokeWidth: 8,
              valueColor: AlwaysStoppedAnimation<Color>(colors),
            ),
          )),
        ),
        Form(
            child: Column(
          children: [
            CustomTextFormField(
              label: 'Descripción',
              onChange: movementCubi.descriptionChange,
              errorMessage: description.errorMessages,
              stateForm: movementCubi.state.formStatus,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomNumbreFormField(
              label: 'Monto',
              onChange: movementCubi.amountChange,
              errorMessage: amount.errorMessages,
              stateForm: movementCubi.state.formStatus,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomDateFormField(
              label: 'fecha',
              onChange: movementCubi.dateChange,
              errorMessage: date.errorMessages,
              stateForm: movementCubi.state.formStatus,
            ),
            const SizedBox(
              height: 20,
            ),
            if (listCategory.isNotEmpty)
              CustomDropDownFormField(
                label: 'Cateoria',
                list: listCategory,
                onChange: movementCubi.categoryChange,
                errorMessage: category.errorMessages,
                stateForm: movementCubi.state.formStatus,
              ),
            const SizedBox(
              height: 20,
            ),
            if (listCategory.isNotEmpty)
              CustomDropDownFormField(
                label: 'Tipo',
                list: listType,
                onChange: movementCubi.typeChange,
                errorMessage: type.errorMessages,
                stateForm: movementCubi.state.formStatus,
              ),
            const SizedBox(
              height: 20,
            ),
            FilledButton.tonalIcon(
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.grey),
                ),
                onPressed: () {
                  if (movementCubi.state.formStatus == FormStatus.validating) {
                    return;
                  }
                  movementCubi.onSubmit(recordsProvider).then((value) {
                    if (value) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Modal(
                              onPress: () {
                                movementCubi
                                    .formStatusChange(FormStatus.validating);
                                Future.delayed(const Duration(seconds: 1), () {
                                  movementCubi
                                      .formStatusChange(FormStatus.posting);
                                });
                              },
                              title: 'Guardado con exito',
                            );
                          });
                    }
                  }).catchError((error) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Modal(
                            onPress: () {},
                            title: 'Error al guardar',
                          );
                        });
                  });
                },
                icon: const Icon(Icons.savings_rounded),
                label: Text(
                  'Guardar movimiento',
                  style: movementCubi.state.formStatus == FormStatus.validating
                      ? const TextStyle(color: Colors.grey)
                      : null,
                )),
            const SizedBox(
              height: 10,
            ),
            FilledButton.tonalIcon(
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(horizontal: 75, vertical: 10),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.grey),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'financial-sumary');
                },
                icon: const Icon(Icons.incomplete_circle_rounded),
                label: const Text('Ver resumen')),
            const SizedBox(
              height: 10,
            ),
            FilledButton.tonalIcon(
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.grey),
                ),
                onPressed: () async {
                  spinnerShow = true;
                },
                icon: const Icon(Icons.restore),
                label: const Text('Nuevo periodo')),
          ],
        ))
      ],
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
