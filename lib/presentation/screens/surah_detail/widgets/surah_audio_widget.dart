import 'package:flutter/material.dart';

import '../../../../blocs/export.dart';
import '../../../../data/models/local/export.dart';

class SurahAudioWidget extends StatefulWidget {
  List<DetailSurahLocalModel> listAudioUrl;

  SurahAudioWidget({
    super.key,
    required this.listAudioUrl,
  });

  @override
  State<SurahAudioWidget> createState() => _SurahAudioWidgetState();
}

class _SurahAudioWidgetState extends State<SurahAudioWidget> {
  @override
  void initState() {
    List<String> url =
        widget.listAudioUrl.map((e) => e.audio_secondary_0.toString()).toList();

    context
        .read<AudiomanagementBloc>()
        .add(AllAudioAlreadyDownloadedEvent(listUrlAudio: url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget downloadWidget() {
      return IconButton(
        onPressed: () {
          context.read<AudiomanagementBloc>().add(DownloadBatchAudioEvent(
                listAudio: widget.listAudioUrl
                    .map((e) => e.audio_secondary_0.toString())
                    .toList(),
              ));
        },
        icon: const Icon(Icons.download),
      );
    }

    return BlocBuilder<AudiomanagementBloc, AudiomanagementState>(
      builder: (context, state) {
        if (state is SuccessAllAudioAlreadyDownloadedState) {
          Map<String, dynamic> allResult = state.result;

          if (allResult["audioStatus"] == true) {
            downloadWidget();
          } else {
            return IconButton(
              onPressed: () {},
              icon: const Icon(Icons.play_circle_filled_sharp),
            );
          }
        }
        return downloadWidget();
      },
    );
  }
}
