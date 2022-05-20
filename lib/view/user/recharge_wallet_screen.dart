// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:print_system/view/components/app_colors.dart';
import 'package:print_system/view/components/app_text_styles.dart';
import 'package:print_system/view/components/default_button.dart';
import 'package:print_system/view/components/default_text_form_field.dart';

import '../../controller/blocs/user_cubit/user_cubit.dart';
import '../../controller/blocs/user_cubit/user_state.dart';
import 'components/payment_methods_list.dart';

class RechargeWalletScreen extends StatelessWidget {
  final _rechargeFormKey = GlobalKey<FormState>();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cvcController = TextEditingController();
  TextEditingController holderNameController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  RechargeWalletScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    UserCubit cubit = UserCubit.get(context);
    return BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Form(
                key: _rechargeFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment method",
                      style: AppTextStyles.title(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PaymentMethodsList(),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Card data",
                      style: AppTextStyles.title(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: DefaultTextFormField(
                              controller: cardNumberController,
                              isPassword: false,
                              textInputType: TextInputType.number,
                              labelText: "Card Number",
                              validator: (String? value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please fill the field';
                                }
                                return null;
                              },
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            flex: 1,
                            child: DefaultTextFormField(
                              controller: cvcController,
                              isPassword: false,
                              textInputType: TextInputType.number,
                              labelText: "CVC",
                              validator: (String? value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please fill the field';
                                }
                                return null;
                              },
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DefaultTextFormField(
                      controller: holderNameController,
                      isPassword: false,
                      textInputType: TextInputType.name,
                      labelText: "Holder Name",
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please fill the field';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DefaultTextFormField(
                      controller: amountController,
                      isPassword: false,
                      textInputType: TextInputType.number,
                      labelText: "Amount",
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please fill the field';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DefaultButton(
                          onPress: () {
                            if (_rechargeFormKey.currentState!.validate()) {
                              cubit.rechargeUserWallet(
                                  int.parse(amountController.text));
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Continue",
                                style: AppTextStyles.buttonText(),
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          buttonColor: AppColors.primaryColor,
                          textColor: Colors.white,
                          buttonHeight: 60,
                          buttonMinWidth: 0,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
