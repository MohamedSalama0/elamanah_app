import 'package:farm_project/core/models/sector_model.dart';
import 'package:farm_project/core/models/segment_model.dart';
import 'package:farm_project/core/models/irrigation_model.dart';
import 'package:farm_project/core/models/palm_model.dart';
import 'package:farm_project/core/services/firebase_service.dart';

class DummyDataUploaderService {
  final FirebaseService _firebaseService = FirebaseService();

  Future<void> uploadDummyData() async {
    for (int sectorIndex = 1; sectorIndex <= 1; sectorIndex++) {
      final sector = SectorModel(
        id: sectorIndex.toString(),
        name: 'قطاع $sectorIndex',
        description: 'وصف القطاع $sectorIndex',
      );

      await _firebaseService.addSector(sector);

      for (int segmentIndex = 1; segmentIndex <= 1; segmentIndex++) {
        final segmentId = segmentIndex.toString();

        // Create dummy irrigation items
        final irrigationItems = List.generate(2, (i) {
          return IrrigationModel(
            pipeSize: 2.5,
            segmentId: segmentId,
            length: 100 + i * 10,
            width: 5,
            price: 250.0,
            count: 3,
          );
        });

        final segment = SegmentModel(
          id: segmentId,
          name: 'قطعة $segmentIndex',
          description: 'وصف القطعة $segmentIndex',
          horizontalPalms: 3,
          verticalPalms: 1,
          sizeInFaddan: 2.5,
          personType: 1,
          personCost: 500,
          landServiceCost: 300,
          equipmentUsedCost: 200,

          // Generator details
          generatorTotalHours: 120.5,
          generatorType: 'ابيض',
          generatorName: 'مولد أبيض',
          generatorElectricityInvoice: 750.0,
          generatorOilPrice: 200.0,
          generatorMaintenanceCost: 150.0,
          generatorOilChange: 50.0,
          generatorFiltersCost: 80.0,

          // Agricultural details
          fertilizingPrice: 600.0,
          contractorPersonsCost: 400.0,
          landWorkPrice: 500.0,
          equipmentCost: 350.0,

          // Irrigation
          irrigationTransportCost: 100.0,
          irrigationItems: irrigationItems,
        );

        await _firebaseService.addSegment(sector.id, segment);

        for (int x = 1; x <= 3; x++) {
          for (int y = 1; y <= 1; y++) {
            final palm = PalmModel(
              id: '${x}_$y',
              coordX: x,
              coordY: y,
              waterCharge: 10.0,
              fertilizeCharge: 5.0,
              contractorCharge: 8.0,
              electricityCharge: 4.0,
              irrigateCharge: 6.0,
              landCharge: 3.0,
            );

            await _firebaseService.addPalm(sector.id, segment.id, palm);
          }
        }
      }
    }
  }
}
