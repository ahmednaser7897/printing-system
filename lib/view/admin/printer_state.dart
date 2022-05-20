import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:print_system/view/admin/req_item.dart';
import '../../controller/blocs/admin_cubit/admin_cubit.dart';
import '../../controller/blocs/admin_cubit/admin_state.dart';
import '../../model/Other/printer.dart';
import '../components/app_colors.dart';
import '../components/app_text_styles.dart';

class PrinterState extends StatelessWidget {
  const PrinterState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {},
        builder: (context, state) {
          AdminCubit cubit = AdminCubit.get(context);
          return Scrollbar(
            child: ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    printerState(context, cubit.printers[index]),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 0,
                    ),
                itemCount: cubit.printers.length),
          );
        });
  }

  Widget printerState(context, Printer p) {
    double width = MediaQuery.of(context).size.width / 5;
    print(width);
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Card(
            margin: const EdgeInsetsDirectional.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5,
            color: AppColors.appColor1,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "printer ${p.id}",
                    style:
                        AppTextStyles.bodyText().copyWith(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(color: Colors.white, height: 0.5),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Id : ${p.id.toString()}',
                        style: AppTextStyles.bodyText()
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        'Number of Docs :  ${p.num_of_docs.toString()}',
                        style: AppTextStyles.subtitle(),
                      ),
                      Text(
                        'Time : 20 s',
                        style: AppTextStyles.subtitle(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (p.docs.isNotEmpty)
                        OutlinedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        contentTextStyle: const TextStyle(
                                            fontFamily: 'calibri',
                                            color: Colors.white),
                                        backgroundColor: HexColor('1e5880'),
                                        scrollable: true,
                                        title: const Text(
                                          "printer 1 docs",
                                          style: TextStyle(
                                            fontFamily: 'calibri',
                                          ),
                                        ),
                                        content: SizedBox(
                                            height: 300,
                                            width: 150,
                                            child: Scrollbar(
                                              child: ListView.separated(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) =>
                                                          docItem(context,
                                                              p.docs[index],
                                                              isPrinter: true),
                                                  separatorBuilder: (context,
                                                          index) =>
                                                      const Divider(
                                                          color: Colors.white,
                                                          height: 0.5),
                                                  itemCount: p.docs.length),
                                            )),
                                      ));
                            },
                            style: ButtonStyle(
                                side: MaterialStateProperty.all(
                                    const BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                        style: BorderStyle.solid))),
                            child: const Text(
                              "Show The Docs Detiels ",
                              style: TextStyle(fontSize: 13),
                            )),
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
                gradient: const LinearGradient(
                  colors: <Color>[
                    AppColors.primaryColor,
                    Color(0xff58EBEF),
                  ],
                  tileMode: TileMode.repeated,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              width: 100,
              child: Center(
                  child: Text(
                !(p.num_of_docs == 0) ? "Working" : "Not working",
                style: AppTextStyles.bodyText().copyWith(color: Colors.white),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
