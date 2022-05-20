import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/blocs/user_cubit/user_cubit.dart';
import '../../controller/blocs/user_cubit/user_state.dart';
import '../../main.dart';
import '../../model/shared_preferences/shared_preferences.dart';
import '../components/app_theme.dart';
import '../login/login_screen.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        UserCubit cubit = UserCubit.get(context);
        return AlertDialog(
          title: const Text('Log out'),
          content: const Text("Do you want to logout from your account?"),
          actions: [
            TextButton(
                onPressed: () {
                  cubit.changeUserBottomBarIndex(0);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  CachHelper.removeData(key: "pid").then((value) {
                    cubit.changeUserBottomBarIndex(0).then((value) {
                      personId = 0;
                      type = "";
                      cubit.onUserLogout();
                      navigatorAndEnd(context, LoginScreen());
                    });
                  }).catchError((onError) {
                    print('Error from LOGOUT is ${onError.toString()}');
                  });
                },
                child: const Text("Logout")),
          ],
        );
      },
    );
  }
}
