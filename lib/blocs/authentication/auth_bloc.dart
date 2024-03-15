import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../data/repos/authentication_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  AuthBloc({required this.authRepository, initialUser})
      : super(initialUser != null ? Authenticated(user: initialUser) : UnAuthenticated()) {
    on<LogInRequested>((event, emit) async {
      emit(Loading());
      try {

          var googleuser = await authRepository.signInWithGoogle();

          if(googleuser == null) {

            emit(UnAuthenticated());
          }else {
            emit(Authenticated(user: googleuser));
          }

        } catch (e) {
        // Handle error
        print('Error signing in with Google: $e');
        emit(UnAuthenticated());
      }
    });

    //////////////////////////////////////////////////////////////////////////////////////

    on<LogOutRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signOut();

        emit(UnAuthenticated());
      } catch(e) {

        print(e);
      }// Example method to sign out user
      emit(UnAuthenticated());
    });
  }
  }


