// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:print_system/controller/blocs/login%20cubit/login_cubit.dart';
import 'package:print_system/controller/blocs/login%20cubit/login_states.dart';
import 'package:print_system/model/log%20in/loginType.dart';
import 'package:print_system/view/admin/admin_main_screen.dart';
import 'package:print_system/view/components/app_colors.dart';
import 'package:print_system/view/components/app_text_styles.dart';
import 'package:print_system/view/components/app_theme.dart';
import 'package:print_system/view/release_man/releaseMan_main_screan.dart';
import 'package:print_system/view/user/user_main_screen.dart';

import '../../main.dart';
import '../../model/shared_preferences/shared_preferences.dart';
import '../components/app_logo.dart';
import '../components/default_button.dart';
import '../components/default_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("pid inLoginScreen " + personId.toString());
    print("type inLoginScreen " + type.toString());
    nameController.text = "me1";
    passwordController.text = "123";
    return BlocProvider(
      create: (context) => LoginCubit()..createDataBase(),
      child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {},
          builder: (context, state) {
            LoginCubit cubit = LoginCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: AppLogo(),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Log in",
                            style: AppTextStyles.title(),
                          ),
                          const SizedBox(height: 20),
                          DefaultTextFormField(
                            isPassword: false,
                            labelText: "Username",
                            textInputType: TextInputType.name,
                            controller: nameController,
                            prefixIcon: Icons.person_outline,
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please fill the field';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          DefaultTextFormField(
                            isPassword: true,
                            labelText: "Password",
                            textInputType: TextInputType.visiblePassword,
                            controller: passwordController,
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: Icons.visibility,
                            suffixIconPressed: Icons.visibility_off,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please fill the field';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 40),
                          DefaultButton(
                            onPress: () {
                              if (_formKey.currentState!.validate()) {
                                cubit
                                    .login(nameController.text,
                                        int.parse(passwordController.text))
                                    .then((value) {
                                  if (cubit.logInType.isLogged()) {
                                    showToast("done", States.SUCCESS);
                                    print("in is " +
                                        cubit.logInType
                                            .isAdminLogged()
                                            .toString());

                                    CachHelper.setData(
                                            key: "pid", value: cubit.person.id)
                                        .then((value) {
                                      personId = cubit.person.id;
                                      type = findPersonType(personId);
                                      if (cubit.logInType.isAdminLogged()) {
                                        navigatorAndEnd(
                                            context, const AdminMainScreen());
                                      } else if (cubit.logInType
                                          .isUserLogged()) {
                                        navigatorAndEnd(
                                            context, const UserMainScreen());
                                      } else if (cubit.logInType.isReleaseManLogged()) {
                                        navigatorAndEnd(
                                            context, const ReleaseManScreen());
                                      }
                                    });
                                  } else {
                                    showToast("error", States.ERORR);

                                    cubit.logInType = LoginType();
                                  }
                                });
                              }
                            },
                            buttonMinWidth: double.infinity,
                            child: Text("Log in",
                                style: AppTextStyles.buttonText()),
                            buttonHeight: 60,
                            textColor: Colors.white,
                            buttonColor: AppColors.primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
