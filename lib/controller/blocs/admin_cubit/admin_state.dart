//common
abstract class AdminState {}
class Initial extends AdminState {}
class ChangBottomBarIndex extends AdminState{}
class LoadingGetAllUsers extends AdminState{}
class CreateDB extends AdminState{}
class LoadingCreateDB extends AdminState{}

//admin
class GetAllUsers extends AdminState{}
class DeleteUserFromDB extends AdminState{}
class AddUserToDB extends AdminState{}
class LoadingGetAllPrinters extends AdminState{}
class GetAllPrinters extends AdminState{}
class GetRequests extends AdminState{}
class GetNewRequests extends AdminState{}
class LoadingGetNewRequests extends AdminState{}


class GetDoneRequests extends AdminState{}
class GetAcceptedRequests extends AdminState{}
class AcceptUserRequest extends AdminState{}
class RejectUserRequest extends AdminState{}
class OnAdminLogout extends AdminState{}
