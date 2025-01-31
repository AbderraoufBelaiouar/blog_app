import 'package:blog_app_revision/core/theme/app_pallete.dart';
import 'package:blog_app_revision/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:blog_app_revision/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
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
              'Sign Up.',
              style: TextStyle(fontSize: 52, fontWeight: FontWeight.bold),
            ),
            Form(
              key: _formKey,
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Authfield(
                    controller: _nameController,
                    hintText: 'Name',
                  ),
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
              text: 'Sign Up',
              onTap: () {},
            ),
            RichText(
              text: TextSpan(
                text: 'Already have An Account? ',
                style: Theme.of(context).textTheme.titleMedium,
                children: [
                  TextSpan(
                    text: 'Sign In',
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
