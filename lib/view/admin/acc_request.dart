import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:print_system/view/admin/req_item.dart';

import '../../controller/blocs/admin_cubit/admin_cubit.dart';
import '../../controller/blocs/admin_cubit/admin_state.dart';
import '../components/app_text_styles.dart';

class AcceptedRequest extends StatelessWidget {
  const AcceptedRequest({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AdminCubit cubit = AdminCubit.get(context);
    return BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
                title: Text(
              "Accepted Requests",
              style: AppTextStyles.subtitle2()
                  .copyWith(fontSize: 20, color: Colors.white),
            )),
            body: Scrollbar(
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => generalRequest(
                      context, cubit.acceptedRequests[index],
                      type: "accepted"),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 0,
                      ),
                  itemCount: cubit.acceptedRequests.length),
            ),
          );
        });
  }
}
