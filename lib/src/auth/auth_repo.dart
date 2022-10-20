import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class AuthRepository {
  bool isSignUpComplete = false;
  bool isSignedIn = false;

  // Sign in
  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );

      print("result" + result.isSignedIn.toString());    
      
      if (result.isSignedIn) {
        // get user id
        // return fetchUserIdFromAttributes();
      } else {
        throw Exception('Could not sign in');
      }
      // setState(() {
      //   isSignedIn = result.isSignedIn;
      // });
    } on AuthException catch (e) {
    safePrint(e.message);
  }
  }

  // Sign up
  Future<void> signUp({required String username, required String email, required String password}) async {
    try {
      final userAttributes = <CognitoUserAttributeKey, String>{
        CognitoUserAttributeKey.name: username,
        CognitoUserAttributeKey.email: email,
        // additional attributes as needed
      };
      final result = await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );
      // setState(() {
      //   isSignUpComplete = result.isSignUpComplete;
      // });
    } on AuthException catch (e) {
    safePrint(e.message);
  }
  }

  // Confirm
  Future<void> confirmUser() async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: 'test1',
        confirmationCode: '566231',
      );
      // setState(() {
      //   isSignUpComplete = result.isSignUpComplete;
      // });
    } on AuthException catch (e) {
    safePrint(e.message);
  }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
    } on AuthException {
      rethrow;
    }
  }

  // ID from Attributes
  Future<String> fetchUserIdFromAttributes() async {
    final attributes = await Amplify.Auth.fetchUserAttributes();
    final subAttribute =
        attributes.firstWhere((element) => element.userAttributeKey == 'sub');
    final userId = subAttribute.value;
    return userId;
  }

  // Session
  Future<void> fetchAuthSession() async {
    try {
      final result = await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true),
      );
      String identityId = (result as CognitoAuthSession).identityId!;
      safePrint('identityId: $identityId');
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  // Timeout
  Future<void> fetchAuthSessionWithTimeout() async {
    try {
      final result = await Amplify.Auth.fetchAuthSession().timeout(
        const Duration(seconds: 5),
      );
      final identityId = (result as CognitoAuthSession).identityId!;
      safePrint('identityId: $identityId');
    } on Exception catch (e) {
      safePrint('Something went wrong while fetching the session: $e');
    }
  }
}
