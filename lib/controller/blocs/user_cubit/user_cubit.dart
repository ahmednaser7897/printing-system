// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:print_system/controller/blocs/cubit_helper.dart';
import 'package:print_system/controller/blocs/user_cubit/userHelper.dart';
import 'package:print_system/controller/blocs/user_cubit/user_state.dart';
import 'package:print_system/main.dart';
import 'package:print_system/model/Other/document.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:print_system/model/person/user.dart';
import '../../../model/Other/document.dart';
import '../../../model/payment.dart/payment_method_factory.dart';
import '../../../model/person/userDocs.dart';
import '../../../view/components/app_theme.dart';
import '../../../view/user/logout_screen.dart';
import '../../../view/user/printing_jobs_view_screen.dart';
import '../../../view/user/recharge_wallet_screen.dart';
import '../../../view/user/upload_document_screen.dart';

class UserCubit extends Cubit<UserState> with CubitHelper, UserHelper {
  UserCubit() : super(Initial());
  static UserCubit get(context) => BlocProvider.of(context);

  UserDocumentHelper documentHelper = UserDocumentHelper();
  int selectedPaymentMethodIndex = -1;
  int userBottomBarCurrentIndex = 0;
  List<Widget> userScreens = [
    const PrintingJobsViewScreen(),
    UploadDocumentScreen(),
    RechargeWalletScreen(),
    const LogoutScreen(),
  ];

  void createDataBase() async {
    emit(LoadingCreateDB());
    await db.createDB();
    emit(CreateDB());
  }

  changeUserBottomBarIndex(int value) async {
    userBottomBarCurrentIndex = value;
    if (userBottomBarCurrentIndex == 0) {
      getUserRequests();
    }
    emit(ChangBottomBarIndex());
  }

  void changeSelectedPaymentMethod(int index) {
    selectedPaymentMethodIndex = index;
    print("index is " + selectedPaymentMethodIndex.toString());
    emit(ChangePaymentMethod());
  }

  late User user;
  getUserData() async {
    user = await getUser(personId!);
    emit(GetUserData());
  }

  //printing jop screen functions
  List<String> states = ["new", "accepted", "done"];
  getUserRequests() async {
    emit(LoadingGetUserALLRequests());
    userRequests = [];
    getUserNewDocs("new").then((_) {
      emit(GetUserALLRequests());
      getUserNewDocs("accepted").then((_) {
        emit(GetUserALLRequests());
        getUserNewDocs("done").then((_) {
          emit(GetUserALLRequests());
        });
      });
    });
  }

  List<UserDoc> userRequests = [];
  getUserNewDocs(type) async {
    List<Document> temp = await getUserDocs(type);
    for (var i in temp) {
      userRequests.add(UserDoc(type, i));
      emit(GetUserALLRequests());
    }
  }

  void deleteUserDocuments(UserDoc doc) {
    doc.deleteUserDocuments();
    userRequests.remove(doc);
    emit(DeleteUserDoc());
  }

  //other
  void rechargeUserWallet(int amount) async {
    emit(RechargeUserWalletLoading());
    await db
        .updateUserTable("charge", user.charge + amount, user.id)
        .then((value) {
      submitUserPayment(amount);
      emit(RechargeUserWalletSuccessfully());
    }).catchError((error) {
      emit(RechargeUserWalletError());
      showToast("sorry, an error has occurred", States.ERORR);
      print("error is $error");
    });
  }

  void submitUserPayment(int amount) {
    PaymentMethodFactory paymentMethodFactory=
    PaymentMethodFactory(methodIndex:selectedPaymentMethodIndex );
    paymentMethodFactory.paymentMethod.withdraw(amount);
    String textTowShow = paymentMethodFactory.paymentMethod.withdraw(amount);
    print(textTowShow);
    showToast(textTowShow, States.SUCCESS);
  }

  void onUserLogout() {
    userRequests = [];
    documentHelper.endUploadFile();
    emit(OnUserLogout());
  }
}
