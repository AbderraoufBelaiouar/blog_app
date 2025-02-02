import 'package:blog_app_revision/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<SuccessType, Params> {
Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams{}