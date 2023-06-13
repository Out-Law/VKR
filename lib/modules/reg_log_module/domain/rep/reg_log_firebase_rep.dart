import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

abstract class RegLogFirebaseRep {
  Future<User?> signInWithGoogle();

  Future<User> signInWithApple();

  Future<User?> signIn(String email, String password);

  Future<User?> signUp(String email, String password);

  Future<User?> signOut();
}

@dev
@prod
@LazySingleton(as: RegLogFirebaseRep)
class RegLogFirebaseRepImpl implements RegLogFirebaseRep {
  @override
  Future<User?> signIn(String email, String password) async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    if (user.user != null) {
      //await App.sharedPref.remove(PREF_USER_WITHOUT_AUTH);
    }

    return user.user;
  }

  @override
  Future<User> signInWithApple(
      {List<Scope> scopes = const [Scope.email, Scope.fullName]}) async {
    // 1. perform the sign-in request
    final result = await TheAppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);

    // 2. check the result
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential!;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken!),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode!),
        );

        final userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final firebaseUser = userCredential.user!;

        //await App.sharedPref.remove(PREF_USER_WITHOUT_AUTH);

        if (scopes.contains(Scope.fullName)) {
          final fullName = appleIdCredential.fullName;
          if (fullName != null &&
              fullName.givenName != null &&
              fullName.familyName != null) {
            final displayName = '${fullName.givenName} ${fullName.familyName}';
            await firebaseUser.updateDisplayName(displayName);
          }
        }
        return firebaseUser;

      case AuthorizationStatus.error:
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );

      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);
        user = userCredential.user;
      } catch (e) {}
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);
          user = userCredential.user;
        } catch (e) {}
      }
    }

    if (user != null) {
      //await App.sharedPref.remove(PREF_USER_WITHOUT_AUTH);
    }

    return user;
  }

  @override
  Future<User?> signOut() async {
    await FirebaseAuth.instance.signOut();
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Future<User?> signUp(String email, String password) async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    if (user.user != null) {
      //await App.sharedPref.remove(PREF_USER_WITHOUT_AUTH);
    }

    return user.user;
  }
}
