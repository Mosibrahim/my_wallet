import 'package:bloc/bloc.dart';
import 'package:my_wallet/model/user.dart';
import 'package:my_wallet/util/databaseUtils.dart';
import 'package:my_wallet/util/users_cubit/state.dart';

class UsersCubit extends Cubit<UserState> {
  List<User> users = [];

  UsersCubit() : super(InitialState()) {
    getUsersFromDB();
  }

  void getUsersFromDB() async {
    try {
      emit(LoadingState());
      final result = await DatabaseUtils.fetchUsers();
      for (var map in result) {
        users.add(User.fromDBJson(map));
      }
      emit(LoadedState(users));
    } catch (e) {
      emit(ErrorState());
    }
  }
}
