import 'package:controle_de_abastecimento/features/auth/infrastructure/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  final AuthService _authService;
  bool isLoading = false;
  String? errorMessage;

  AuthController(this._authService);

  Future<void> signIn(String email, String password) async {
    errorMessage = null;
    isLoading = true;
    notifyListeners();
    try {
      await _authService.signIn(email, password);
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;
    } catch (e) {
      errorMessage = "Usuário ou senha inválidos.";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(String email, String password) async {
    errorMessage = null;
    isLoading = true;
    notifyListeners();
    try {
      await _authService.register(email, password);
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;
    } catch (e) {
      errorMessage = "Registro inválido, tente novamente...";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
