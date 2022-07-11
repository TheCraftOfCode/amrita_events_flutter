class User {
  final String name;
  final String email;
  final String role;

  User(
      {required this.name,
        required this.email,
        required this.role});

  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }
}