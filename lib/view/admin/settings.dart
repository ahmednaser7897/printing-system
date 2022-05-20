import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/blocs/admin_cubit/admin_cubit.dart';
import '../../controller/blocs/admin_cubit/admin_state.dart';
import '../../main.dart';
import '../../model/shared_preferences/shared_preferences.dart';
import '../components/app_colors.dart';
import '../components/app_theme.dart';
import '../components/default_button.dart';
import '../login/login_screen.dart';
import 'acc_request.dart';
import 'done_request.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {},
        builder: (context, state) {
          AdminCubit cubit = AdminCubit.get(context);
          return Column(children: [
            ListTile(
              title: const Text("Accepted Request"),
              subtitle: const Text(
                "The requests that Accepted but have not yet been printed",
                maxLines: 2,
                style: TextStyle(height: 1),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              leading: const Icon(Icons.done_outline_sharp),
              onTap: () {
                cubit.getUsersAcceptedRequests();
                navigatorTo(context, const AcceptedRequest());
              },
            ),
            ListTile(
              title: const Text("Done Request"),
              subtitle: const Text(
                "Requests that have been printed",
                maxLines: 2,
                style: TextStyle(height: 1),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              leading: const Icon(Icons.done_all_outlined, color: Colors.blue),
              onTap: () {
                cubit.getUsersDoneRequests();
                navigatorTo(context, const DoneRequest());
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DefaultButton(
                onPress: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Log out'),
                          content: const Text(
                              "Do you want to logout from your account?"),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel")),
                            TextButton(
                                onPressed: () {
                                  CachHelper.removeData(key: "pid")
                                      .then((value) {
                                    navigatorAndEnd(context, LoginScreen());
                                    cubit
                                        .changeAdminBottomBarIndex(0)
                                        .then((value) {
                                      personId = 0;
                                      type = "";
                                      cubit.onAdminLogout();
                                    });
                                  }).catchError((onError) {
                                    print(
                                        'Error from LOGOUT is ${onError.toString()}');
                                  });
                                },
                                child: const Text("Logout")),
                          ],
                        );
                      });
                },
                buttonMinWidth: double.infinity,
                child: const Text("Log out",
                    style: TextStyle(color: Colors.white)),
                buttonHeight: 55,
                textColor: Colors.white,
                buttonColor: AppColors.primaryColor,
              ),
            ),
          ]);
        });
  }
}
