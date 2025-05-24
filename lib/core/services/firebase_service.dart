import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_project/core/models/farm_config_model.dart';
import 'package:farm_project/core/models/sector_model.dart';
import 'package:farm_project/core/models/segment_model.dart';
import 'package:farm_project/core/models/palm_model.dart';
import 'package:farm_project/core/models/generator_model.dart';
import 'package:farm_project/core/models/fertilizer_model.dart';
import 'package:farm_project/core/models/irrigation_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ----------------- AppConfig -----------------

Future<FarmConfigModel> fetchFarmConfig() async {
 
       // Reference to the 'configs' collection
    CollectionReference configsRef = FirebaseFirestore.instance.collection('configs');
    
    // Get the first document (assuming you only want one config)
    DocumentSnapshot generator = await configsRef.doc('generator').get();
    DocumentSnapshot constant_worker= await configsRef.doc('constant_worker').get();
    return FarmConfigModel.fromJson(
      {
        'generator': generator.data() as Map<String,dynamic>,
        'constant_worker': constant_worker.data() as Map<String,dynamic>
      }
    );


 // if (!doc.exists) throw Exception('Config not found');

}



Future<void> updateConstantWorker({
  required Map<String, dynamic> data,
}) async {
  final ref = _firestore
      .collection('configs')
      .doc('constant_worker');
     

  await ref.update(data);
}


  // ----------------- Sector -----------------

  Future<void> addSector(SectorModel sector) async {
    await _firestore.collection('sectors').doc(sector.id).set(sector.toJson());
  }

  Future<List<SectorModel>> getSectors() async {
    final snapshot = await _firestore.collection('sectors').get();
    final sectors =
        snapshot.docs.map((doc) => SectorModel.fromJson(doc.data())).toList();
    sectors.sort((a, b) {
      final cmpX = a.name.compareTo(b.name);
      return cmpX;
    });
    return sectors;
  }

  // ----------------- Segment -----------------

  Future<void> addSegment(String sectorId, SegmentModel segment) async {
    await _firestore
        .collection('sectors')
        .doc(sectorId)
        .collection('segments')
        .doc(segment.id)
        .set(segment.toJson());
  }

  Future<List<SegmentModel>> getSegments(String sectorId) async {
    final snapshot =
        await _firestore
            .collection('sectors')
            .doc(sectorId)
            .collection('segments')
            .get();
    final segments =
        snapshot.docs.map((doc) => SegmentModel.fromJson(doc.data())).toList();
    segments.sort((a, b) {
      final cmpX = a.name.compareTo(b.name);
      return cmpX;
    });
    return segments;
  }

  Future<void> updateIrrigationForSegment({
    required String sectorId,
    required String segmentId,
    required List<IrrigationModel> irrigationList,
    required double irrigationTransportCost,
  }) async {
    final segmentRef = _firestore
        .collection('sectors')
        .doc(sectorId)
        .collection('segments')
        .doc(segmentId);

    final irrigationJson = irrigationList.map((e) => e.toJson()).toList();

    await segmentRef.update({
      'irrigationItems': irrigationJson,
      'irrigationTransportCost': irrigationTransportCost,
    });
  }
  Future<void> updateEquipmentCost({
  required String sectorId,
  required String segmentId,
  required double newEquipmentCost,
}) async {
  final segmentRef = _firestore
      .collection('sectors')
      .doc(sectorId)
      .collection('segments')
      .doc(segmentId);

  await segmentRef.update({
    'equipmentUsedCost': newEquipmentCost,
  });
}
Future<void> updateGenerator({
  required Map<String, dynamic> generatorData,
}) async {
  final ref = _firestore
      .collection('configs')
      .doc('generator');
     

  await ref.update(generatorData);
}

Future<void> updateContractorPersonCost({
  required String sectorId,
  required String segmentId,
  required double cost,
}) async {
  await _firestore
      .collection('sectors')
      .doc(sectorId)
      .collection('segments')
      .doc(segmentId)
      .update({'contractorPersonsCost': cost});
}

Future<void> updateLaborCostsForSegment({
  required String sectorId,
  required String segmentId,
  required double fertilizingCost,
  required double landWorkCost,
  required int fertlizingHours,
  required double contractorCost,
}) async {
  await _firestore
      .collection('sectors')
      .doc(sectorId)
      .collection('segments')
      .doc(segmentId)
      .update({
        'fertilizingPrice': fertilizingCost,
        'landWorkPrice': landWorkCost,
        'fertlizingHours': fertlizingHours,
        'contractorPersonsCost': contractorCost,
      });
}



  // ----------------- Palm -----------------

  Future<void> addPalm(
    String sectorId,
    String segmentId,
    PalmModel palm,
  ) async {
    final exists = await checkPalmCoordinatesExist(
      sectorId: sectorId,
      segmentId: segmentId,
      coordX: palm.coordX,
      coordY: palm.coordY,
    );

    if (exists) {
      throw Exception('Coordinates already exist for another palm.');
    }

    await _firestore
        .collection('sectors')
        .doc(sectorId)
        .collection('segments')
        .doc(segmentId)
        .collection('palms')
        .doc(palm.id)
        .set(palm.toJson());
  }

  Future<bool> checkPalmCoordinatesExist({
    required String sectorId,
    required String segmentId,
    required int coordX,
    required int coordY,
    String? excludeId, // pass current palm ID when updating to exclude it
  }) async {
    final palmRef = _firestore
        .collection('sectors')
        .doc(sectorId)
        .collection('segments')
        .doc(segmentId)
        .collection('palms');

    final querySnapshot =
        await palmRef
            .where('coordX', isEqualTo: coordX)
            .where('coordY', isEqualTo: coordY)
            .get();

    return querySnapshot.docs.any((doc) => doc.id != excludeId);
  }

  Future<void> updatePalm({
    required String sectorId,
    required String segmentId,
    required PalmModel updatedPalm,
  }) async {
    try {
      final exists = await checkPalmCoordinatesExist(
        sectorId: sectorId,
        segmentId: segmentId,
        coordX: updatedPalm.coordX,
        coordY: updatedPalm.coordY,
        excludeId: updatedPalm.id,
      );

      if (exists) {
        throw Exception('Coordinates already exist for another palm.');
      }

      await _firestore
          .collection('sectors')
          .doc(sectorId)
          .collection('segments')
          .doc(segmentId)
          .collection('palms')
          .doc(updatedPalm.id)
          .update(updatedPalm.toJson());
    } catch (e) {
      throw Exception('Failed to update palm: $e');
    }
  }

  /// Update only the image URL for a palm
  Future<void> updatePalmImage({
    required String sectorId,
    required String segmentId,
    required PalmModel updatedPalm,
    required String newImageUrl,
  }) async {
    try {
      await _firestore
          .collection('sectors')
          .doc(sectorId)
          .collection('segments')
          .doc(segmentId)
          .collection('palms')
          .doc(updatedPalm.id)
          .update({'image': newImageUrl});
    } catch (e) {
      throw Exception('Failed to update palm image: $e');
    }
  }

  Future<List<PalmModel>> getPalms(String sectorId, String segmentId) async {
    try {
      final snapshot =
          await _firestore
              .collection('sectors')
              .doc(sectorId)
              .collection('segments')
              .doc(segmentId)
              .collection('palms')
              .get();

      final palms =
          snapshot.docs
              .map(
                (doc) => PalmModel.fromJson(doc.data(), doc.id),
              ) // pass doc.id
              .toList();

      palms.sort((a, b) {
        final cmpX = a.coordX.compareTo(b.coordX);
        return cmpX != 0 ? cmpX : a.coordY.compareTo(b.coordY);
      });

      return palms;
    } catch (e) {
      throw Exception('Failed to fetch palms: $e');
    }
  }

  // ----------------- Generator -----------------

  Future<void> addGenerator(
    String sectorId,
    String segmentId,
    GeneratorModel generator,
  ) async {
    final generatorCollection = _firestore
        .collection('sectors')
        .doc(sectorId)
        .collection('segments')
        .doc(segmentId)
        .collection('generators');

    await generatorCollection.add(generator.toJson());
  }

  Future<List<GeneratorModel>> getGenerators(
    String sectorId,
    String segmentId,
  ) async {
    final snapshot =
        await _firestore
            .collection('sectors')
            .doc(sectorId)
            .collection('segments')
            .doc(segmentId)
            .collection('generators')
            .get();
    return snapshot.docs
        .map((doc) => GeneratorModel.fromJson(doc.data()))
        .toList();
  }

  // ----------------- Fertilizer -----------------

  Future<void> addFertilizer(
    String sectorId,
    String segmentId,
    String generatorId,
    FertilizerModel fertilizer,
  ) async {
    final fertilizerCollection = _firestore
        .collection('sectors')
        .doc(sectorId)
        .collection('segments')
        .doc(segmentId)
        .collection('generators')
        .doc(generatorId)
        .collection('fertilizers');

    await fertilizerCollection.add(fertilizer.toJson());
  }

  Future<List<FertilizerModel>> getFertilizers(
    String sectorId,
    String segmentId,
    String generatorId,
  ) async {
    final snapshot =
        await _firestore
            .collection('sectors')
            .doc(sectorId)
            .collection('segments')
            .doc(segmentId)
            .collection('generators')
            .doc(generatorId)
            .collection('fertilizers')
            .get();
    return snapshot.docs
        .map((doc) => FertilizerModel.fromJson(doc.data()))
        .toList();
  }

  // ----------------- Irrigation -----------------

  Future<void> addIrrigation(
    String sectorId,
    String segmentId,
    IrrigationModel irrigation,
  ) async {
    final irrigationCollection = _firestore
        .collection('sectors')
        .doc(sectorId)
        .collection('segments')
        .doc(segmentId)
        .collection('irrigations');

    await irrigationCollection.add(irrigation.toJson());
  }

  Future<List<IrrigationModel>> getIrrigations(
    String sectorId,
    String segmentId,
  ) async {
    final snapshot =
        await _firestore
            .collection('sectors')
            .doc(sectorId)
            .collection('segments')
            .doc(segmentId)
            .collection('irrigations')
            .get();
    return snapshot.docs
        .map((doc) => IrrigationModel.fromJson(doc.data()))
        .toList();
  }
}
