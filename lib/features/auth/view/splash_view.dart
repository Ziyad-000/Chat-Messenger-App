import 'dart:async';
import 'package:chat_messenger_app/core/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.phoneAuth);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Image.asset('assets/images/logo.png', width: 150, height: 150),
            const SizedBox(height: 8),
            Text(
              'Messenger',
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Stay connected, always',
              style: TextStyle(
                color: theme.textTheme.bodySmall?.color?.withAlpha(200),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 40),
            SpinKitThreeBounce(color: theme.colorScheme.primary, size: 25.0),
            const SizedBox(height: 8),
            Text(
              'Loading',
              style: TextStyle(
                color: theme.textTheme.bodySmall?.color,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: theme.textTheme.bodySmall?.color?.withAlpha(200),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
