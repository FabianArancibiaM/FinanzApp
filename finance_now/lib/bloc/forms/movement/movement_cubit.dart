import 'package:equatable/equatable.dart';
import 'package:finance_now/infrastructure/inputs/inputs.dart';
import 'package:finance_now/models/financial_data_model.dart';
import 'package:finance_now/providers/financial_movement.dart';
import 'package:finance_now/shared/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

part 'movement_state.dart';

class MovementCubit extends Cubit<MovementFormState> {
  MovementCubit() : super(const MovementFormState());

  Future onSubmit(FinancialMovement movement) async {
    emit(state.copyWith(
        formStatus: FormStatus.validating,
        description: DescriptionInput.dirty(state.description.value),
        amount: AmountInput.dirty(state.amount.value),
        date: DateInput.dirty(state.date.value),
        category: DropDown.dirty(state.category.value),
        type: DropDown.dirty(state.type.value),
        isValid: Formz.validate([
          state.description,
          state.amount,
          state.category,
          state.type,
          state.date,
        ])));
    if (state.isValid) {
      await movement.newMovement(FinancialDataModel(
          period: movement.period!,
          details: state.description.value,
          ammount: int.parse(state.amount.value),
          type: state.type.value,
          category: state.category.value,
          dateOperation: DateFormat('dd/MM/yyyy').format(state.date.value)));
      emit(state.copyWith(formStatus: FormStatus.reload));
      return true;
    }
    emit(state.copyWith(formStatus: FormStatus.invalid));
    return false;
  }

  void descriptionChange(String value) {
    final description = DescriptionInput.dirty(value);
    emit(state.copyWith(
        description: description,
        isValid: Formz.validate([
          description,
          state.amount,
          state.category,
          state.type,
          state.date
        ])));
  }

  void amountChange(String value) {
    final amount = AmountInput.dirty(value);
    emit(state.copyWith(
        amount: amount,
        isValid: Formz.validate([
          amount,
          state.description,
          state.category,
          state.type,
          state.date
        ])));
  }

  void dateChange(DateTime value) {
    final date = DateInput.dirty(value);
    emit(state.copyWith(
        date: date,
        isValid: Formz.validate([
          date,
          state.category,
          state.type,
          state.amount,
          state.description
        ])));
  }

  void typeChange(SelectorObject select) {
    final type = DropDown.dirty(select.key);
    emit(state.copyWith(
        type: type,
        isValid: Formz.validate([
          type,
          state.category,
          state.date,
          state.amount,
          state.description
        ])));
  }

  void categoryChange(SelectorObject select) {
    final category = DropDown.dirty(select.key);
    emit(state.copyWith(
        category: category,
        isValid: Formz.validate([
          category,
          state.type,
          state.date,
          state.amount,
          state.description
        ])));
  }

  void formStatusChange(FormStatus status) {
    emit(state.copyWith(formStatus: status));
  }
}
