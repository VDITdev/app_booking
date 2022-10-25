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


  Future<void> signOutCurrentUser() async {
    try {

      await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      print(e.message);
    }
  }
}