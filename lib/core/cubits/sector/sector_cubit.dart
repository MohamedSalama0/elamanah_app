import 'package:farm_project/core/cubits/sector/sector_states.dart';
import 'package:farm_project/core/models/sector_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:farm_project/core/services/firebase_service.dart';


class SectorCubit extends Cubit<SectorState> {
 final FirebaseService _firebaseService;

  List<SectorModel> sectors = [];

  // Singleton logic
  static SectorCubit? _instance;

  factory SectorCubit() {
    _instance ??= SectorCubit._internal(FirebaseService());
    return _instance!;
  }

  SectorCubit._internal(this._firebaseService) : super(SectorInitial());

  Future<void> fetchSectors() async {
    try {
      emit(SectorLoading());
      final fetchedSectors = await _firebaseService.getSectors();
      sectors = fetchedSectors;
      emit(SectorSuccess());
    } catch (e) {
      emit(SectorFailure(e.toString()));
    }
  }
    @override
  Future<void> close() {
    _instance = null;
    return super.close();
  }
}
