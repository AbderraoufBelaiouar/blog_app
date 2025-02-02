import 'package:blog_app_revision/core/error/failure.dart';
import 'package:blog_app_revision/core/usecase/use_case.dart';
import 'package:blog_app_revision/core/common/entities/user.dart';
import 'package:blog_app_revision/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
