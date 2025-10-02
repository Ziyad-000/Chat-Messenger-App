import 'package:chat_messenger_app/core/constants/app_routes.dart';
import 'package:chat_messenger_app/features/auth/view_model/phone_auth_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneAuthView extends StatelessWidget {
  const PhoneAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final countryCodeController = TextEditingController(text: '20');
    final phoneController = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) => PhoneAuthViewModel(),
      child: Scaffold(
        body: SafeArea(
          child: Consumer<PhoneAuthViewModel>(
            builder: (context, viewModel, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Image.asset('assets/images/Container.png', height: 80),
                      const SizedBox(height: 24),
                      Text(
                        "Welcome",
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Enter your phone number to get started",
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Phone Number",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          SizedBox(
                            width: 60,
                            child: TextField(
                              controller: countryCodeController,
                              keyboardType: TextInputType.phone,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleLarge?.copyWith(
                                letterSpacing: 2.0,
                              ),
                              decoration: const InputDecoration(
                                prefixText: '+',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              style: theme.textTheme.titleLarge?.copyWith(
                                letterSpacing: 2.0,
                              ),
                              decoration: const InputDecoration(
                                hintText: "(100) 123-4567",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey.shade700, height: 1),

                      if (viewModel.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            viewModel.errorMessage!,
                            style: TextStyle(color: theme.colorScheme.error),
                          ),
                        ),
                      const SizedBox(height: 80),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: viewModel.isLoading
                            ? null
                            : () {
                                viewModel.verifyPhoneNumber(
                                  countryCode: countryCodeController.text
                                      .trim(),
                                  phoneNumber: phoneController.text.trim(),
                                  onCodeSent: (verificationId) {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.otp,
                                      arguments: {
                                        'verificationId': verificationId,
                                        'phoneNumber':
                                            "${countryCodeController.text.trim()}${phoneController.text.trim()}",
                                      },
                                    );
                                  },
                                );
                              },
                        child: viewModel.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Continue",
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.arrow_forward),
                                ],
                              ),
                      ),
                      const SizedBox(height: 16),
                      Text("OR", style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: viewModel.isLoading
                            ? null
                            : () async {
                                final success = await viewModel
                                    .signInWithGoogle();
                                if (success && context.mounted) {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    AppRoutes.chat,
                                    (route) => false,
                                  );
                                }
                                final user = FirebaseAuth.instance.currentUser;

                                if (user != null) {
                                  final snackBar = SnackBar(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      'Welcome, ${user.email ?? 'User'}!',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(snackBar);
                                }
                              },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/google_logo.png',
                              height: 24.0,
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: Text(
                                "Sign in with Google",
                                style: TextStyle(color: theme.primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),
                      Text(
                        "By continuing, you agree to our Terms of Service\nand Privacy Policy",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
