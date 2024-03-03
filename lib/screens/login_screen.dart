import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serious_budget_app/blocs/authentication/auth_bloc.dart';
import 'package:serious_budget_app/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(user: state.user),
                ),
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is Loading) {
                return const CircularProgressIndicator();
              } else if(state is UnAuthenticated){
                return buildLoginUI(context);
              }
              else{
                return buildLoginUI(context);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildLoginUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 190),
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white, // Optional: Set container background color
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/owl.png',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Text("Track Money, Save Money"),
        const SizedBox(height: 100),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  thickness: 0.7,
                  color: Colors.grey[400],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'continue with',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Expanded(
                child: Divider(
                  thickness: 0.7,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loginLogo(context, imagePath: 'assets/google.png'),
            const SizedBox(width: 25),
            loginLogo(context, imagePath: 'assets/facebook.png'),
          ],
        ),
      ],
    );
  }

  Widget loginLogo(BuildContext context, {required String imagePath}) {
    return InkWell(
      onTap: () {
        // Dispatch a login event when the user taps on the login button
        BlocProvider.of<AuthBloc>(context).add(LogInRequested());
      },
      child: Container(
        width: 90,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Image.asset(
          imagePath,
          height: 40,
        ),
      ),
    );
  }
}
