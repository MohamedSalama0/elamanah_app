import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_project/core/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }
Future<UserModel?> loginWithPhone(String phone, String password) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('phone', isEqualTo: phone)
          .where('password', isEqualTo: password)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        throw Exception('رقم الهاتف أو كلمة المرور غير صحيحة');
      }

      final doc = snapshot.docs.first;
      return UserModel.fromJson(doc.data());
    } catch (e) {
      rethrow;
    }
  }

}
