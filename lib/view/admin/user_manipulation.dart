import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:print_system/model/person/user.dart';
import '../../controller/blocs/admin_cubit/admin_cubit.dart';
import '../../controller/blocs/admin_cubit/admin_state.dart';
import '../components/app_text_styles.dart';

class UserMaintain extends StatelessWidget {
  const UserMaintain({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {},
        builder: (context, state) {
          AdminCubit cubit = AdminCubit.get(context);
          return Scrollbar(
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    showUsers(context, cubit.users[index]),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 0,
                    ),
                itemCount: cubit.users.length),
          );
        });
  }

  Widget showUsers(context, User user) {
    double width = MediaQuery.of(context).size.width / 5;
    AdminCubit cubit = AdminCubit.get(context);
    print(width);
    return Card(
      margin: const EdgeInsetsDirectional.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      color: HexColor('1e5880'),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ID : ${user.id.toString()}", style: AppTextStyles.title2()),
            const SizedBox(
              height: 10,
            ),
            const Divider(color: Colors.white, height: 0.5),
            const SizedBox(
              height: 10,
            ),
            userData(context, user),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                    onPressed: () {
                      cubit.deleteUserFromDB(user);
                    },
                    style: ButtonStyle(
                        side: MaterialStateProperty.all(const BorderSide(
                            color: Colors.white,
                            width: 1.0,
                            style: BorderStyle.solid))),
                    child: const Text(
                      "Delete user ",
                      style: TextStyle(fontSize: 13),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget userData(context, User user) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "User Name : ${user.name} ",
        style: AppTextStyles.subtitle2(),
      ),
      Text(
        "User Email : ${user.user_name}",
        style: AppTextStyles.subtitle2(),
      ),
      Text(
        "Visa Number : ${user.visa.toString()}",
        style: AppTextStyles.subtitle2(),
      ),
      Text(
        "Charge  : ${user.charge.toString()}",
        style: AppTextStyles.subtitle2(),
      ),
      Text(
        "password  : ${user.password.toString()}",
        style: AppTextStyles.subtitle2(),
      ),
    ]);
  }
}
