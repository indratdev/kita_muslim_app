import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kita_muslim/blocs/calculator_bloc/calculator_bloc.dart';

import 'package:kita_muslim/presentation/widgets/textformfied_custom.dart';
import 'package:kita_muslim/utils/constants.dart';
import 'package:kita_muslim/utils/number_utils.dart';

import '../../surah_detail/widgets/export.dart';

class IncomeCalculatorWidget extends StatefulWidget {
  const IncomeCalculatorWidget({super.key});

  @override
  State<IncomeCalculatorWidget> createState() => _IncomeCalculatorWidgetState();
}

class _IncomeCalculatorWidgetState extends State<IncomeCalculatorWidget> {
  final TextEditingController _incomeController =
      TextEditingController(text: "0");
  final TextEditingController _otherIncomeController =
      TextEditingController(text: "0");

  @override
  void dispose() {
    _incomeController.dispose();
    _otherIncomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        // shrinkWrap: true,
        children: [
          CustomTextfieldWidget(
            controller: _incomeController,
            label: "Pendapatan /bulan",
          ),
          CustomTextfieldWidget(
            controller: _otherIncomeController,
            label: "Penghasilan lain-lainnya /bulan",
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width / 3,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.deepGreenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
              onPressed: () async {
                context.read<CalculatorBloc>().add(
                      CalculateZakatPenghasilanEvent(
                        income: double.tryParse(_incomeController.text) ?? 0.0,
                        otherIncome:
                            double.tryParse(_otherIncomeController.text) ?? 0.0,
                      ),
                    );
              },
              child: const Text(
                "Hitung",
                style: TextStyle(color: Constants.whiteColor),
              ),
            ),
          ),
          BlocBuilder<CalculatorBloc, CalculatorState>(
            builder: (context, state) {
              if (state is FailureCalculateZakatPenghasilan) {
                return Center(child: Text("Error : ${state.message}"));
              }

              if (state is LoadingCalculateZakatPenghasilan) {
                return Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: CustomWidgets.showLoadingIndicatorWithContainer(
                        context,
                        MediaQuery.sizeOf(context).height / 4,
                        MediaQuery.sizeOf(context).width - 50));
              }

              if (state is SuccessCalculateZakatPenghasilan) {
                Map<String, dynamic> datas = state.result;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Constants.greenColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        margin: const EdgeInsets.only(top: 12),
                        padding: const EdgeInsets.all(8),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                datas["description"],
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.sizeOf(context).width / 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Text("Deskripsi :"),
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  const TextSpan(
                                      text:
                                          'Perhitungan zakat diupdate otomatis berdasarkan update harga emas.\n\n'),
                                  const TextSpan(
                                    text: 'Harga emas per gram saat ini: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                      text:
                                          "${NumberUtils.convertToIdr(datas["sell_price"])} \n\n"),
                                  const TextSpan(
                                    text: 'Nishab 85 gram per bulan: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                      text:
                                          "${NumberUtils.convertToIdr(datas["nishab_month"])} \n"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        padding: const EdgeInsets.all(8),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  const TextSpan(
                                      text:
                                          'Total Zakat Penghasilan Sebulan \n'),
                                  TextSpan(
                                    text:
                                        "${NumberUtils.convertToIdr(datas["total_pay"])} \n\n",
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.sizeOf(context).width / 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
