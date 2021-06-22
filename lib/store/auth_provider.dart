import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    print('=============================================');
    print('[FUNC CALL] AuthProvider.signinWithApple');
    print('=============================================');
    print('');

    try {
      final String rawNonce = generateNonce();
      final String nonce = sha256ofString(rawNonce);

      print('1) [Firebase] nonce Created for Apple Signin');
      print('');

      // Apple 로그인 후 반환된 `credential` 객체를 가져옵니다
      final AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ], nonce: nonce);

      print('2) [Firebase] Apple Signin Processed by User and idToken Fetched');
      print('* Email : ${AppleIDAuthorizationScopes.email}');
      print('* Full Name : ${AppleIDAuthorizationScopes.fullName}');
      print('* AuthorizationCredentialAppleID : $credential');
      print('');

      // 위에서 가져온 `credential` 객체를 사용하여 `oauthCredential` 객체를 생성합니다.
      final OAuthCredential oauthCredential = OAuthProvider('apple.com')
          .credential(idToken: credential.identityToken, rawNonce: rawNonce);

      print(
          '3) [Firebase] Apple OAuth Credential Fetched Using idToken and rawNonce');
      print('* OAuthCredential : $oauthCredential');
      print('');

      // `oauthCredential` 객체를 사용하여 Firebase에 로그인 시키고
      // 결과 정보를 담은 `UserCredential` 객체를 가져옵니다.
      // If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(oauthCredential);

      print('4) [Firebase] Firebase Sigin Processed Using Apple Credential');
      print('* UserCredential : $userCredential');
      print('');

      final String displayName =
          '${credential.familyName}${credential.givenName}';
      final String? userEmail = credential.email ?? userCredential.user?.email;

      print('5) [Firebase] User Name and Email Extracted from UserCredential');
      print('* Display Name : $displayName');
      print('* User Email : $userEmail');
      print('');

      // `userCredential` 객체에서 사용자 정보를 가져옵니다.
      final User? firebaseUser = userCredential.user;

      print('6) [Firebase] Firebase User Object Extracted from UserCredential');
      print('* User : $firebaseUser');
      print('');

      await firebaseUser?.updateProfile(displayName: displayName);

      print('7) [Firebase] Firebase User Profile Updated with Display Name');
      print('* Display Name : $displayName');

      if (userEmail != null) {
        await firebaseUser?.updateEmail(userEmail);

        print('');
        print('8) [Firebase] Firebase User Email Updated');
        print('* User Email : $userEmail');
      }

      print('=============================================');
      print('');

      return userCredential;
    } catch (e) {
      print('=============================================');
      print('');
      print('*********************************************');
      print(e);
      print('*********************************************');
      print('');

      return null;
    }
  }

  // Signin with Apple
  Future<UserCredential?> signinWithGoogle() async {
    print('=============================================');
    print('[FUNC CALL] AuthProvider.signinWithGoogle');
    print('=============================================');
    print('');

    try {
      print('=============================================');

      // Google 로그인 후 반환된 `GoogleSignInAccount` 객체를 가져옵니다.
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      print('1) [Firebase] Google Signin Processed by User');
      print('* GoogleSignInAccount: $googleUser');
      print('');

      // 인증 상세정보를 담은 `GoogleSignInAuthentication` 객체를 가져옵니다.
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      print('2) [Firebase] Google accessToken & idToken Fetched');
      print('* GoogleSignInAuthentication: $googleAuth');
      print('');

      if (googleAuth == null) {
        print('=============================================');
        return null;
      }

      // `OAuthCredential` 객체를 생성합니다.
      final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      print('3) [Firebase] Google OAuth Credential Fetched Using Tokens');
      print('* OAuthCredential: $credential');
      print('');

      // `oauthCredential` 객체를 사용하여 Firebase에 로그인 시키고
      // 결과 정보를 담은 `UserCredential` 객체를 가져옵니다.
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      print('4) [Firebase] Firebase Sigin Processed Using Google Credential');
      print('* UserCredential: $userCredential');
      print('=============================================');
      print('');

      return userCredential;
    } catch (e) {
      print('=============================================');
      print('');
      print('*********************************************');
      print(e);
      print('*********************************************');
      print('');

      return null;
    }
  }

  // Signout
  Future<void> signout() async {
    print('=============================================');
    print('[FUNC CALL] AuthProvider.signout');
    print('=============================================');
    print('');

    final User? user = firebaseAuth.currentUser;

    print('=============================================');
    print('* Current User: $user');
    print('=============================================');
    print('');

    if (user != null) await firebaseAuth.signOut();
  }
}
