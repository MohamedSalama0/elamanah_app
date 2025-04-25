import 'package:farm_project/core/cubits/auth/auth_states.dart';
import 'package:farm_project/core/services/firebase_auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthCubit extends Cubit<AuthState> {
  static final AuthCubit _singleton = AuthCubit._internal();
  factory AuthCubit() => _singleton;
  AuthCubit._internal() : super(AuthInitial());

  final FirebaseAuthService _authService = FirebaseAuthService();

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
}
