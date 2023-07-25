import 'package:finance_now/bloc/forms/login/login_state.dart';
import 'package:finance_now/bloc/forms/movement/movement_cubit.dart';
import 'package:finance_now/infrastructure/inputs/inputs.dart';
import 'package:finance_now/models/parametric_data_model.dart';
import 'package:finance_now/models/user_model.dart';
import 'package:finance_now/providers/providers.dart';
import 'package:finance_now/providers/records_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginCubit extends Cubit<LoginFormState> {
  LoginCubit() : super(const LoginFormState());

  Future onSubmit(
      UserProvider userProvider,
      ParametricDataProvider categoryProvider,
      RecordsProvider recordsProvider) async {
    emit(state.copyWith(
        email: Email.dirty(state.email.value),
        formStatus: FormStatus.validating,
        isValid: Formz.validate([
          state.email,
        ])));
    if (!state.isValid) {
      emit(state.copyWith(formStatus: FormStatus.invalid));
      return false;
    }
    UserModel? user = await userProvider.getUser();
    if (user == null) {
      emit(state.copyWith(formStatus: FormStatus.invalid));
      return false;
    }
    emit(state.copyWith(formStatus: FormStatus.valid));
    bool parametricData =
        await categoryProvider.getParametricData(user.documentID);
    if (!parametricData) {
      emit(state.copyWith(formStatus: FormStatus.invalid));
      return false;
    }
    bool records = await recordsProvider.getRecords(user.documentID);
    if (!records) {
      emit(state.copyWith(formStatus: FormStatus.invalid));
      return false;
    }
    return state.email.value == user.email;
  }

  void emailChange(String emailInsert) {
    final email = Email.dirty(emailInsert);
    emit(state.copyWith(email: email, isValid: Formz.validate([email])));
  }
}
