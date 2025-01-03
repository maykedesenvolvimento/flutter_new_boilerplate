import 'package:flutter_boilerplate/domain/models/user.dart';
import 'package:flutter_boilerplate/domain/repositories/user.dart';

class UserRepositoryInMemory implements UserRepository {
  final List<UserModel> _users = [];

  @override
  Future<UserModel> createUser(UserModel user) {
    _users.add(user);
    return Future.value(user);
  }

  @override
  Future<void> deleteUser(String id) {
    _users.removeWhere((user) => user.id == id);
    return Future.value();
  }

  @override
  Future<List<UserModel>> findManyUsers(Map<String, dynamic> filters) {
    var filteredUsers = _users;
    if (filters.containsKey('name')) {
      filteredUsers = filteredUsers
          .where((user) => user.name.contains(filters['name']))
          .toList();
    }
    if (filters.containsKey('email')) {
      filteredUsers = filteredUsers
          .where((user) => user.email.contains(filters['email']))
          .toList();
    }
    return Future.value(filteredUsers);
  }

  @override
  Future<UserModel?> findOneUser(Map<String, dynamic> filters) {
    try {
      final user = _users.firstWhere((user) {
        if (filters.containsKey('id')) {
          return user.id == filters['id'];
        }
        if (filters.containsKey('email')) {
          return user.email == filters['email'];
        }
        if (filters.containsKey('name')) {
          return user.name == filters['name'];
        }
        return false;
      });
      return Future.value(user);
    } catch (e) {
      return Future.value(null);
    }
  }

  @override
  Future<UserModel> updateUser(UserModel user) {
    final index = _users.indexWhere((u) => u.id == user.id);
    _users[index] = user;
    return Future.value(user);
  }
}
