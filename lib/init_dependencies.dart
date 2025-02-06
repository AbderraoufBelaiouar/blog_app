import 'package:blog_app_revision/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app_revision/core/secrets/app_secrets.dart';
import 'package:blog_app_revision/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app_revision/features/auth/data/repository/auth_repository_implementation.dart';
import 'package:blog_app_revision/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app_revision/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app_revision/features/auth/domain/usecases/user_sign_in.dart';
import 'package:blog_app_revision/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app_revision/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app_revision/features/blogs/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app_revision/features/blogs/data/repository/blog_repository_implementation.dart';
import 'package:blog_app_revision/features/blogs/domain/repository/blog_repository.dart';
import 'package:blog_app_revision/features/blogs/domain/usecases/get_blogs.dart';
import 'package:blog_app_revision/features/blogs/domain/usecases/upload_blog.dart';
import 'package:blog_app_revision/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    anonKey: AppSecrets.supabaseAnonKey,
    url: AppSecrets.supabaseUrl,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImplementation(
        supabaseClient: serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImplementation(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignIn(
        serviceLocator(),
      ),
    )
    ..registerFactory(() => CurrentUser(serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImplementation(
        supabaseClient: serviceLocator(),
      ),
    )
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImplementation(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UploadBlog(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetBlogs(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getBlogs: serviceLocator(),

      ),
    );
}
