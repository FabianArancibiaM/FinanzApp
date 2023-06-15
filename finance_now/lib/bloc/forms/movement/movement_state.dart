part of 'movement_cubit.dart';

enum FormStatus { invalid, valid, validating, posting, saving, reload }

class MovementFormState extends Equatable {
  final DescriptionInput description;
  final bool isValid;
  final AmountInput amount;
  final DateInput date;
  final DropDown type;
  final DropDown category;
  final FormStatus formStatus;

  const MovementFormState({
    this.type = const DropDown.pure(),
    this.category = const DropDown.pure(),
    this.isValid = false,
    this.formStatus = FormStatus.invalid,
    this.description = const DescriptionInput.pure(),
    this.amount = const AmountInput.pure(),
    this.date = const DateInput.pure(),
  });

  MovementFormState copyWith({
    DescriptionInput? description,
    bool? isValid,
    AmountInput? amount,
    DateInput? date,
    DropDown? type,
    DropDown? category,
    FormStatus? formStatus,
  }) =>
      MovementFormState(
        description: description ?? this.description,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        isValid: isValid ?? this.isValid,
        type: type ?? this.type,
        category: category ?? this.category,
        formStatus: formStatus ?? this.formStatus,
      );

  @override
  List<dynamic> get props =>
      [type, category, formStatus, description, amount, date, isValid];
}
