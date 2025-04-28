import 'package:farm_project/core/models/sector_model.dart';
import 'package:farm_project/core/models/segment_model.dart';
import 'package:farm_project/core/models/palm_model.dart';
import 'package:farm_project/core/services/firebase_service.dart';
import 'package:uuid/uuid.dart';

class DummyDataUploaderService {
  final FirebaseService _firebaseService = FirebaseService();
  final Uuid _uuid = const Uuid();

  Future<void> uploadDummyData() async {
    for (int sectorIndex = 1; sectorIndex <= 4; sectorIndex++) {
      final sectorId = _uuid.v4();
      final sector = SectorModel(
        id: sectorId,
        name: 'قطاع $sectorIndex',
        description: 'وصف القطاع $sectorIndex',
      );

      await _firebaseService.addSector(sector);

      for (int segmentIndex = 1; segmentIndex <= 5; segmentIndex++) {
        final segmentId = _uuid.v4();
        final segment = SegmentModel(
          id: segmentId,
          name: 'قطعة $segmentIndex',
          description: 'وصف القطعة $segmentIndex',
          horizontalPalms: 5,
          verticalPalms: 5,
          sizeInFaddan: 2.5,
          personType: 1, // 1 = contractor
          personCost: 500,
          landServiceCost: 300,
          equipmentUsedCost: 200,
        );

        await _firebaseService.addSegment(sectorId, segment);

        // Upload Palms for each segment
        for (int x = 0; x < 5; x++) {
          for (int y = 0; y < 5; y++) {
            final palm = PalmModel(
              coordX: x,
              coordY: y,
              waterCharge: 10.0,
              fertilizeCharge: 5.0,
              contractorCharge: 8.0,
              electricityCharge: 4.0,
              irrigateCharge: 6.0,
              landCharge: 3.0,
            );

            await _firebaseService.addPalm(sectorId, segmentId, palm);
          }
        }
      }
    }
  }
}
