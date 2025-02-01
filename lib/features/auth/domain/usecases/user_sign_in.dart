import 'package:blog_app_revision/core/error/failure.dart';
import 'package:blog_app_revision/core/usecase/use_case.dart';
import 'package:blog_app_revision/features/auth/domain/entities/user.dart';
import 'package:blog_app_revision/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignIn implements UseCase<User, UserSignInParams> {
  final AuthRepository authRepository;
  UserSignIn(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async {
    return await authRepository.signInWithEmailAndPassword(
         email: params.email, password: params.password);
  }
}

class UserSignInParams {
  final String email;
  final String password;
  UserSignInParams({
    required this.email,
    required this.password,
  });
}
