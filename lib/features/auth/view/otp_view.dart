import 'package:chat_messenger_app/features/auth/view_model/otp_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_routes.dart';

class OtpView extends StatelessWidget {
  final String verificationId;
  final String phoneNumber;

  const OtpView({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final otpController = TextEditingController();
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: theme.textTheme.headlineSmall?.copyWith(
        color: theme.colorScheme.onSurface,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 2, color: Colors.grey.shade700),
        ),
      ),
    );

    return ChangeNotifierProvider(
      create: (_) => OtpViewModel(),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text("Change number"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Consumer<OtpViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  children: [
                    const Spacer(flex: 1),
                    Image.asset(
                      'assets/images/Container.png',
                      height: 80,
                      width: 80,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Verify your number",
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "We sent a code to +$phoneNumber",
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 48),
                    Text(
                      "Enter verification code",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        length: 6,
                        controller: otpController,
                        autofocus: true,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            border: Border(
                              bottom: BorderSide(
                                width: 2,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    viewModel.canResend
                        ? TextButton(
                            onPressed: () => viewModel.resendCode(phoneNumber),
                            child: const Text("Resend code"),
                          )
                        : Text(
                            "Resend code in ${viewModel.countdown}s",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                            ),
                          ),

                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                      ),
                      onPressed: viewModel.isLoading
                          ? null
                          : () async {
                              final success = await viewModel.verifyOtp(
                                verificationId,
                                otpController.text,
                              );
                              if (success && context.mounted) {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRoutes.chat,
                                  (route) => false,
                                );
                              }
                            },
                      child: viewModel.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Verify & Continue",
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),

                    if (viewModel.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          viewModel.errorMessage!,
                          style: TextStyle(color: theme.colorScheme.error),
                        ),
                      ),
                    const Spacer(flex: 2),
                    Text(
                      "Didn't receive the code? Check your phone or try resending",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
