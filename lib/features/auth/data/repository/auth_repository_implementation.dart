import 'package:blog_app_revision/core/error/exception.dart';
import 'package:blog_app_revision/core/error/failure.dart';
import 'package:blog_app_revision/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app_revision/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImplementation(this.authRemoteDataSource);
  @override
  Future<Either<Failure, String>> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final userId = await authRemoteDataSource.signUpWithEmailAndPassword(
          name: name, email: email, password: password);
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    throw UnimplementedError();
  }
}
