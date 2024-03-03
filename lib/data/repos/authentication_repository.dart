import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      // Start the Google Sign-In process
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Handle case where user cancels Google Sign-In
      if (googleUser == null) return null;

      // Get the authentication tokens from Google
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Create a Google Auth credential using the tokens
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google Auth credential
      final userCredential =
      await _firebaseAuth.signInWithCredential(credential);

      // Return the signed-in user
      return userCredential.user;
    } catch (e) {
      // Handle any errors
      print('Error signing in with Google: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      // Sign out from Firebase, google Authentication
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();


      print("adios");

    } catch (e) {
      // Handle any errors
      print('Error signing out: $e');
    }
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
