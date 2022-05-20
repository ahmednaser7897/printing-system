// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:print_system/view/components/app_colors.dart';
import 'package:print_system/view/components/app_text_styles.dart';
import 'package:print_system/view/components/default_button.dart';
import 'package:print_system/view/components/default_text_form_field.dart';

import '../../controller/blocs/user_cubit/user_cubit.dart';
import '../../controller/blocs/user_cubit/user_state.dart';
import '../components/app_theme.dart';

class UploadDocumentScreen extends StatelessWidget {
  final _uploadFileFormKey = GlobalKey<FormState>();
  TextEditingController numberOfCopiesController = TextEditingController();
  TextEditingController numberOfPagesController = TextEditingController();
  TextEditingController id = TextEditingController();

  UploadDocumentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    numberOfCopiesController.text = "10";
    numberOfPagesController.text = "10";
    id.text = "10";
    UserCubit cubit = UserCubit.get(context);
    return BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Form(
            key: _uploadFileFormKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                cubit.documentHelper.getDocFromPhone();
                              },
                              child: SvgPicture.asset(
                                "assets/images/upload.svg",
                                height: 50,
                                width: 50,
                                color: AppColors.appColor3,
                                fit: BoxFit.cover,
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Upload file",
                            style: AppTextStyles.title(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "ID",
                      style: AppTextStyles.bodyText(),
                    ),
                    DefaultTextFormField(
                      isPassword: false,
                      textInputType: TextInputType.number,
                      controller: id,
                      hintText: "Enter ID",
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
                    Text(
                      "Copies",
                      style: AppTextStyles.bodyText(),
                    ),
                    DefaultTextFormField(
                      isPassword: false,
                      textInputType: TextInputType.number,
                      controller: numberOfCopiesController,
                      hintText: "Enter number of copies",
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
                    Text(
                      "Pages",
                      style: AppTextStyles.bodyText(),
                    ),
                    DefaultTextFormField(
                      isPassword: false,
                      textInputType: TextInputType.number,
                      controller: numberOfPagesController,
                      hintText: "Enter number of Pages",
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please fill the field';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultButton(
                      onPress: () async {
                        if (_uploadFileFormKey.currentState!.validate()) {
                          int pages = int.parse(numberOfPagesController.text);
                          int copies = int.parse(numberOfCopiesController.text);
                          if (await cubit.isDocIdUsed(int.parse(id.text))) {
                            showToast("error, id is used ", States.ERORR);
                          } else if (cubit.documentHelper.filePickerResult == null) {
                            showToast("no file has selected", States.ERORR);
                          } else if (!cubit.checkIfUserHasEnoughCharge(
                            user:cubit.user, pages: pages, copies: copies)) {
                            showToast(
                                "sorry, your charge has enough", States.ERORR);
                          } else {
                            cubit.documentHelper.upLoadDocument(
                                id: int.parse(id.text),
                                pages: pages,
                                copies: copies);
                            cubit.documentHelper.endUploadFile();
                            showToast("doc ${id.text} added ", States.SUCCESS);
                          }
                        }
                      },
                      buttonColor: AppColors.primaryColor,
                      textColor: Colors.white,
                      child: Text(
                        "Upload",
                        style: AppTextStyles.buttonText(),
                      ),
                      buttonHeight: 60,
                      buttonMinWidth: double.infinity,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
