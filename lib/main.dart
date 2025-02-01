import 'package:blog_app_revision/core/secrets/app_secrets.dart';
import 'package:blog_app_revision/core/theme/app_theme.dart';
import 'package:blog_app_revision/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app_revision/features/auth/data/repository/auth_repository_implementation.dart';
import 'package:blog_app_revision/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app_revision/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app_revision/features/auth/presentation/views/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    anonKey: AppSecrets.supabaseAnonKey,
    url: AppSecrets.supabaseUrl,
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthBloc(
          userSignUp: UserSignUp(
            AuthRepositoryImplementation(
              AuthRemoteDataSourceImplementation(
                supabaseClient: supabase.client,
              ),
            ),
          ),
        ),
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
