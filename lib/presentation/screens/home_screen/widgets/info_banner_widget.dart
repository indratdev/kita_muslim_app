import 'package:flutter/material.dart';
import 'package:kita_muslim/blocs/export.dart';
import 'package:kita_muslim/presentation/screens/home_screen/widgets/next_time_duration_widget.dart';

import '../../../../utils/constants.dart';

class InfoBannerWidget extends StatefulWidget {
  const InfoBannerWidget({
    super.key,
  });

  @override
  State<InfoBannerWidget> createState() => _InfoBannerWidgetState();
}

class _InfoBannerWidgetState extends State<InfoBannerWidget> {
  @override
  void dispose() {
    BlocProvider.of<PrayerBloc>(context).add(InitialPrayerEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      left: 10,
      bottom: 2,
      child: Container(
        height: MediaQuery.sizeOf(context).height / 7,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: AssetImage(Constants.bannerImage),
              fit: BoxFit.fitWidth,
            )),
        child: BlocBuilder<PrayerBloc, PrayerState>(
          buildWhen: (previous, current) =>
              current is LoadingNextPrayerTime ||
              current is FailureNextPrayerTime ||
              current is SuccessNextPrayerTime,
          builder: (context, state) {
            if (state is LoadingNextPrayerTime) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (state is FailureNextPrayerTime) {
              return const Center(
                child: Text("Failed to load data"),
              );
            }

            if (state is SuccessNextPrayerTime) {
              Map<String, dynamic> datas = state.result;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'Menjelang waktu Solat ',
                        children: <TextSpan>[
                          TextSpan(
                            text: datas['description'],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.sizeOf(context).width / 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${datas["next_times"]} ",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.sizeOf(context).width / 15),
                    ),
                    NextTimeDurationWidget(
                      datas: datas,
                      currentTimeString: datas['current_times'] ?? "00:00",
                      targetTimeeString: datas['next_times'] ?? "00:00",
                    ),
                  ],
                ),
              );
              //  BlocProvider.of<PrayerBloc>(context).add(InitialPrayerEvent());
            } else {
              return const Center(
                child: Text("Failed to load data"),
              );
            }
          },
        ),
      ),
    );
  }
}
