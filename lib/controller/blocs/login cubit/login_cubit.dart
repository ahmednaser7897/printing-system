import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/database/database.dart';
import '../../../model/log in/loginType.dart';
import '../../../model/person/person.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitLogin());
  static LoginCubit get(context) => BlocProvider.of(context);
  DataBase db = DataBase();
  bool showPassword = false;
  void changePasswordVisibilityRegistration() {
    showPassword = !showPassword;
    emit(ChangePasswordVisibilityRegistration());
  }

  bool showPass = false;
  void changePasswordVisibility() {
    showPass = !showPass;
    emit(ChangePasswordVisibility());
  }

  registerLogin({email, pass, name, phone}) async {
    emit(LoadingRegistration());
    emit(ScRegister());
    emit(ErrorRegister('The password provided is too weak.'));
    print('The password provided is too weak.');
  }

  late Person person;
  LoginType logInType = LoginType();
  login(String username, int passWord) async {
    emit(LoadingLogin());
    Person personToLogin = Person("nan", 0, 0, "nan");

    person = await logInType.login(username, passWord, personToLogin);
    print("cubit " + person.name.toString());
    print("cubit " + logInType.isLogged().toString());
    print("cubit user" + logInType.isUserLogged().toString());
    print("cubit admin" + logInType.isAdminLogged().toString());
    print("cubit rel" + logInType.isReleaseManLogged().toString());
    emit(ScLogin());
  }

  void createDataBase() {
    db.createDB();
    emit(createLogInDB());
  }

  Future<void> logOut() async {}
}
