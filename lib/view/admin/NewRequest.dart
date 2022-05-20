// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:print_system/view/admin/req_item.dart';

import '../../controller/blocs/admin_cubit/admin_cubit.dart';
import '../../controller/blocs/admin_cubit/admin_state.dart';

class NewRequest extends StatelessWidget {
  const NewRequest({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AdminCubit cubit = AdminCubit.get(context);
    return BlocConsumer<AdminCubit, AdminState>(listener: (context, state) {
      if (state is CreateDB) {
        cubit.getUsersNewRequests();
      }
    }, builder: (context, state) {
      return Scrollbar(
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => generalRequest(
                  context,
                  cubit.newRequests[index],
                ),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 0,
                ),
            itemCount: cubit.newRequests.length),
      );
    });
  }
}
