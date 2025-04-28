import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_project/core/models/sector_model.dart';
import 'package:farm_project/core/models/segment_model.dart';
import 'package:farm_project/core/models/palm_model.dart';
import 'package:farm_project/core/models/generator_model.dart';
import 'package:farm_project/core/models/fertilizer_model.dart';
import 'package:farm_project/core/models/irrigation_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ----------------- Sector -----------------

  Future<void> addSector(SectorModel sector) async {
    await _firestore.collection('sectors').doc(sector.id).set(sector.toJson());
  }

  Future<List<SectorModel>> getSectors() async {
    final snapshot = await _firestore.collection('sectors').get();
    return snapshot.docs
        .map((doc) => SectorModel.fromJson(doc.data()))
        .toList();
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
    final snapshot = await _firestore
        .collection('sectors')
        .doc(sectorId)
        .collection('segments')
        .get();
    return snapshot.docs
        .map((doc) => SegmentModel.fromJson(doc.data()))
        .toList();
  }

  // ----------------- Palm -----------------

  Future<void> addPalm(String sectorId, String segmentId, PalmModel palm) async {
    final palmsCollection = _firestore
        .collection('sectors')
        .doc(sectorId)
        .collection('segments')
        .doc(segmentId)
        .collection('palms');

    await palmsCollection.add(palm.toJson());
  }

  Future<List<PalmModel>> getPalms(String sectorId, String segmentId) async {
    final snapshot = await _firestore
        .collection('sectors')
        .doc(sectorId)
        .collection('segments')
        .doc(segmentId)
        .collection('palms')
        .get();
    return snapshot.docs
        .map((doc) => PalmModel.fromJson(doc.data()))
        .toList();
  }

  // ----------------- Generator -----------------

  Future<void> addGenerator(String sectorId, String segmentId, GeneratorModel generator) async {
    final generatorCollection = _firestore
        .collection('sectors')
        .doc(sectorId)
        .collection('segments')
        .doc(segmentId)
        .collection('generators');

    await generatorCollection.add(generator.toJson());
  }

  Future<List<GeneratorModel>> getGenerators(String sectorId, String segmentId) async {
    final snapshot = await _firestore
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

  Future<void> addFertilizer(String sectorId, String segmentId, String generatorId, FertilizerModel fertilizer) async {
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

  Future<List<FertilizerModel>> getFertilizers(String sectorId, String segmentId, String generatorId) async {
    final snapshot = await _firestore
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

  Future<void> addIrrigation(String sectorId, String segmentId, IrrigationModel irrigation) async {
    final irrigationCollection = _firestore
        .collection('sectors')
        .doc(sectorId)
        .collection('segments')
        .doc(segmentId)
        .collection('irrigations');

    await irrigationCollection.add(irrigation.toJson());
  }

  Future<List<IrrigationModel>> getIrrigations(String sectorId, String segmentId) async {
    final snapshot = await _firestore
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
