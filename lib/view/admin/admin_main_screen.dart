import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/blocs/admin_cubit/admin_cubit.dart';
import '../../controller/blocs/admin_cubit/admin_state.dart';
import '../../main.dart';
import '../components/app_logo.dart';
import '../components/app_text_styles.dart';
import '../components/app_theme.dart';
import 'add_user.dart';

class AdminMainScreen extends StatelessWidget {
  const AdminMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("pid AdminMainScreen " + personId.toString());
    print("type AdminMainScreen " + type.toString());
    AdminCubit cubit = AdminCubit.get(context);
    return BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            extendBody: true,
            appBar: AppBar(
              title: AppLogo(
                titel: cubit.adminHeaders[cubit.adminBottomBarCurrentIndex],
              ),
              actions: [
                cubit.adminBottomBarCurrentIndex != 2
                    ? Container()
                    : TextButton(
                        onPressed: () {
                          navigatorTo(context, const AddUser());
                        },
                        child:
                            Text("Add User", style: AppTextStyles.subtitle2()))
              ],
            ),
            body: cubit.adminScreens[cubit.adminBottomBarCurrentIndex],
            bottomNavigationBar: Container(
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.transparent,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BottomNavigationBar(
                    currentIndex: cubit.adminBottomBarCurrentIndex,
                    onTap: ((value) => cubit.changeAdminBottomBarIndex(value)),
                    items: const [
                      BottomNavigationBarItem(
                          label: "Requests",
                          icon: Icon(
                            Icons.file_copy_outlined,
                          )),
                      BottomNavigationBarItem(
                          label: "Printers", icon: Icon(Icons.print_outlined)),
                      BottomNavigationBarItem(
                          label: "Users",
                          icon: Icon(
                            Icons.people_alt_outlined,
                          )),
                      BottomNavigationBarItem(
                          label: "Other", icon: Icon(Icons.logout)),
                    ]),
              ),
            ),
          );
        });
  }
}
