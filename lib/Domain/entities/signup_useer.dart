class SignupUser {
  final String? name;
  final String? email;
  final String? password;

  SignupUser({
    required this.name,
    required this.email,
    required this.password,
  });

  factory SignupUser.fromJson(Map<String, dynamic> json) {
    return SignupUser(
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
