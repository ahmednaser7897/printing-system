// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:print_system/controller/blocs/user_cubit/user_cubit.dart';
import 'package:print_system/view/user/components/printing_jobs_card.dart';

import '../../controller/blocs/user_cubit/user_state.dart';

class PrintingJobsViewScreen extends StatelessWidget {
  const PrintingJobsViewScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    UserCubit cubit = UserCubit.get(context);
    return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
      if (state is CreateDB) {
        cubit.getUserRequests();
        cubit.getUserData().then((_) {
          print("charge is " + cubit.user.charge.toString());
        });
      }
    }, builder: (context, state) {
      if (state is LoadingGetUserALLRequests) {
        return const CircularProgressIndicator();
      }else {
        return ListView.separated(
            itemCount: cubit.userRequests.length,
            separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
            itemBuilder: (context, index) =>
                PrintingJobsCard(cubit.userRequests[index]));
      }
    });
  }
}
