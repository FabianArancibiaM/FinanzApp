import 'package:formz/formz.dart';

// Define input validation errors
enum AmountError { empty, notNumber, min }

// Extend FormzInput and provide the input type and error type.
class AmountInput extends FormzInput<String, AmountError> {
  // Call super.pure to represent an unmodified form input.
  const AmountInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const AmountInput.dirty(String value) : super.dirty(value);

  String? get errorMessages {
    if (isValid || isPure) return null;
    if (displayError == AmountError.empty) return 'El campo es requerido';
    if (displayError == AmountError.notNumber) return 'Debe ingresar un número';
    if (displayError == AmountError.min) return 'El monto debe ser mayor a 0';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  AmountError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return AmountError.empty;
    if (num.tryParse(value) == null) return AmountError.notNumber;
    if (num.parse(value) <= 0) return AmountError.min;
    return null;
  }
}
