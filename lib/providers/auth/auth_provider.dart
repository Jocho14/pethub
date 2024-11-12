import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pethub/services/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;

  User? get user => _user;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: dotenv.env['FIREBASE_CLIENT_ID'],
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  // Sign in with Google
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        // Get authentication details
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        // Create a new Firebase credential
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        // Sign in to Firebase with the Google credential
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        _user = userCredential.user;

        // Notify listeners after sign-in
        notifyListeners();
        print('Signed in successfully with Google');

        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (error) {
      print('Google sign-in failed: $error');
    }
  }

  // Sign in with email and password
  Future<void> signInWithEmail(String email, String password) async {
    try {
      _user = await _authService.signInWithEmail(email, password);
      notifyListeners();
    } catch (error) {
      print('Email sign-in failed: $error');
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }
}
