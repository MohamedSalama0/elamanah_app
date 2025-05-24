import 'package:farm_project/core/models/irrigation_model.dart';
import 'package:farm_project/core/models/sector_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:farm_project/core/models/segment_model.dart';
import 'package:farm_project/core/services/firebase_service.dart';

part 'segment_state.dart';

class SegmentCubit extends Cubit<SegmentState> {
  final FirebaseService _firebaseService;

  List<SegmentModel> segments = [];

  static SegmentCubit? _instance;
  SegmentModel? selectedSegment;
  SectorModel? selectedSector;

  factory SegmentCubit() {
    _instance ??= SegmentCubit._internal(FirebaseService());
    return _instance!;
  }

  SegmentCubit._internal(this._firebaseService) : super(SegmentInitial());

  void setInitialSegment(SectorModel sector, SegmentModel segment) {
    selectedSector = sector;
    selectedSegment = segment;
  }

  Future<void> fetchSegments(String sectorId) async {
    try {
      emit(SegmentLoading());
      final fetchedSegments = await _firebaseService.getSegments(sectorId);
      segments = fetchedSegments;
      emit(SegmentSuccess());
    } catch (e) {
      emit(SegmentFailure(e.toString()));
    }
  }

  Future<void> updateSegmentIrrigation({
    required String sectorId,
    required SegmentModel segment,
    required List<IrrigationModel> irrigationList,
    required double irrigationTransportCost,
  }) async {
    emit(SegmentUpdateCalculationLoading());
    try {
      await _firebaseService.updateIrrigationForSegment(
        sectorId: sectorId,
        segmentId: segment.id,
        irrigationList: irrigationList,
        irrigationTransportCost: irrigationTransportCost,
      );
      emit(SegmentUpdateCalculationSuccess());
      await updateSegmentsAndSetIntitial();
    } catch (e) {
      emit(SegmentUpdateCalculationFailure('فشل في تحديث بيانات الري'));
    }
  }

  Future<void> updateSegmentEquipmentCost({
    required double newEquipmentCost,
  }) async {
    emit(SegmentUpdateCalculationLoading());
    try {
      await _firebaseService.updateEquipmentCost(
        sectorId: selectedSector!.id,
        segmentId: selectedSegment!.id,
        newEquipmentCost: newEquipmentCost,
      );
      emit(SegmentUpdateCalculationSuccess());
      await updateSegmentsAndSetIntitial();
    } catch (e) {
      emit(SegmentUpdateCalculationFailure('فشل في تحديث تكلفة المعدات'));
    }
  }

  Future<void> updateContractorPersonCost(double cost) async {
  emit(SegmentUpdateCalculationLoading());
  try {
    await _firebaseService.updateContractorPersonCost(
      sectorId: selectedSector!.id,
      segmentId: selectedSegment!.id,
      cost: cost,
    );
    emit(SegmentUpdateCalculationSuccess());
    await updateSegmentsAndSetIntitial();
  } catch (e) {
    emit(SegmentUpdateCalculationFailure('فشل في تحديث تكلفة مقاول الأفراد'));
  }
}
Future<void> updateLaborCosts({
  required double fertilizingCost,
  required double landWorkCost,
  required int fertlizingHours,
  required double contractorCost,
}) async {
  emit(SegmentUpdateCalculationLoading());
  try {
    await _firebaseService.updateLaborCostsForSegment(
      sectorId: selectedSector!.id,
      segmentId: selectedSegment!.id,
      fertilizingCost: fertilizingCost,
      landWorkCost: landWorkCost,
      fertlizingHours: fertlizingHours,
      contractorCost: contractorCost,
    );
    emit(SegmentUpdateCalculationSuccess());
    await updateSegmentsAndSetIntitial();
  } catch (e) {
    emit(SegmentUpdateCalculationFailure('فشل في تحديث تكاليف العمالة'));
  }
}



  Future<void> updateSegmentsAndSetIntitial() async {
    await fetchSegments(selectedSector!.id);
    setInitialSegment(
      selectedSector!,
      segments.firstWhere((s) => s.id == selectedSegment!.id),
    );
  }

  @override
  Future<void> close() {
    _instance = null;
    return super.close();
  }
}
