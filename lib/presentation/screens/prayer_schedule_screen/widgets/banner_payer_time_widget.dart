import 'package:flutter/material.dart';
import 'package:kita_muslim/blocs/export.dart';
import 'package:kita_muslim/presentation/screens/surah_detail/widgets/export.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/datetime_utils.dart';
import '../../home_screen/widgets/next_time_duration_widget.dart';

class BannerPrayerTimeWidget extends StatefulWidget {
  const BannerPrayerTimeWidget({
    super.key,
  });

  @override
  State<BannerPrayerTimeWidget> createState() => _BannerPrayerTimeWidgetState();
}

class _BannerPrayerTimeWidgetState extends State<BannerPrayerTimeWidget> {
  String? selectedDate;

  @override
  void initState() {
    selectedDate = DateTimeUtils.getTodayDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerBloc, PrayerState>(
      buildWhen: (previous, current) =>
          current is LoadingNextPrayerTime ||
          current is SuccessNextPrayerTime ||
          current is FailureNextPrayerTime,
      builder: (context, state) {
        if (state is LoadingNextPrayerTime) {
          return CustomWidgets.showLoadingIndicatorWithContainer(
            context,
            MediaQuery.sizeOf(context).height / 3.5,
            double.infinity,
          );
        }

        if (state is FailureNextPrayerTime) {
          return const Center(
            child: Text("Gagal memuat data"),
          );
        }

        if (state is SuccessNextPrayerTime) {
          Map<String, dynamic> datas = state.result;
          return Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Constants.bannerImage),
                    fit: BoxFit.fitWidth,
                    opacity: .8,
                  ),
                ),
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height / 3.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      datas['description'],
                      style: TextStyle(
                        fontSize: MediaQuery.sizeOf(context).width / 15,
                      ),
                    ),
                    Text(
                      "${datas["next_times"]} ",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.sizeOf(context).width / 10),
                    ),
                    NextTimeDurationWidget(
                      datas: datas,
                      currentTimeString: datas['current_times'],
                      targetTimeeString: datas['next_times'],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<PrayerBloc>().add(ChangeDatePrayerEvent(
                          date: selectedDate!, isAdd: false));
                    },
                    icon: const Icon(Icons.arrow_back_ios_rounded),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 3,
                    child: BlocBuilder<PrayerBloc, PrayerState>(
                      buildWhen: (previous, current) =>
                          current is SuccessChangeDatePrayer,
                      builder: (context, state) {
                        if (state is SuccessChangeDatePrayer) {
                          selectedDate = state.date;
                          context
                              .read<PrayerBloc>()
                              .add(GetPrayerTimeEvent(date: selectedDate));
                          return Text(
                            selectedDate!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: Constants.sizeSubTextTitle),
                          );
                        } else {
                          return Text(
                            selectedDate ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: Constants.sizeSubTextTitle),
                          );
                        }
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<PrayerBloc>().add(ChangeDatePrayerEvent(
                          date: selectedDate!, isAdd: true));
                    },
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ],
              ),
            ],
          );
        } else {
          return CustomWidgets.showLoadingIndicatorWithContainer(
            context,
            MediaQuery.sizeOf(context).height / 3.5,
            double.infinity,
          );
        }
      },
    );
  }
}
