import 'package:formz/formz.dart';

// Define input validation errors
enum DateError { empty }

// Extend FormzInput and provide the input type and error type.
class DateInput extends FormzInput<dynamic, DateError> {
  // Call super.pure to represent an unmodified form input.
  const DateInput.pure() : super.pure(null);

  // Call super.dirty to represent a modified form input.
  const DateInput.dirty(dynamic value) : super.dirty(value);

  String? get errorMessages {
    if (isValid || isPure) return null;
    if (displayError == DateError.empty) return 'El campo es requerido';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  DateError? validator(dynamic value) {
    if (value == null) return DateError.empty;
    return null;
  }
}
