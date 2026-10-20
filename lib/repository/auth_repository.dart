import '../core/app_exception.dart';
import '../core/mock_helpers.dart';
import '../models/user.dart';
 
abstract class AuthRepository {
  Future<AuthSession> login({required String email, required String password});
 
  Future<AuthSession> register({
    required String name,
    required String email,
    String? phone,
    required String password,
  });
 
  Future<User> getMe();
 
  Future<User> updateMe({String? name, String? phone});
 
  Future<void> logout();
}
 
/// Fake version, used until the real backend is ready.
class MockAuthRepository implements AuthRepository {
  User? _user;
 
  AuthSession _session(User user) => AuthSession(
        user: user,
        accessToken: 'mock-access-token',
        refreshToken: 'mock-refresh-token',
        expiresIn: 3600,
      );
 
  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    await mockDelay();
    MockConfig.maybeFail();
    if (!email.contains('@') || password.length < 6) {
      throw const AppException(
        'invalid_credentials',
        'Invalid email or password',
        statusCode: 401,
      );
    }
    _user = User(id: 1, name: 'Asha', email: email, phone: '9876543210');
    return _session(_user!);
  }
 
  @override
  Future<AuthSession> register({
    required String name,
    required String email,
    String? phone,
    required String password,
  }) async {
    await mockDelay();
    MockConfig.maybeFail();
    if (email == 'taken@example.com') {
      throw const AppException(
        'email_taken',
        'This email is already registered',
        statusCode: 409,
      );
    }
    if (!email.contains('@') || password.length < 6) {
      throw AppException(
        'validation_error',
        'Please fix the errors',
        statusCode: 422,
        fields: {
          if (!email.contains('@')) 'email': 'Invalid email format',
          if (password.length < 6) 'password': 'At least 6 characters',
        },
      );
    }
    _user = User(id: 1, name: name, email: email, phone: phone);
    return _session(_user!);
  }
 
  @override
  Future<User> getMe() async {
    await mockDelay(300);
    MockConfig.maybeFail();
    final user = _user;
    if (user == null) {
      throw const AppException('token_expired', 'Please log in again', statusCode: 401);
    }
    return user;
  }
 
  @override
  Future<User> updateMe({String? name, String? phone}) async {
    await mockDelay();
    MockConfig.maybeFail();
    final user = _user;
    if (user == null) {
      throw const AppException('token_expired', 'Please log in again', statusCode: 401);
    }
    _user = user.copyWith(name: name, phone: phone);
    return _user!;
  }
 
  @override
  Future<void> logout() async {
    _user = null;
  }
}
 