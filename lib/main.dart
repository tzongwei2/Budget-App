
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:serious_budget_app/screens/home_screen.dart';
import 'package:serious_budget_app/screens/login_screen.dart';
import 'blocs/authentication/auth_bloc.dart';
import 'blocs/expenses/expenses_bloc.dart';
import 'data/repos/authentication_repository.dart';
import 'data/repos/expenses_repository.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try{
  await Firebase.initializeApp();
  }
  catch(e){
    print(e);
  }

  final authRepository = AuthRepository();
  final user = await authRepository.getCurrentUser();

  runApp(MyApp(
    initialUser: user,
  ));
 
}

class MyApp extends StatelessWidget {
  final initialUser;

  const MyApp({Key? key, this.initialUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(initialUser);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
        RepositoryProvider(create: (context) => ExpenseRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(authRepository: RepositoryProvider.of<AuthRepository>(context),initialUser: initialUser),
          ),
          BlocProvider<ExpenseBloc>(
            create: (context) => ExpenseBloc(expenseRepository: RepositoryProvider.of<ExpenseRepository>(context)),
          ),
        ],
        child: MaterialApp(
      home: initialUser != null ? HomeScreen(user: initialUser!) : const LoginScreen(),
    ),
      ),
    );
  }
}
