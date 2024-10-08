import 'package:formz/formz.dart';

// Define input validation errors
enum DropDownError { empty }

// Extend FormzInput and provide the input type and error type.
class DropDown extends FormzInput<String, DropDownError> {
  // Call super.pure to represent an unmodified form input.
  const DropDown.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const DropDown.dirty(String value) : super.dirty(value);

  String? get errorMessages {
    if (isValid || isPure) return null;
    if (displayError == DropDownError.empty) return 'El campo es requerido';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  DropDownError? validator(String value) {
    if (value.isEmpty) return DropDownError.empty;
    return null;
  }
}
