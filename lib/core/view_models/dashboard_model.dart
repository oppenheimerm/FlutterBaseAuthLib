import 'package:base_auth_lib/core/enums/types.dart';
import 'package:base_auth_lib/core/models/user.dart';
import 'package:base_auth_lib/core/services/auth_service.dart';
import 'package:base_auth_lib/core/view_models/CRUDModel.dart';
import 'package:base_auth_lib/core/view_models/base_model.dart';
import 'package:base_auth_lib/locator.dart';

class DashboardModel extends BaseModel {
  //UserApi _api = locator<Api>();
  AuthService _authService = locator<AuthService>();
  CRUDModel _crudModel = locator<CRUDModel>();

  User userDetails;

  Future<User> getUser(String uid) async {
    setState(ViewState.Busy);
    var user = await _authService.currentUser();
    userDetails = await _crudModel.getUserById(user.uid);
    setState(ViewState.Idle);
    return userDetails;
  }
}