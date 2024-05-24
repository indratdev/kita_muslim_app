part of 'audiomanagement_bloc.dart';

abstract class AudiomanagementEvent extends Equatable {
  const AudiomanagementEvent();

  @override
  List<Object> get props => [];
}

class CheckAudioExistEvent extends AudiomanagementEvent {
  int listAudio;

  CheckAudioExistEvent({
    required this.listAudio,
  });
}

class CheckAllAudiFileEvent extends AudiomanagementEvent {
  List<String> listAudio;

  CheckAllAudiFileEvent({
    required this.listAudio,
  });
}

class CheckAudioFileEvent extends AudiomanagementEvent {
  String numberFileAudio;

  CheckAudioFileEvent({
    required this.numberFileAudio,
  });
}

class PlayAudioEvent extends AudiomanagementEvent {
  String numberFileAudio;

  PlayAudioEvent({
    required this.numberFileAudio,
  });
}

class DownloadListAudioEvent extends AudiomanagementEvent {
  List<String> listAudio;

  DownloadListAudioEvent({
    required this.listAudio,
  });
}

class DownloadListAudioTestEvent extends AudiomanagementEvent {
  List<String> listAudio;

  DownloadListAudioTestEvent({
    required this.listAudio,
  });
}

class DownloadBatchAudioEvent extends AudiomanagementEvent {
  List<String> listAudio;

  DownloadBatchAudioEvent({
    required this.listAudio,
  });
}
