part of 'audiomanagement_bloc.dart';

abstract class AudiomanagementEvent extends Equatable {
  const AudiomanagementEvent();

  @override
  List<Object> get props => [];
}

class CheckAudioExistEvent extends AudiomanagementEvent {
  String listAudio;

  CheckAudioExistEvent({
    required this.listAudio,
  });
}

class CheckAllAudiFileEvent extends AudiomanagementEvent {
  // List<String> listAudio;
  String from;
  String to;

  CheckAllAudiFileEvent({
    // required this.listAudio,
    required this.from,
    required this.to,
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

/// Cek apakah semua audio surah sudah didownload semua
class AllAudioAlreadyDownloadedEvent extends AudiomanagementEvent {
  List<String> listUrlAudio;

  AllAudioAlreadyDownloadedEvent({
    required this.listUrlAudio,
  });
}
