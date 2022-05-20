import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:print_system/view/admin/req_item.dart';
import 'package:print_system/view/components/app_text_styles.dart';

import '../../controller/blocs/admin_cubit/admin_cubit.dart';
import '../../controller/blocs/admin_cubit/admin_state.dart';

class DoneRequest extends StatelessWidget {
  const DoneRequest({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AdminCubit cubit = AdminCubit.get(context);
    return BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
                title: Text(
              "Done Requests",
              style: AppTextStyles.subtitle2()
                  .copyWith(fontSize: 20, color: Colors.white),
            )),
            body: Scrollbar(
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => generalRequest(
                      context, cubit.doneRequests[index],
                      type: "done"),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 0,
                      ),
                  itemCount: cubit.doneRequests.length),
            ),
          );
        });
  }
}
