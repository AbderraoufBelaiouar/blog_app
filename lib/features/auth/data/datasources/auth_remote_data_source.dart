
import 'package:blog_app_revision/core/error/exception.dart';
import 'package:blog_app_revision/features/auth/data/models/user_model.dart';
import 'package:blog_app_revision/features/auth/domain/entities/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

abstract interface class AuthRemoteDataSource {
  Future<User> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImplementation implements AuthRemoteDataSource {
  final supabase.SupabaseClient supabaseClient;
  AuthRemoteDataSourceImplementation({required this.supabaseClient});
  @override
  Future<User> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(password: password, email: email);

      if (response.user == null) {
        throw ServerException('User is null');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<User> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
final response = await supabaseClient.auth
          .signUp(password: password, email: email, data: {'name': name});
      
      if (response.user == null) {
        throw ServerException('User is null');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
}
