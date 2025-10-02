import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
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
            Spacer(),
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
