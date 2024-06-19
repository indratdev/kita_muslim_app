import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kita_muslim/blocs/calculator_bloc/calculator_bloc.dart';

import 'package:kita_muslim/presentation/widgets/textformfied_custom.dart';
import 'package:kita_muslim/utils/constants.dart';

class GoldCalculatorWidget extends StatefulWidget {
  const GoldCalculatorWidget({super.key});

  @override
  State<GoldCalculatorWidget> createState() => _GoldCalculatorWidgetState();
}

class _GoldCalculatorWidgetState extends State<GoldCalculatorWidget> {
  final TextEditingController _goldController =
      TextEditingController(text: "0");

  @override
  void dispose() {
    _goldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        // shrinkWrap: true,
        children: [
          CustomTextfieldWidget(
            controller: _goldController,
            label: "Jumlah emas /gram",
          ),
          ElevatedButton(
            onPressed: () async {
              context.read<CalculatorBloc>().add(
                    CalculateZakatGoldEvent(
                      gold: double.tryParse(_goldController.text) ?? 0.0,
                    ),
                  );
            },
            child: const Text("Hitung"),
          ),
          BlocBuilder<CalculatorBloc, CalculatorState>(
            builder: (context, state) {
              if (state is FailureCalculateZakatGold) {
                return Center(child: Text("Error : ${state.message}"));
              }

              if (state is LoadingCalculateZakatGold) {
                return const Center(child: Text("Loading..."));
              }

              if (state is SuccessCalculateZakatGold) {
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
                                      text: "Rp. ${datas["sell_price"]} \n\n"),
                                  const TextSpan(
                                    text: 'Nishab 85 gram per bulan: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                      text: "Rp. ${datas["nishab_month"]} \n"),
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
                                      text: 'Total Zakat Emas Setahun \n'),
                                  TextSpan(
                                    text: "Rp. ${datas["total_pay"]} \n\n",
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
