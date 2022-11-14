import 'dart:developer';

class UserStorage {
  // final storage = const FlutterSecureStorage();
  Future saveUserCredentials(
      {required String email, required String password}) async {
    // await storage.write(key: 'email', value: email);
    // await storage.write(key: 'password', value: password);
  }

  Future<bool> userHasCredentials() async {
    log('Checking if user has credentials');
    String email = 'teste@teste.com';
    // String? email = await storage.read(key: 'email');
    // ignore: unnecessary_null_comparison
    if (email != null) {
      log('User has credentials. Returning true');
      return true;
    } else {
      log('User doesnt have any credentials. Returning false');
      return false;
    }
  }
}
