class User {
  final String accessToken;
  final String refreshToken;
  final String email;

  User({
    required this.accessToken,
    required this.refreshToken,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'email': email,
    };
  }
}
