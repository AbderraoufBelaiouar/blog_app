import 'package:blog_app_revision/core/theme/app_pallete.dart';
import 'package:blog_app_revision/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:blog_app_revision/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign In.',
              style: TextStyle(fontSize: 52, fontWeight: FontWeight.bold),
            ),
            Form(
              key: _formKey,
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                
                  Authfield(
                    controller: _emailController,
                    hintText: 'Email',
                  ),
                  Authfield(
                    controller: _passwordController,
                    hintText: 'Password',
                  ),
                ],
              ),
            ),
            AuthGradientButton(
              text: 'Sign In',
              onTap: () {},
            ),
            RichText(
              text: TextSpan(
                text: 'Don\'t have An Account? ',
                style: Theme.of(context).textTheme.titleMedium,
                children: [
                  TextSpan(
                    text: 'Sign Up',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppPallete.gradient2,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
