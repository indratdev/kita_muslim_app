import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kita_muslim/blocs/calculator_bloc/calculator_bloc.dart';
import 'package:kita_muslim/presentation/screens/surah_detail/widgets/export.dart';

import 'package:kita_muslim/presentation/widgets/textformfied_custom.dart';
import 'package:kita_muslim/utils/constants.dart';

import '../../../../utils/number_utils.dart';

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
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          CustomTextfieldWidget(
            controller: _goldController,
            label: "Jumlah emas /gram",
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
                      CalculateZakatGoldEvent(
                        gold: double.tryParse(_goldController.text) ?? 0.0,
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
              if (state is FailureCalculateZakatGold) {
                return Center(child: Text("Error : ${state.message}"));
              }

              if (state is LoadingCalculateZakatGold) {
                return Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: CustomWidgets.showLoadingIndicatorWithContainer(
                        context,
                        MediaQuery.sizeOf(context).height / 4,
                        MediaQuery.sizeOf(context).width - 50));
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
                                      text:
                                          "${NumberUtils.convertToIdr(datas["sell_price"])} \n\n"),
                                  const TextSpan(
                                    text: 'Nishab Emas (85 gram)',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                      text:
                                          " ${NumberUtils.convertToIdr(datas["hishab_emas"])} \n"),
                                  TextSpan(
                                    text:
                                        'Sesuai SK Ketua BAZNAS No. 01 Tahun 2023',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.sizeOf(context).width /
                                                40,
                                        color: Constants.redColor,
                                        fontWeight: FontWeight.w500),
                                  ),
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
