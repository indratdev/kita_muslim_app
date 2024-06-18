import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../blocs/export.dart';
import '../../../../data/models/local/detail_surah_local_model.dart';

class SurahAudioWidget extends StatefulWidget {
  List<DetailSurahLocalModel> listAudioUrl;
  final ItemScrollController itemScrollController;

  SurahAudioWidget({
    super.key,
    required this.listAudioUrl,
    required this.itemScrollController,
  });

  @override
  State<SurahAudioWidget> createState() => _SurahAudioWidgetState();
}

class _SurahAudioWidgetState extends State<SurahAudioWidget> {
  final audioPlayer = AudioPlayer();
  List<String> fileAudioLocation = [];
  bool _isPlay = false;
  int _indexPlay = 0;

  @override
  void initState() {
    List<String> url =
        widget.listAudioUrl.map((e) => e.audio_secondary_0.toString()).toList();

    context
        .read<AudiomanagementBloc>()
        .add(AllAudioAlreadyDownloadedEvent(listUrlAudio: url));

    audioPlayer.onPlayerComplete.listen((event) {
      if (_indexPlay < fileAudioLocation.length - 1) {
        _indexPlay += 1;
        playAudio();
        scrollToIndex(_indexPlay);
      } else {
        stopAudio();
      }
    });
    super.initState();
  }

  playAudio() async {
    if (_indexPlay <= fileAudioLocation.length - 1) {
      setState(() {
        _isPlay = true;
      });
      await audioPlayer.play(DeviceFileSource(fileAudioLocation[_indexPlay]));
      scrollToIndex(_indexPlay);
    }
  }

  stopAudio() {
    audioPlayer.stop();
    _isPlay = false;
    _indexPlay = 0;
    setState(() {});
  }

  pauseAudio() {
    audioPlayer.stop();
    _isPlay = false;
    setState(() {});
  }

  void scrollToIndex(int index) {
    widget.itemScrollController.scrollTo(
      index: index,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
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
          fileAudioLocation = allResult["fileNameAudio"];

          if (allResult["audioStatus"] == true) {
            return downloadWidget();
          } else {
            return (_isPlay)
                ? IconButton(
                    onPressed: () async => pauseAudio(),
                    icon: const Icon(Icons.pause_circle_filled_sharp),
                  )
                : IconButton(
                    onPressed: () async => playAudio(),
                    icon: const Icon(Icons.play_circle_filled_sharp),
                  );
          }
        }
        return downloadWidget();
      },
    );
  }
}
