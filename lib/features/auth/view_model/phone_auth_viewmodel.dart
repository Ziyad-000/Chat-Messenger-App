import 'package:chat_messenger_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class PhoneAuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  // --- State Variables ---
  bool _isLoading = false;
  String? _errorMessage;

  // --- Getters ---
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // --- Phone Authentication Method ---
  Future<void> verifyPhoneNumber({
    required String countryCode,
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final fullPhoneNumber = "+$countryCode$phoneNumber";

    await _authService.verifyPhoneNumber(
      phoneNumber: fullPhoneNumber,
      onCodeSent: (verificationId) {
        _isLoading = false;
        notifyListeners();
        onCodeSent(verificationId);
      },
      onVerificationFailed: (e) {
        _isLoading = false;
        _errorMessage = e.message ?? "An unknown error occurred";
        notifyListeners();
      },
    );
  }

  // --- Google Sign-In Method ---
  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final userCredential = await _authService.signInWithGoogle();
      _isLoading = false;
      notifyListeners();
      // Returns true if sign-in was successful (userCredential is not null)
      return userCredential != null;
    } catch (e) {
      _errorMessage = "Failed to sign in with Google. Please try again.";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
