class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
  });
 
  final int id; // change to String if the backend uses UUIDs
  final String name;
  final String email;
  final String? phone;
 
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int,
        name: json['name'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String?,
      );
 
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
      };
 
  User copyWith({String? name, String? phone}) => User(
        id: id,
        name: name ?? this.name,
        email: email,
        phone: phone ?? this.phone,
      );
}
 
/// Response of /auth/login and /auth/register.
class AuthSession {
  const AuthSession({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });
 
  final User user;
  final String accessToken;
  final String refreshToken;
  final int expiresIn; // seconds
 
  factory AuthSession.fromJson(Map<String, dynamic> json) => AuthSession(
        user: User.fromJson(json['user'] as Map<String, dynamic>),
        accessToken: json['access_token'] as String,
        refreshToken: json['refresh_token'] as String,
        expiresIn: json['expires_in'] as int,
      );
}