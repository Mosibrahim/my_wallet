import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_wallet/user_card_screen.dart';
import 'package:my_wallet/util/users_cubit/state.dart';

import 'cubit.dart';

class UsersCubitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UsersCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: BlocBuilder<UsersCubit, UserState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorState) {
            return Center(
              child: Icon(Icons.close),
            );
          } else if (state is LoadedState) {
            final users = state.users;

            return ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: users.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return UserCardScreen(users[index]);
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
