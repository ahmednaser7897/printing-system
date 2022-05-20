// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:print_system/controller/blocs/user_cubit/user_state.dart';

import '../../../controller/blocs/user_cubit/user_cubit.dart';
import '../../components/app_colors.dart';

class PaymentMethodsList extends StatelessWidget {
  PaymentMethodsList({Key? key}) : super(key: key);
  List<String> paymentMethodsImages = [
    "assets/images/visa.png",
    "assets/images/paypal.png",
    "assets/images/master.png"
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
       
      },
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return SizedBox(
            height: 100,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        cubit.changeSelectedPaymentMethod(index);
                      },
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: (cubit.selectedPaymentMethodIndex == index)
                                    ? 2
                                    : 1,
                                color: (cubit.selectedPaymentMethodIndex == index)
                                    ? AppColors.primaryColor
                                    : Colors.grey)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Image.asset(
                              paymentMethodsImages[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                itemCount: paymentMethodsImages.length));
      },
    );
  }
}
