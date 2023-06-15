import 'package:finance_now/bloc/forms/movement/movement_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

class CustomDateFormField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final FormStatus? stateForm;
  final Function(DateTime)? onChange;
  final String? Function(String?)? validator;

  const CustomDateFormField(
      {Key? key,
      this.label,
      this.hint,
      this.errorMessage,
      this.onChange,
      this.validator,
      this.stateForm})
      : super(key: key);

  @override
  State<CustomDateFormField> createState() => _CustomDateFormFieldState();
}

class _CustomDateFormFieldState extends State<CustomDateFormField> {
  DateTime? selectedDate;
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = '';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      // locale: const Locale('es', 'ES'), // Español
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor:
                Colors.blue, // Color del encabezado del selector de fecha
            // accentColor: Colors.blue, // Color del texto seleccionado
            colorScheme: const ColorScheme.light(
              primary: Colors.blue, // Color del botón "OK"
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary, // Estilo del botón "OK"
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
      widget.onChange!(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
        // borderSide: BorderSide(color: colors.primary),
        borderRadius: BorderRadius.circular(40));

    if (widget.stateForm == FormStatus.reload) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setState(() {
          selectedDate = null;
          _dateController.text = '';
        });
      });
    }
    return TextFormField(
      // obscureText: true, // Ofusca texto
      controller: _dateController,
      // onChanged: widget.onChange,
      readOnly: true,
      validator: widget.validator,
      onTap: () => _selectDate(context),
      decoration: InputDecoration(
          enabledBorder: border,
          focusedBorder:
              border.copyWith(borderSide: BorderSide(color: colors.primary)),
          errorBorder: border.copyWith(
              borderSide: BorderSide(color: Colors.red.shade800)),
          focusedErrorBorder: border.copyWith(
              borderSide: BorderSide(color: Colors.red.shade800)),
          isDense: true,
          label: widget.label != null ? Text(widget.label!) : null,
          hintText: widget.hint,
          errorText: widget.errorMessage,
          prefixIcon: Icon(Icons.calendar_month, color: colors.primary),
          icon: Icon(Icons.wordpress_sharp, color: colors.primary)),
    );
  }
}
