import 'package:flutter_boilerplate/domain/models/user.dart';

abstract class UserRepository {
  Future<UserModel> createUser(UserModel user);
  Future<UserModel?> findOneUser(Map<String, dynamic> filters);
  Future<UserModel> updateUser(UserModel user);
  Future<void> deleteUser(String id);
  Future<List<UserModel>> findManyUsers(Map<String, dynamic> filters);
}
