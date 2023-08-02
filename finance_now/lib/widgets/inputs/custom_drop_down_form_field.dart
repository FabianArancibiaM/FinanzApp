import 'package:finance_now/bloc/forms/movement/movement_cubit.dart';
import 'package:finance_now/shared/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomDropDownFormField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final FormStatus? stateForm;
  final Function(SelectorObject)? onChange;
  final String? Function(String?)? validator;
  final List<SelectorObject> list;

  const CustomDropDownFormField({
    Key? key,
    this.label,
    this.hint,
    this.errorMessage,
    this.onChange,
    this.validator,
    required this.list,
    this.stateForm,
  }) : super(key: key);

  @override
  State<CustomDropDownFormField> createState() =>
      _CustomDropDownFormFieldState();
}

class _CustomDropDownFormFieldState extends State<CustomDropDownFormField> {
  SelectorObject selectedCategory =
      SelectorObject(key: '', value: 'Seleccionar');
  final TextEditingController _dateController = TextEditingController();

  List<DropdownMenuItem<SelectorObject>>? listToShow;
  @override
  void initState() {
    super.initState();
    selectedCategory = widget.list.first;
    _dateController.text = 'Seleccionar';
  }

  void _selectDate(SelectorObject object) {
    setState(() {
      selectedCategory = object;
      _dateController.text = object.value;
    });
    widget.onChange?.call(object);
  }

  List<DropdownMenuItem<SelectorObject>> _createList() {
    return widget.list
        .map(
          (value) => DropdownMenuItem<SelectorObject>(
            value: value,
            child: Text(value.value,
                style: value.value != 'Seleccionar'
                    ? null
                    : TextStyle(color: Colors.grey)),
            enabled: value.value != 'Seleccionar',
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
    );

    if (widget.stateForm == FormStatus.reload) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setState(() {
          selectedCategory = SelectorObject(key: '', value: 'Seleccionar');
        });
      });
    }

    return Row(
      children: [
        if (widget.label != null && widget.list.isNotEmpty)
          Expanded(
            child: DropdownButtonFormField<SelectorObject>(
              value: widget.list.firstWhere(
                  (element) => element.value == selectedCategory.value),
              itemHeight:
                  50, // Ajusta la altura de cada elemento del menú desplegable
              items: _createList(),
              onChanged: (value) {
                if (value == null || value.value == 'Seleccionar') return;
                _selectDate(SelectorObject(key: value.key, value: value.value));
              },
              decoration: InputDecoration(
                label: widget.label != null
                    ? Text(widget.label!)
                    : Text(selectedCategory.value),
                enabledBorder: border,
                focusedBorder: border.copyWith(
                  borderSide: BorderSide(color: colors.primary),
                ),
                errorBorder: border.copyWith(
                  borderSide: BorderSide(color: Colors.red.shade800),
                ),
                focusedErrorBorder: border.copyWith(
                  borderSide: BorderSide(color: Colors.red.shade800),
                ),
                isDense: true,
                hintText: widget.hint,
                errorText: widget.errorMessage,
                prefixIcon: Icon(Icons.bar_chart_sharp, color: colors.primary),
                // icon: Icon(Icons.calendar_today, color: colors.primary),
              ),
            ),
          ),
      ],
    );
  }
}
