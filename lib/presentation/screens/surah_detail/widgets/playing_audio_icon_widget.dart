import 'package:flutter/material.dart';

class PlayingAudioIconWidget extends StatefulWidget {
  PlayingAudioIconWidget({
    super.key,
    required this.isPlay,
    this.callBack,
    required this.visible,
  });

  bool isPlay;
  Function()? callBack;
  final bool visible;

  @override
  State<PlayingAudioIconWidget> createState() => _PlayingAudioIconWidgetState();
}

class _PlayingAudioIconWidgetState extends State<PlayingAudioIconWidget> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: IconButton(
        onPressed: widget.callBack,
        // onPressed: () async {
        //   (!widget.isPlay) ? playAudio() : stopAudio();
        // },
        icon: (!widget.isPlay)
            ? const Icon(Icons.play_circle_fill_outlined)
            : const Icon(Icons.stop_circle_outlined),
      ),
    );
  }
}
