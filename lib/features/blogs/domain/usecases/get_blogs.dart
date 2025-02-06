import 'package:blog_app_revision/core/error/failure.dart';
import 'package:blog_app_revision/core/usecase/use_case.dart';
import 'package:blog_app_revision/features/blogs/domain/entities/blog.dart';
import 'package:blog_app_revision/features/blogs/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;
  GetBlogs(this.blogRepository);
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getBlogs();
  }
}
