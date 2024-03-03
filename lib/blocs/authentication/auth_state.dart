
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable{

}

class Loading extends AuthState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class UnAuthenticated extends AuthState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class Authenticated extends AuthState{
  final user;

  Authenticated({required this.user});

  @override
  List<Object?> get props => [user];

}