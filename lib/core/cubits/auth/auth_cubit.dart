import 'dart:convert';

import 'package:farm_project/core/cubits/auth/auth_states.dart';
import 'package:farm_project/core/models/user_model.dart';
import 'package:farm_project/core/services/firebase_auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthCubit extends Cubit<AuthState> {
  static final AuthCubit _singleton = AuthCubit._internal();
  factory AuthCubit() => _singleton;
  AuthCubit._internal() : super(AuthInitial());

  final FirebaseAuthService _authService = FirebaseAuthService();
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  bool get isAdmin => _currentUser?.role == 'admin';

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _authService.signInWithEmail(email, password);
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailure('User is null'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
  Future<void> loginWithPhone(String phone, String password) async {
   emit(AuthMobileLoginLoading());
    try {
      final user = await _authService.loginWithPhone(phone, password);
      if (user != null) {
        _currentUser = user;
        await _saveUserToPrefs(user);
        emit(AuthMobileLoginSuccess());
      } else {
        emit(AuthMobileLoginFailure('User not found'));
      }
    } catch (e) {
      emit(AuthMobileLoginFailure(e.toString()));
    }
}

 Future<void> tryAutoLogin() async {
    final user = await _getUserFromPrefs();
    if (user != null) {
      _currentUser = user;
      emit(AuthMobileLoginSuccess());
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    emit(AuthInitial());
  }

  Future<void> _saveUserToPrefs(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(user.toJson()));
  }

  Future<UserModel?> _getUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson == null) return null;
    return UserModel.fromJson(jsonDecode(userJson));
  }
}
