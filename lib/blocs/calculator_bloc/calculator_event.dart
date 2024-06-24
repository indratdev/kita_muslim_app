part of 'calculator_bloc.dart';

sealed class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object> get props => [];
}

class InitialCalculatorEvent extends CalculatorEvent {}

class CalculateZakatPenghasilanEvent extends CalculatorEvent {
  double income;
  double otherIncome;

  CalculateZakatPenghasilanEvent({
    required this.income,
    this.otherIncome = 0.0,
  });
}

class CalculateZakatGoldEvent extends CalculatorEvent {
  double gold;

  CalculateZakatGoldEvent({
    required this.gold,
  });
}
