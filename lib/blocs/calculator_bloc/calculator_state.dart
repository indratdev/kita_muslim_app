part of 'calculator_bloc.dart';

sealed class CalculatorState extends Equatable {
  const CalculatorState();

  @override
  List<Object> get props => [];
}

final class CalculatorInitial extends CalculatorState {}

class FailureCalculator extends CalculatorState {
  String message;

  FailureCalculator({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class FailureCalculateZakatPenghasilan extends FailureCalculator {
  FailureCalculateZakatPenghasilan({required super.message});
}

class LoadingCalculateZakatPenghasilan extends CalculatorState {}

class SuccessCalculateZakatPenghasilan extends CalculatorState {
  Map<String, dynamic> result;

  SuccessCalculateZakatPenghasilan({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}

class FailureCalculateZakatGold extends FailureCalculator {
  FailureCalculateZakatGold({required super.message});
}

class LoadingCalculateZakatGold extends CalculatorState {}

class SuccessCalculateZakatGold extends CalculatorState {
  Map<String, dynamic> result;

  SuccessCalculateZakatGold({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}

class InitialCalculatorState extends CalculatorState {}
