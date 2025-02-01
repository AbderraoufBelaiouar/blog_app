import 'package:blog_app_revision/core/theme/app_theme.dart';
import 'package:blog_app_revision/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app_revision/features/auth/presentation/views/sign_in_view.dart';
import 'package:blog_app_revision/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => serviceLocator<AuthBloc>(),
      )
    ],
    child: const MyApp(),
  ));
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
