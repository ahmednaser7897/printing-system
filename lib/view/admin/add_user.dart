import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/blocs/admin_cubit/admin_cubit.dart';
import '../../controller/blocs/admin_cubit/admin_state.dart';
import '../../model/person/user.dart';
import '../components/app_colors.dart';
import '../components/app_theme.dart';
import '../components/default_button.dart';
import '../components/default_text_form_field.dart';

class AddUser extends StatelessWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController username = TextEditingController();
    TextEditingController pass = TextEditingController();
    TextEditingController id = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController visa = TextEditingController();
    return BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {},
        builder: (context, state) {
          username.text = "ahmed";
          name.text = "ahmed";
          id.text = "100";
          pass.text = "100";
          visa.text = "100";
          AdminCubit cubit = AdminCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/printer.png",
                    fit: BoxFit.cover,
                    height: 30,
                    width: 30,
                  ),
                  const Text(
                    " YAES",
                    style: TextStyle(
                        color: Color(0xff03A0F4),
                        fontFamily: "Cairo",
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text("Adding User",
                      style: TextStyle(
                          color: Color(0xff1E5880),
                          fontFamily: "Cairo",
                          fontSize: 15,
                          fontWeight: FontWeight.bold))
                ],
              ),
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
                        const Text("Adding User"),
                        const SizedBox(height: 20),
                        //id
                        DefaultTextFormField(
                          isPassword: false,
                          labelText: "ID",
                          textInputType: TextInputType.number,
                          controller: id,
                          prefixIcon: Icons.numbers,
                          validator: (String? value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                int.tryParse(value)! < 100 ||
                                int.tryParse(value)! > 199) {
                              return 'Please fill the field';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        //name
                        DefaultTextFormField(
                          isPassword: false,
                          labelText: "Name",
                          textInputType: TextInputType.name,
                          controller: name,
                          prefixIcon: Icons.person_outline,
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please fill the field';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        //user name
                        DefaultTextFormField(
                          isPassword: false,
                          labelText: "Username",
                          textInputType: TextInputType.name,
                          controller: username,
                          prefixIcon: Icons.person_outline,
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please fill the field';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        //pass
                        DefaultTextFormField(
                          isPassword: true,
                          labelText: "Password",
                          textInputType: TextInputType.visiblePassword,
                          controller: pass,
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
                        const SizedBox(height: 20),
                        //visa number
                        DefaultTextFormField(
                          isPassword: false,
                          labelText: "Visa number",
                          textInputType: TextInputType.number,
                          controller: visa,
                          prefixIcon: Icons.attach_money_outlined,
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please fill the field';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),

                        DefaultButton(
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              if (await cubit.isUserExist(
                                  int.parse(id.value.text), username.text)) {
                                showToast("erorr id or user name is used",
                                    States.ERORR);
                              } else {
                                User user = User(
                                    name.text,
                                    int.parse(id.text),
                                    int.parse(pass.text),
                                    username.text,
                                    int.parse(visa.text),
                                    500);
                                cubit.addUserToDB(user);
                                showToast(
                                    "user ${user.id} added ", States.SUCCESS);
                              }
                            }
                          },
                          buttonMinWidth: double.infinity,
                          child: const Text("Log in",
                              style: TextStyle(color: Colors.white)),
                          buttonHeight: 55,
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
        });
  }
}
