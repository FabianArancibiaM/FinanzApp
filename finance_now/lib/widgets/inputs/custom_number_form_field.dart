import 'package:finance_now/bloc/forms/movement/movement_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CustomNumbreFormField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final FormStatus? stateForm;

  const CustomNumbreFormField(
      {Key? key,
      this.label,
      this.hint,
      this.errorMessage,
      this.onChange,
      this.validator,
      this.stateForm})
      : super(key: key);

  @override
  State<CustomNumbreFormField> createState() => _CustomNumbreFormFieldState();
}

class _CustomNumbreFormFieldState extends State<CustomNumbreFormField> {
  final TextEditingController _controller = TextEditingController();
  final NumberFormat _numberFormat = NumberFormat('#,##0', 'en_US');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatNumber(String value) {
    if (value.isEmpty) return '';

    // Eliminar caracteres no numéricos
    value = value.replaceAll(RegExp('[^0-9]'), '');

    // Formatear el número con separación de miles
    final number = int.parse(value);
    final formatNew = _numberFormat.format(number).replaceAll(',', '.');
    return '\$ $formatNew';
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
          _controller.text = '';
        });
      });
    }

    return TextFormField(
      // obscureText: true, // Ofusca texto
      // onChanged: widget.onChange,
      controller: _controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (value) {
        widget.onChange!(value);
        final formattedValue = _formatNumber(value);
        _controller.value = TextEditingValue(
          text: formattedValue,
          selection: TextSelection.collapsed(offset: formattedValue.length),
        );
      },
      validator: widget.validator,
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder:
            border.copyWith(borderSide: BorderSide(color: colors.primary)),
        errorBorder:
            border.copyWith(borderSide: BorderSide(color: Colors.red.shade800)),
        focusedErrorBorder:
            border.copyWith(borderSide: BorderSide(color: Colors.red.shade800)),
        isDense: true,
        label: widget.label != null ? Text(widget.label!) : null,
        hintText: widget.hint,
        errorText: widget.errorMessage,
        prefixIcon: Icon(Icons.edit_document, color: colors.primary),
        // icon: Icon(Icons.wordpress_sharp, color: colors.primary)
      ),
    );
  }
}
