import 'package:flutter/material.dart';
import 'package:kita_muslim/blocs/export.dart';
import 'package:kita_muslim/presentation/screens/surah_detail/widgets/export.dart';

import '../../../utils/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isProgressDialogShowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomWidgets.basicAppBar(
          context,
          "Pengaturan",
        ),
        body: BlocConsumer<SurahBloc, SurahState>(
          listener: (context, state) {
            if (state is LoadingDownloadAllSurahState) {
              CustomWidgets.showCenterLoading(context);
            }

            if (state is ProgressDownloadAllSurahState) {
              if (!_isProgressDialogShowing) {
                _isProgressDialogShowing = true;
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return PopScope(
                      onPopInvoked: (didPop) => false,
                      child: AlertDialog(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        backgroundColor: Constants.blackColor,
                        content: BlocBuilder<SurahBloc, SurahState>(
                          builder: (context, state) {
                            if (state is ProgressDownloadAllSurahState) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  LinearProgressIndicator(
                                      value: state.progress / 100),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${state.progress.toStringAsFixed(2)}%',
                                    style: const TextStyle(
                                        color: Constants.whiteColor),
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              }
            } else if (state is SuccessDownloadAllSurahState ||
                state is FailureDownloadAllSurahState) {
              if (_isProgressDialogShowing) {
                Navigator.of(context, rootNavigator: true)
                  ..pop()
                  ..pop();
                _isProgressDialogShowing = false;
              }
            }
            //   if (state is SuccessDownloadAudio) {
            //     Navigator.pop(context);
            //     context.read<AudiomanagementBloc>().add(
            //         AllAudioAlreadyDownloadedEvent(
            //             listUrlAudio: listData
            //                 .map((e) => e.audio_secondary_0.toString())
            //                 .toList()));
            //   }
            // }
          },
          builder: (context, state) {
            return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: ListTile.divideTiles(context: context, tiles: [
                ListTile(
                  leading: Icon(
                    Icons.circle,
                    size: MediaQuery.sizeOf(context).width / 28,
                  ),
                  title: const Text("Unduh Semua Surat Al-Quran"),
                  onTap: () {
                    CustomWidgets.showDialog2Button(
                        context,
                        "Unduh Semua Surah",
                        "Apakah anda yakin ingin unduh semua surah ?", () {
                      context.read<SurahBloc>().add(DownloadAllSurah());
                      Navigator.pop(context);
                    });
                  },
                ),
              ]).toList(),
            );
          },
        ));
  }
}
