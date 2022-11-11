import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isUserLoggedIn()
  {
   return _auth.currentUser !=null;
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    User? user;

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
        await _auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
          ScaffoldMessenger.of(context).showSnackBar(
            AuthenticationHelper.customSnackBar(
              content:
              'The account already exists with a different credential',
            ),
          );
        }
        else if (e.code == 'invalid-credential') {
          // handle the error here
          ScaffoldMessenger.of(context).showSnackBar(
            AuthenticationHelper.customSnackBar(
              content:
              'Error occurred while accessing credentials. Try again.',
            ),
          );
        }
      } catch (e) {
        // handle the error here
        ScaffoldMessenger.of(context).showSnackBar(
          AuthenticationHelper.customSnackBar(
            content: 'Error occurred using Google Sign In. Try again.',
          ),
        );

        print("Error : ${e.toString()}");
      }
    }

    return user;
  }

  Future signOut() async
  {
    await _auth.signOut();
  }
  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }
}
