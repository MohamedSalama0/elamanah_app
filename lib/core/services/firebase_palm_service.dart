import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebasePalmService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload or update image and return its URL
  Future<String> uploadPalmImage({
    required File imageFile,
    required String sectorId,
    required String segmentId,
    required int coordX,
    required int coordY,
    String? existingImageUrl,
  }) async {
    try {
      // Construct unique path using coordinates
      final fileName = 'palm_${coordX}_$coordY.jpg';
      final path = 'palms/$sectorId/$segmentId/$fileName';
      final ref = _storage.ref().child(path);

      // Delete the existing image if it's stored in Firebase Storage
      if (existingImageUrl != null && existingImageUrl.contains('firebase')) {
        try {
          await _storage.refFromURL(existingImageUrl).delete();
        } catch (_) {
          // Ignore deletion errors (e.g., file not found)
        }
      }

      await ref.putFile(imageFile);
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Image upload failed: $e');
    }
  }

 
}
