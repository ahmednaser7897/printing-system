//common
abstract class UserState {}
class Initial extends UserState {}
class ChangBottomBarIndex extends UserState{}
class LoadingGetAllUsers extends UserState{}
class CreateDB extends UserState{}
class LoadingCreateDB extends UserState{}
//user
class ChangePaymentMethod extends UserState{}
class GetUserRequests extends UserState{}
class GetUserData extends UserState{}

class LoadingGetUserALLRequests extends UserState{}
class GetUserALLRequests extends UserState{}
class InsertDocumentDataToDB extends UserState{}
class InsertDocumentStateDataToDB extends UserState{}
class UpLoadDocument extends UserState{}
class GetDocFromPhone extends UserState{}
class EndUploadFile extends UserState{}
class DeleteUserDoc extends UserState{}

class GetUserALLRequestsLoading extends UserState{}
class GetUserALLRequestsCompletedSuccessfully extends UserState{}
class RechargeUserWalletLoading extends UserState{}
class RechargeUserWalletSuccessfully extends UserState{}
class RechargeUserWalletError extends UserState{}
class OnUserLogout extends UserState{}