import 'package:blog_app_revision/core/constants/constants.dart';
import 'package:blog_app_revision/core/error/exception.dart';
import 'package:blog_app_revision/core/error/failure.dart';
import 'package:blog_app_revision/core/network/connection_checker.dart';
import 'package:blog_app_revision/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app_revision/core/common/entities/user.dart';
import 'package:blog_app_revision/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImplementation(
      this.authRemoteDataSource, this.connectionChecker);
  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(
      () async => await authRemoteDataSource.signUpWithEmailAndPassword(
          name: name, email: email, password: password),
    );
  }

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return _getUser(
      () async => await authRemoteDataSource.signInWithEmailAndPassword(
          email: email, password: password),
    );
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noInternetConnectionessage));
      }
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await connectionChecker.isConnected) {
        final session = authRemoteDataSource.currentUserSession;
        if (session == null) {
          return left(Failure("User not logged in"));
        }
        return right(User(
            id: session.user.id, name: '', email: session.user.email ?? ''));
      }
      final user = await authRemoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure("User not logged in"));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
