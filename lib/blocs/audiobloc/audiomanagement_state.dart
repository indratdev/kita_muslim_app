part of 'audiomanagement_bloc.dart';

abstract class AudiomanagementState extends Equatable {
  const AudiomanagementState();

  @override
  List<Object> get props => [];
}

class AudiomanagementInitial extends AudiomanagementState {}

class FailedAudioManagement extends AudiomanagementState {
  String messageInfo;

  FailedAudioManagement({
    required this.messageInfo,
  });

  @override
  List<Object> get props => [messageInfo];
}

class LoadingPlayAudioState extends AudiomanagementState {}

class SuccessAudioExistState extends AudiomanagementState {
  bool isAudioExist;

  SuccessAudioExistState({
    required this.isAudioExist,
  });

  @override
  List<Object> get props => [isAudioExist];
}

class FailedPlayAudioState extends AudiomanagementState {
  String messageInfo;
  // var uuid = Uuid().v1();
  String status;

  FailedPlayAudioState({
    required this.messageInfo,
    required this.status,
    // this.uuid = "",
  });

  @override
  List<Object> get props => [messageInfo, status];
}

class ResultAllAudioFilesState extends AudiomanagementState {
  Map<String, dynamic> statusFile;

  ResultAllAudioFilesState({
    required this.statusFile,
  });

  @override
  List<Object> get props => [statusFile];
}

class FailedCheckAllAudioFilesState extends AudiomanagementState {
  String messageInfo;

  FailedCheckAllAudioFilesState({
    required this.messageInfo,
  });

  @override
  List<Object> get props => [messageInfo];
}

// -- Download List Audio
class LoadingDownloadAudioState extends AudiomanagementState {}

class FailedDownloadListAudio extends FailedAudioManagement {
  FailedDownloadListAudio({required super.messageInfo});
}

class ProgressDownloadAudio extends AudiomanagementState {
  int progress;
  int total;

  ProgressDownloadAudio({
    required this.progress,
    required this.total,
  });

  @override
  List<Object> get props => [progress, total];
}

class SuccessDownloadAudio extends AudiomanagementState {
  Map<String, dynamic> statusFile;

  SuccessDownloadAudio({
    required this.statusFile,
  });

  @override
  List<Object> get props => [statusFile];
}

class ApprovedDownloadAudio extends AudiomanagementState {
  List<String> listAudio;
  Directory directoryStorage;

  ApprovedDownloadAudio({
    required this.listAudio,
    required this.directoryStorage,
  });

  @override
  List<Object> get props => [listAudio, directoryStorage];
}
// -- End Download List Audio

/// CheckAllAudiFile
class LoadingCheckAllAudiFileState extends AudiomanagementState {}

class FailedCheckAllAudiFile extends FailedAudioManagement {
  FailedCheckAllAudiFile({
    required super.messageInfo,
  });
}

class SuccessCheckAllAudiFileState extends AudiomanagementState {
  bool status;

  SuccessCheckAllAudiFileState({required this.status});
}

/// end

class UpdateDownloadProgressState extends AudiomanagementState {
  final double progress;
  UpdateDownloadProgressState(this.progress);

  @override
  List<Object> get props => [progress];
}

class DownloadingAudioState extends AudiomanagementState {
  final double progress;
  DownloadingAudioState({required this.progress});

  @override
  List<Object> get props => [progress];
}

/// Cek apakah semua audio surah sudah didownload semua
class LoadingAllAudioAlreadyDownloaded extends AudiomanagementState {}

class FailureAllAudioAlreadyDownloadedState extends FailedAudioManagement {
  FailureAllAudioAlreadyDownloadedState({
    required super.messageInfo,
  });
}

class SuccessAllAudioAlreadyDownloadedState extends AudiomanagementState {
  Map<String, dynamic> result;

  SuccessAllAudioAlreadyDownloadedState({required this.result});
}
