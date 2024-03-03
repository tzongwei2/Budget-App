part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable{
  @override
  List<Object> get props =>[];

}

class LogInRequested extends AuthEvent{
    LogInRequested();
}

class LogOutRequested extends AuthEvent{
   LogOutRequested();
}

