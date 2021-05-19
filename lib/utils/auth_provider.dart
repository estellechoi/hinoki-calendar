import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth;

  AuthProvider(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Signout
  Future signout() async {
    await _firebaseAuth.signOut();
  }

  // Signin with Apple
  Future<User?> signinWithApple({onError}) async {
    try {
      // Apple 로그인 후 반환된 `credential` 객체를 가져옵니다
      final AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // 위에서 가져온 `credential` 객체를 사용하여 `oauthCredential` 객체를 생성합니다.
      final OAuthCredential oauthCredential =
          OAuthProvider('apple.com').credential(
        idToken: credential.identityToken,
      );

      // `oauthCredential` 객체를 사용하여 Firebase에 로그인 시키고
      // 결과 정보를 담은 `authResult` 객체를 가져옵니다.
      final UserCredential authResult =
          await _firebaseAuth.signInWithCredential(oauthCredential);

      final String displayName =
          '${credential.givenName} ${credential.familyName}';
      final String userEmail = '${credential.email}';

      // `authResult` 객체에서 사용자 정보를 가져옵니다.
      final User? firebaseUser = authResult.user;

      await firebaseUser?.updateProfile(displayName: displayName);
      await firebaseUser?.updateEmail(userEmail);

      return firebaseUser;
    } catch (e) {
      print(e);
      onError(e);
    }
  }
}
