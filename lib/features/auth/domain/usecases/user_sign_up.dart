import 'package:blog_app_revision/core/error/failure.dart';
import 'package:blog_app_revision/core/usecase/use_case.dart';
import 'package:blog_app_revision/features/auth/domain/entities/user.dart';
import 'package:blog_app_revision/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailAndPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;
  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
