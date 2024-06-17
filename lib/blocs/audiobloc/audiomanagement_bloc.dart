import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kita_muslim/data/repositories/audio_repository.dart';
import 'package:kita_muslim/data/services/local_services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import '../../data/repositories/hadist_repository.dart';
import '../../data/repositories/storage_repository.dart';

part 'audiomanagement_event.dart';
part 'audiomanagement_state.dart';

class AudiomanagementBloc
    extends Bloc<AudiomanagementEvent, AudiomanagementState> {
  final audioRepository = AudioRepository();
  final hadistRepository = HadistRepository();
  final storageRepository = StorageRepository();

  AudiomanagementBloc() : super(AudiomanagementInitial()) {
    on<CheckAudioFileEvent>((event, emit) async {
      var isExistFileAudio = false;
      try {
        isExistFileAudio =
            await audioRepository.isExistAudioFile(event.numberFileAudio);
        if (isExistFileAudio) {
          emit(SuccessAudioExistState(isAudioExist: isExistFileAudio));
        } else {
          emit(SuccessAudioExistState(isAudioExist: false));
        }
      } catch (e) {
        emit(FailedPlayAudioState(
            messageInfo: 'Surat / Ayat Surat Belum Di-unduh',
            status: "status null"));
      }
    });

    on<CheckAllAudiFileEvent>((event, emit) async {
      emit(LoadingCheckAllAudiFileState());
      try {
        print(">>> CheckAllAudiFileEvent run...");
        var aaaa = await audioRepository.isAllAudioAlreadyDownloaded(
            int.parse(event.from), int.parse(event.to));
      } catch (e) {
        emit(FailedCheckAllAudiFile(messageInfo: e.toString()));
      }
    });

    on<PlayAudioEvent>((event, emit) async {
      var isExistFileAudio = false;
      var uuid = const Uuid().v1();
      try {
        // check file audio
        isExistFileAudio =
            await audioRepository.isExistAudioFile(event.numberFileAudio);

        //
        if (isExistFileAudio == true) {
          emit(SuccessAudioExistState(isAudioExist: isExistFileAudio));
        } else if (isExistFileAudio == false) {
          emit(FailedPlayAudioState(
              messageInfo: 'Surat / Ayat Surat Belum Di-unduh',
              status: "status $uuid"));
        }
      } catch (e) {
        // emit(FailedPlayAudioState(messageInfo: e.toString()));
      }
    });

    on<CheckAudioExistEvent>((event, emit) async {
      try {
        List<String> resultListAudio =
            await audioRepository.isAllAudioExist(event.listAudio);
        var result = await audioRepository.isExistAllAudiFiles(resultListAudio);
        emit(ResultAllAudioFilesState(statusFile: result));
      } catch (e) {
        emit(FailedCheckAllAudioFilesState(
            messageInfo: "Error: Gagal Dalam Pengecekan File Audio"));
      }
    });

    // on<DownloadBatchAudioEvent>((event, emit) async {
    //   emit(LoadingDownloadAudioState());
    //   try {
    //     List<String> listAudio = event.listAudio;

    //     print(">>> bloc DownloadBatchAudioEvent");

    //     // if sdk < 33 user Permission
    //     DeviceInfo deviceInfo = await LocalServices().checkDeviceInfo();
    //     if (deviceInfo.sdkInt! < 33) {
    //       PermissionStatus isGranted =
    //           // await storageRepository.isStorageGranted();
    //           await storageRepository.isManageExternalStorageGranted();

    //       if (isGranted != PermissionStatus.granted) {
    //         openAppSettings();
    //       }
    //     }

    //     Directory storageDIR = await storageRepository.getAudioDirectoryPath();

    //     if (await storageDIR.exists()) {
    //       bool status = await audioRepository.downloadBatchAudio(
    //           listAudio, storageDIR.path);

    //       if (status) {
    //         Map<String, dynamic> result =
    //             await audioRepository.isExistAllAudiFiles(listAudio);

    //         emit(SuccessDownloadAudio(statusFile: result));
    //       } else {
    //         emit(FailedDownloadListAudio(messageInfo: "Gagal Download Audio"));
    //       }
    //     }
    //   } catch (e) {
    //     emit(FailedDownloadListAudio(messageInfo: e.toString()));
    //   }
    // });
    on<DownloadBatchAudioEvent>((event, emit) async {
      emit(LoadingDownloadAudioState());
      try {
        List<String> listAudio = event.listAudio;

        print(">>> bloc DownloadBatchAudioEvent");

        DeviceInfo deviceInfo = await LocalServices().checkDeviceInfo();
        if (deviceInfo.sdkInt! < 33) {
          PermissionStatus isGranted =
              await storageRepository.isManageExternalStorageGranted();

          if (isGranted != PermissionStatus.granted) {
            openAppSettings();
          }
        }

        Directory storageDIR = await storageRepository.getAudioDirectoryPath();

        if (await storageDIR.exists()) {
          await audioRepository.downloadBatchAudio(listAudio, storageDIR.path,
              (progress) {
            // add(UpdateDownloadProgressEvent(progress));
            emit(UpdateDownloadProgressState(progress));
            print(">>> DownloadBatchAudioEvent progress : $progress");
          });

          Map<String, dynamic> result =
              await audioRepository.isExistAllAudiFiles(listAudio);
          emit(SuccessDownloadAudio(statusFile: result));
        }
      } catch (e) {
        emit(FailedDownloadListAudio(messageInfo: e.toString()));
      }
    });

    // on<UpdateDownloadProgressEvent>((event, emit) {
    //   emit(DownloadingAudioState(progress: event.progress));
    // });
  }
}
