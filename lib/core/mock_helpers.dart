import '../core/app_exception.dart';
 
/// Pretend the network is slow so you can see your loading states.
Future<void> mockDelay([int ms = 600]) =>
    Future<void>.delayed(Duration(milliseconds: ms));
 
/// Set simulateErrors = true to test your error screens, then set it back.
class MockConfig {
  static bool simulateErrors = false;
 
  static void maybeFail() {
    if (simulateErrors) {
      throw const AppException(
        'server_error',
        'Something went wrong (mock)',
        statusCode: 500,
      );
    }
  }
}
 