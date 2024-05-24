import 'package:flutter/material.dart';

import '../../../../blocs/export.dart';
import '../../../widgets/customwidgets.dart';

class DownloadAudioIconWidget extends StatelessWidget {
  const DownloadAudioIconWidget({
    super.key,
    required this.surahName,
    required this.listAudioDwn,
    required this.visible,
  });

  final String surahName;
  final List<String> listAudioDwn;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: IconButton(
        onPressed: () {
          // download icon
          CustomWidgets.showDialog2Button(
            context,
            "Unduh Audio",
            "Apakah Anda Yakin Akan Meng-unduh Audio $surahName ? ",
            () {
              context
                  .read<AudiomanagementBloc>()
                  .add(DownloadBatchAudioEvent(listAudio: listAudioDwn));
              Navigator.pop(context);

              // end
            },
          );
        },
        icon: const Icon(Icons.download),
      ),
    );
  }
}
