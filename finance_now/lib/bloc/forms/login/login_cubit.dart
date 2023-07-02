import 'package:finance_now/bloc/forms/login/login_state.dart';
import 'package:finance_now/bloc/forms/movement/movement_cubit.dart';
import 'package:finance_now/infrastructure/inputs/inputs.dart';
import 'package:finance_now/models/user_model.dart';
import 'package:finance_now/providers/user_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginCubit extends Cubit<LoginFormState> {
  LoginCubit() : super(const LoginFormState());

  Future onSubmit(UserProvider provider) async {
    emit(state.copyWith(
        email: Email.dirty(state.email.value),
        formStatus: FormStatus.validating,
        isValid: Formz.validate([
          state.email,
        ])));
    UserModel? user = await provider.getUser();
    emit(state.copyWith(formStatus: FormStatus.invalid));
    if (user == null) return false;
    return state.email.value == user.email;
  }

  void emailChange(String emailInsert) {
    final email = Email.dirty(emailInsert);
    emit(state.copyWith(email: email, isValid: Formz.validate([email])));
  }
}
