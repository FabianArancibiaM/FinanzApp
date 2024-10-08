import 'package:equatable/equatable.dart';
import 'package:finance_v3/bloc/infrastructure/inputs/amount.dart';
import 'package:finance_v3/bloc/infrastructure/inputs/date.dart';
import 'package:finance_v3/bloc/infrastructure/inputs/description.dart';
import 'package:finance_v3/bloc/infrastructure/inputs/drop_down.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'movement_state.dart';

class MovementCubit extends Cubit<MovementState> {
  MovementCubit() : super(const MovementState());

  Future onSubmit() async {}

  void clearForm() {
    emit(const MovementState());
  }

  void formStatusChange(FormStatus status) {
    emit(state.copyWith(formStatus: status));
  }

  void descriptionChange(String value) {
    final description = DescriptionInput.dirty(value);
    emit(state.copyWith(
        description: description,
        isValid: Formz.validate(
            [description, state.amount, state.typeMovement, state.date])));
    formStatus();
  }

  void dateChange(String value) {
    final date = DateInput.dirty(value);
    emit(state.copyWith(
        date: date,
        isValid: Formz.validate(
            [date, state.amount, state.typeMovement, state.description])));
    formStatus();
  }

  void amountChange(String value) {
    value = value.replaceAll(RegExp('[^0-9]'), '');
    final amount = AmountInput.dirty(value);
    emit(state.copyWith(
        amount: amount,
        isValid: Formz.validate(
            [amount, state.date, state.typeMovement, state.description])));
    formStatus();
  }

  void typeMovementChange(String value) {
    final typeMovement = DropDown.dirty(value);
    emit(state.copyWith(
        typeMovement: typeMovement,
        isValid: Formz.validate(
            [typeMovement, state.date, state.amount, state.description])));
    formStatus();
  }

  void formStatus() {
    emit(state.copyWith(
        formStatus:
            state.isValid == true ? FormStatus.valid : FormStatus.invalid));
  }
}
