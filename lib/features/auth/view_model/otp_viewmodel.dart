import 'dart:async';
import 'package:chat_messenger_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? _errorMessage;
  late Timer _timer;
  int _countdown = 30;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get countdown => _countdown;
  bool get canResend => _countdown == 0;

  OtpViewModel() {
    startTimer();
  }

  void startTimer() {
    _countdown = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        _countdown--;
        notifyListeners();
      } else {
        _timer.cancel();
      }
    });
  }

  void resendCode(String phoneNumber) {
    if (canResend) {
      _errorMessage = null;
      _authService.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        onCodeSent: (String verificationId) {},
        onVerificationFailed: (FirebaseAuthException e) {
          _errorMessage = e.message;
          notifyListeners();
        },
      );
      startTimer();
      notifyListeners();
    }
  }

  Future<bool> verifyOtp(String verificationId, String smsCode) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _authService.signInWithOtp(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = "Code verification failed. Please try again.";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
