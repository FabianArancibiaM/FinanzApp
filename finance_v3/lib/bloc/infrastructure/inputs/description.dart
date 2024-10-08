import 'package:formz/formz.dart';

// Define input validation errors
enum DescriptionError { empty, length }

// Extend FormzInput and provide the input type and error type.
class DescriptionInput extends FormzInput<String, DescriptionError> {
  // Call super.pure to represent an unmodified form input.
  const DescriptionInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const DescriptionInput.dirty(String value) : super.dirty(value);

  String? get errorMessages {
    if (isValid || isPure) return null;
    if (displayError == DescriptionError.empty) return 'El campo es requerido';
    if (displayError == DescriptionError.length) return 'Minimo 6 caracteres';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  DescriptionError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return DescriptionError.empty;
    if (value.length < 6) return DescriptionError.length;
    return null;
  }
}
