class SignupUser {
  final String? name;
  final String? email;
  final String? password;
 final  String ? avatar;

  SignupUser({
    required this.name,
    required this.email,
    required this.password,
    this.avatar, 
  });

  factory SignupUser.fromJson(Map<String, dynamic> json) {
    return SignupUser(
      avatar: json['avatar'],
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
      'avatar': avatar,
    };
  }
}
