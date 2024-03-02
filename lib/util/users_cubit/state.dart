import 'package:my_wallet/model/user.dart';

class UserState {
  const UserState();
}

class InitialState extends UserState {
  @override
  List<Object> get props => [];
}

class LoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class LoadedState extends UserState {
  LoadedState(this.users);

  final List<User> users;

  @override
  List<Object> get props => [users];
}

class ErrorState extends UserState {
  @override
  List<Object> get props => [];
}
