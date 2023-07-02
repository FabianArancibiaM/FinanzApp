import 'package:equatable/equatable.dart';
import 'package:finance_now/bloc/forms/movement/movement_cubit.dart';
import 'package:finance_now/infrastructure/inputs/inputs.dart';

class LoginFormState extends Equatable {
  final Email email;
  final bool isValid;
  final FormStatus formStatus;

  const LoginFormState({
    this.email = const Email.pure(),
    this.isValid = false,
    this.formStatus = FormStatus.invalid,
  });

  LoginFormState copyWith({
    Email? email,
    bool? isValid,
    FormStatus? formStatus,
  }) =>
      LoginFormState(
        email: email ?? this.email,
        isValid: isValid ?? this.isValid,
        formStatus: formStatus ?? this.formStatus,
      );

  @override
  List<dynamic> get props => [email, isValid, formStatus];
}
