// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:print_system/view/components/app_text_styles.dart';

import '../../../controller/blocs/user_cubit/user_cubit.dart';
import '../../../controller/blocs/user_cubit/user_state.dart';
import '../../../model/person/userDocs.dart';
import '../../components/app_colors.dart';

class PrintingJobsCard extends StatelessWidget {
  UserDoc userDoc;

  PrintingJobsCard(this.userDoc, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     UserCubit cubit = UserCubit.get(context);
    return BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {},
        builder: (context, state) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffECFDFD),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: Image.asset(
          "assets/images/docs.png",
          height: 40,
          width: 40,
          fit: BoxFit.cover,
        ),
        title: Text(
          userDoc.doc.name,
          style: AppTextStyles.title().copyWith(color: AppColors.appColor4),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${userDoc.doc.copies} Copies . ${userDoc.doc.pages} Pages",
              style:
                  AppTextStyles.subtitle().copyWith(color: AppColors.appColor4),
            ),
            Text(
              userDoc.state,
              style: AppTextStyles.bodyText(),
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: () {
            cubit.deleteUserDocuments(userDoc);
          },
          icon: const Icon(
                Icons.delete_outline,
                color: AppColors.primaryColor,
                size: 25,
              ),
            ),
          ),
        );}
    );
  }
}
