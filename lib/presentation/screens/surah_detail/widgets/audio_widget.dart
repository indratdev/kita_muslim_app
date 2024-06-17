import 'package:flutter/material.dart';
import 'package:kita_muslim/blocs/export.dart';

class AudioWidget extends StatefulWidget {
  int numberInquran;
  int numberOfVerse;

  AudioWidget({
    super.key,
    required this.numberInquran,
    required this.numberOfVerse,
  });

  @override
  State<AudioWidget> createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  @override
  void initState() {
    print(">>> init audio run...");
    BlocProvider.of<AudiomanagementBloc>(context).add(CheckAllAudiFileEvent(
        from: widget.numberInquran.toString(),
        to: widget.numberOfVerse.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          print(">>> tap:IconButton");
          List<String> listAudioDwn = [
            'https://cdn.islamic.network/quran/audio/128/ar.alafasy/1.mp3',
            'https://cdn.islamic.network/quran/audio/128/ar.alafasy/2.mp3',
            'https://cdn.islamic.network/quran/audio/128/ar.alafasy/3.mp3',
            'https://cdn.islamic.network/quran/audio/128/ar.alafasy/4.mp3',
            'https://cdn.islamic.network/quran/audio/128/ar.alafasy/5.mp3',
            'https://cdn.islamic.network/quran/audio/128/ar.alafasy/6.mp3',
            'https://cdn.islamic.network/quran/audio/128/ar.alafasy/7.mp3'
          ];
          context
              .read<AudiomanagementBloc>()
              .add(DownloadBatchAudioEvent(listAudio: listAudioDwn));
        },
        icon: const Icon(Icons.download));
  }
}
