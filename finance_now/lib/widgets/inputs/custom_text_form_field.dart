import 'package:finance_now/bloc/forms/movement/movement_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomTextFormField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final FormStatus? stateForm;

  const CustomTextFormField(
      {Key? key,
      this.label,
      this.hint,
      this.errorMessage,
      this.onChange,
      this.validator,
      this.stateForm})
      : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(borderRadius: BorderRadius.circular(40));

    if (widget.stateForm == FormStatus.reload) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _controller.text = '';
        });
      });
    }
    return TextFormField(
      // obscureText: true, // Ofusca texto
      onChanged: widget.onChange,
      validator: widget.validator,
      controller: _controller,
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
