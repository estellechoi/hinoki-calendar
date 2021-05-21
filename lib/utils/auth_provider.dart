import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth firebaseAuth;

  AuthProvider(this.firebaseAuth);

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  String generateNonce([int length = 32]) {
    final String charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final Random random = Random.secure();
    return List.generate(
        length, (index) => charset[random.nextInt(charset.length)]).join();
  }

  String sha256ofString(String input) {
    final List<int> bytes = utf8.encode(input);
    final Digest digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Signin with Apple
  Future<UserCredential?> signinWithApple() async {
    try {
      final String rawNonce = generateNonce();
      final String nonce = sha256ofString(rawNonce);

      // Apple 로그인 후 반환된 `credential` 객체를 가져옵니다
      final AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ], nonce: nonce);

      // 위에서 가져온 `credential` 객체를 사용하여 `oauthCredential` 객체를 생성합니다.
      final OAuthCredential oauthCredential = OAuthProvider('apple.com')
          .credential(idToken: credential.identityToken, rawNonce: rawNonce);

      // `oauthCredential` 객체를 사용하여 Firebase에 로그인 시키고
      // 결과 정보를 담은 `authResult` 객체를 가져옵니다.
      // If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      final UserCredential authResult =
          await firebaseAuth.signInWithCredential(oauthCredential);

      final String displayName =
          '${credential.givenName} ${credential.familyName}';
      final String userEmail = '${credential.email}';

      // `authResult` 객체에서 사용자 정보를 가져옵니다.
      final User? firebaseUser = authResult.user;

      await firebaseUser?.updateProfile(displayName: displayName);
      await firebaseUser?.updateEmail(userEmail);

      return authResult;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Signout
  Future signout() async {
    await firebaseAuth.signOut();
  }
}
