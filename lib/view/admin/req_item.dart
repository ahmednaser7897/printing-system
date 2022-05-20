import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:print_system/model/person/user.dart';

import '../../controller/blocs/admin_cubit/admin_cubit.dart';
import '../../model/Other/document.dart';
import '../components/app_text_styles.dart';
import '../components/app_theme.dart';

Widget generalRequest(context, Document doc, {String type = "new"}) {
  double width = MediaQuery.of(context).size.width / 5;
  AdminCubit cubit = AdminCubit.get(context);
  print(width);
  return Stack(
    alignment: AlignmentDirectional.topEnd,
    children: [
      Card(
        margin: const EdgeInsetsDirectional.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        color: HexColor('1e5880'),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(doc.username, style: AppTextStyles.title2()),
              const SizedBox(
                height: 10,
              ),
              const Divider(color: Colors.white, height: 0.5),
              const SizedBox(
                height: 10,
              ),
              docItem(context, doc),
              if (type == "new")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                        onPressed: () async {
                          User user = await cubit.getUser(doc.userID);
                          if (!cubit.checkIfUserHasEnoughCharge(
                            user: user,
                            pages: doc.pages,
                            copies: doc.copies,
                          )) {
                            showToast(
                                "sorry, your charge has enough", States.ERORR);
                          } else {
                            cubit.acceptUserRequest(doc);
                            showToast("accepted ", States.SUCCESS);
                          }
                        },
                        style: ButtonStyle(
                            side: MaterialStateProperty.all(const BorderSide(
                                color: Colors.white,
                                width: 1.0,
                                style: BorderStyle.solid))),
                        child: const Text(
                          "Accept ",
                          style: TextStyle(fontSize: 13),
                        )),
                    OutlinedButton(
                        onPressed: () {
                          cubit.rejectUserRequest(doc);
                        },
                        style: ButtonStyle(
                            side: MaterialStateProperty.all(const BorderSide(
                                color: Colors.white,
                                width: 1.0,
                                style: BorderStyle.solid))),
                        child: const Text(
                          "Reject",
                          style: TextStyle(fontSize: 13),
                        ))
                  ],
                )
            ],
          ),
        ),
      ),
      Padding(
        padding: EdgeInsetsDirectional.only(end: width, bottom: 20),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                HexColor('14e8ed'),
                HexColor('03a0f4'),
              ],
              tileMode: TileMode.repeated,
            ),
            color: HexColor('03a0f4'),
            borderRadius: BorderRadius.circular(25),
          ),
          width: 100,
          height: 30,
          child: Center(
              child: Text(
            "${(doc.copies * doc.pages * 2).toString()} \$",
            style: const TextStyle(fontSize: 15, color: Colors.white),
          )),
        ),
      ),
    ],
  );
}

Widget docItem(context, Document doc, {isPrinter = false}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isPrinter)
          Text(
            "User Name : ${doc.username}",
            style: AppTextStyles.subtitle2(),
          ),
        Text(
          "Doc Name : ${doc.name}",
          style: AppTextStyles.subtitle2(),
        ),
        Text(
          "Pages : ${doc.pages.toString()} ",
          style: AppTextStyles.subtitle2(),
        ),
        Text(
          "Copies : ${doc.copies.toString()} ",
          style: AppTextStyles.subtitle2(),
        ),
        if (isPrinter)
          Text(
            "Price  : ${(doc.copies * doc.pages * 2).toString()} ",
            style: AppTextStyles.subtitle2(),
          ),
      ],
    ),
  );
}
