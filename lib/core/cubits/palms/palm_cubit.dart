import 'dart:io';

import 'package:farm_project/core/services/firebase_palm_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:farm_project/core/models/palm_model.dart';
import 'package:farm_project/core/services/firebase_service.dart';

part 'palm_state.dart';

class PalmCubit extends Cubit<PalmState> {
  final FirebaseService _firebaseService;

  List<PalmModel> palms = [];

  static PalmCubit? _instance;

  factory PalmCubit() {
    _instance ??= PalmCubit._internal(FirebaseService());
    return _instance!;
  }

  int get maxHorizontalPalms {
    final list = palms.map((palm) => palm.coordX).toList();
    list.sort();
    return list.last;
  }

  int get maxVerticalPalms {
    final list = palms.map((palm) => palm.coordY).toList();
    list.sort();
    return list.last;
  }

  PalmCubit._internal(this._firebaseService) : super(PalmInitial());

  Future<void> fetchPalms(String sectorid, String segmentId) async {
    try {
      emit(PalmLoading());
      final fetchedPalms = await _firebaseService.getPalms(sectorid, segmentId);
      palms = fetchedPalms;
      emit(PalmSuccess());
    } catch (e) {
      emit(PalmFailure(e.toString()));
    }
  }

  Future<void> updatePalm(
    String sectorId,
    String segmentId,
    PalmModel updatedPalm,
  ) async {
    emit(PalmUpdateLoading());
    try {
      await _firebaseService.updatePalm(
        sectorId: sectorId,
        segmentId: segmentId,
        updatedPalm: updatedPalm,
      );
      // Refresh palms list after update
      await fetchPalms(sectorId, segmentId);
      emit(PalmUpdateSuccess());
    } catch (e) {
      emit(PalmUpdateFailure(e.toString()));
    }
  }

  Future<void> updatePalmImage(
    String sectorId,
    String segmentId,
    PalmModel updatedPalm,
    File image,
  ) async {
    emit(PalmUpdateLoading());
    try {
     final imageUrl =  await FirebasePalmService().uploadPalmImage(
        sectorId: sectorId,
        segmentId: segmentId,
        imageFile: image,
        coordX: updatedPalm.coordX,
        coordY: updatedPalm.coordY,
        existingImageUrl: updatedPalm.image,
      );
      await _firebaseService.updatePalmImage(sectorId: sectorId, segmentId: segmentId, updatedPalm: updatedPalm, newImageUrl: imageUrl);
      // Refresh palms list after update
      await fetchPalms(sectorId, segmentId);
      emit(PalmUpdateSuccess());
    } catch (e) {
      emit(PalmUpdateFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _instance = null;
    return super.close();
  }
}
