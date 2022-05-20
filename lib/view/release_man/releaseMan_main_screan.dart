// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:print_system/view/components/app_colors.dart';

import '../../controller/blocs/admin_cubit/admin_cubit.dart';
import '../../controller/blocs/admin_cubit/admin_state.dart';
import '../../main.dart';
import '../../model/shared_preferences/shared_preferences.dart';
import '../components/app_logo.dart';
import '../components/app_theme.dart';
import '../components/default_button.dart';
import '../login/login_screen.dart';

class ReleaseManScreen extends StatelessWidget {
  const ReleaseManScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {},
        builder: (context, state) {
          AdminCubit cubit = AdminCubit.get(context);
          print("pid ReleaseManMainScreen " + personId.toString());
          print("type ReleaseManMainScreen " + type.toString());
          return Scaffold(
              appBar: AppBar(
                title: AppLogo(),
              ),
              body: Center(
                  child: DefaultButton(
                onPress: () {
                  CachHelper.removeData(key: "pid").then((value) {
                    cubit.changeAdminBottomBarIndex(0).then((value) {
                      personId = 0;
                      type = "";
                      navigatorAndEnd(context, LoginScreen());
                    });
                  }).catchError((onError) {
                    print('error from LOGOUT is ${onError.toString()}');
                  });
                },
                borderRadius: 10,
                buttonMinWidth: double.infinity,
                child: const Text("Log out",
                    style: TextStyle(color: Colors.white)),
                buttonHeight: 55,
                textColor: Colors.white,
                buttonColor: AppColors.primaryColor,
              )));
        });
  }
}
