part of 'movement_cubit.dart';

enum FormStatus { invalid, valid, validating, posting, saving, reload }

class MovementState extends Equatable {
  final AmountInput amount;
  final DateInput date;
  final DescriptionInput description;
  final DropDown typeMovement;
  final bool isValid;
  final FormStatus formStatus;

  const MovementState({
    this.amount = const AmountInput.pure(),
    this.date = const DateInput.pure(),
    this.description = const DescriptionInput.pure(),
    this.typeMovement = const DropDown.pure(),
    this.formStatus = FormStatus.invalid,
    this.isValid = false,
  });

  MovementState copyWith({
    DescriptionInput? description,
    bool? isValid,
    AmountInput? amount,
    DateInput? date,
    DropDown? typeMovement,
    FormStatus? formStatus,
  }) =>
      MovementState(
        description: description ?? this.description,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        isValid: isValid ?? this.isValid,
        typeMovement: typeMovement ?? this.typeMovement,
        formStatus: formStatus ?? this.formStatus,
      );

  @override
  // TODO: implement props
  List<Object?> get props =>
      [typeMovement, formStatus, description, amount, date, isValid];
}
