import 'package:blog_app_revision/core/secrets/app_secrets.dart';
import 'package:blog_app_revision/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app_revision/features/auth/data/repository/auth_repository_implementation.dart';
import 'package:blog_app_revision/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app_revision/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app_revision/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    anonKey: AppSecrets.supabaseAnonKey,
    url: AppSecrets.supabaseUrl,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImplementation(
      supabaseClient: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImplementation(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
    ),
  );
}
