import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class HomeRepository {
  Future<void> fetchCurrentUserAttributes() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      for (final element in result) {
        print('key: ${element.userAttributeKey}; value: ${element.value}');
      }
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> fetchAuthSession() async {
    try {
      final result = await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true),
      );

      // accessToken + idToken + refreshToken
      AWSCognitoUserPoolTokens userPoolTokens =
          (result as CognitoAuthSession).userPoolTokens!;

      safePrint('userPoolTokens: ${userPoolTokens}');
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  Future<void> getCurrentUser() async {
    try {
      final user = await Amplify.Auth.getCurrentUser();

      safePrint('user: ${user}');
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> signOutCurrentUser() async {
    try {
      await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      print(e.message);
    }
  }
}
