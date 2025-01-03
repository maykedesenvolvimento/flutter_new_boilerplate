class UserModel {
  final String id;
  final String name;
  final String email;
  final List<String> roles;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.roles = const [],
  });
}
