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
    return IconButton(onPressed: () {}, icon: const Icon(Icons.download));
  }
}
