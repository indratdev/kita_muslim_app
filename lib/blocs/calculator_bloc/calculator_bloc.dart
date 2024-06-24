import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kita_muslim/data/repositories/moslem_repository.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(CalculatorInitial()) {
    final moslemRepository = MoslemRepository();

    on<InitialCalculatorEvent>((event, emit) {
      emit(InitialCalculatorState());
    });

    on<CalculateZakatPenghasilanEvent>((event, emit) async {
      emit(LoadingCalculateZakatPenghasilan());
      try {
        Map<String, dynamic> result = {};
        // check gold price
        int sellPrice = await moslemRepository.getSellPriceGold();
        double nishabYear = (sellPrice.toDouble() * 85).roundToDouble();
        double nishabMonth = (nishabYear / 12).roundToDouble();
        double totalIncome = (event.income + event.otherIncome).roundToDouble();

        double totalPay = (totalIncome <= nishabMonth)
            ? 0.0
            : (0.025 * nishabMonth).roundToDouble();

        String description = (totalIncome <= nishabMonth)
            ? "Tidak wajib membayar zakat"
            : "Wajib membayar zakat";

        result["sell_price"] = sellPrice;
        result["nishab_month"] = nishabMonth;
        result["nishab_year"] = nishabYear;
        result["total_income"] = totalIncome;
        result["total_pay"] = totalPay;
        result["description"] = description;

        emit(SuccessCalculateZakatPenghasilan(result: result));
      } catch (e) {
        emit(FailureCalculateZakatPenghasilan(message: e.toString()));
      }
    });

    on<CalculateZakatGoldEvent>((event, emit) async {
      emit(LoadingCalculateZakatGold());
      try {
        Map<String, dynamic> result = {};
        int nishabPerGram = 85;

        // check gold price
        int sellPrice = await moslemRepository.getSellPriceGold();
        double totalGold = (event.gold).roundToDouble();
        double totalPay = (totalGold < nishabPerGram)
            ? 0.0
            : (sellPrice * totalGold * 0.025).roundToDouble();

        String description = (totalGold < nishabPerGram)
            ? "Tidak wajib membayar zakat"
            : "Wajib membayar zakat";

        result["sell_price"] = sellPrice;
        result["total_gold"] = totalGold;
        result["total_pay"] = totalPay;
        result["description"] = description;
        result["hishab_emas"] = 82312725;

        emit(SuccessCalculateZakatGold(result: result));
      } catch (e) {
        emit(FailureCalculateZakatPenghasilan(message: e.toString()));
      }
    });
  }
}
