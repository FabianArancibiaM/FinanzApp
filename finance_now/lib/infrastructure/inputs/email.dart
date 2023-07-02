import 'package:formz/formz.dart';

enum EmailValidationError { invalid, empty }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty(String value) : super.dirty(value);

  static final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  String? get errorMessages {
    if (isValid || isPure) return null;
    if (displayError == EmailValidationError.empty) {
      return 'El campo es requerido';
    }
    if (displayError == EmailValidationError.invalid) return 'Correo invalido';
    return null;
  }

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return EmailValidationError.empty;
    }
    if (!_emailRegex.hasMatch(value)) return EmailValidationError.invalid;
    return null;
  }
}
