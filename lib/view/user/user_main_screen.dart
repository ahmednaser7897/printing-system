import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/blocs/user_cubit/user_cubit.dart';
import '../../controller/blocs/user_cubit/user_state.dart';
import '../../main.dart';
import '../components/app_logo.dart';

class UserMainScreen extends StatelessWidget {
  const UserMainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {},
        builder: (context, state) {
          print("pid UserMainScreen " + personId.toString());
          print("type UserMainScreen " + type.toString());
          UserCubit cubit = UserCubit.get(context);
          return Scaffold(
            extendBody: true,
            appBar: AppBar(
              title: AppLogo(),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: cubit.userScreens[cubit.userBottomBarCurrentIndex],
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BottomNavigationBar(
                  currentIndex: cubit.userBottomBarCurrentIndex,
                  onTap: (value) {
                    cubit.changeUserBottomBarIndex(value);
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.layers),
                      label: "Printing jobs",
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.upload), label: "Upload"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.credit_card_rounded),
                        label: "Recharge"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.logout), label: "Logout"),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
