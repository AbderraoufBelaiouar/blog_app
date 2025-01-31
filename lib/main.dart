import 'package:blog_app_revision/core/theme/app_theme.dart';
import 'package:blog_app_revision/features/auth/presentation/views/sign_in_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SignInView(),
    );
  }
}
