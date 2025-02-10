part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    anonKey: AppSecrets.supabaseAnonKey,
    url: AppSecrets.supabaseUrl,
  );
  await Hive.initFlutter();
  var settingsBox=  await Hive.openBox('blogs');
  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => InternetConnection());
  serviceLocator.registerLazySingleton(() => settingsBox);
  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionChecker>(() =>
      ConnectionCheckerImplementation(serviceLocator<InternetConnection>()));
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
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImplementation(
        serviceLocator(),
      ),
    )
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImplementation(
        serviceLocator(),
        serviceLocator(),
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
