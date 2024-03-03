import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:serious_budget_app/data/repos/authentication_repository.dart';
import 'package:serious_budget_app/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  final user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              user.displayName,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Sign out from Google if user signed in with Google
                final googleSignIn = GoogleSignIn();
                await googleSignIn.signOut();

                // Sign out from Firebase Authentication
                final authRepository = AuthRepository();
                await authRepository.signOut();

                // Navigate back to login screen or any other desired destination
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
