import 'package:base_auth_lib/core/services/auth_service.dart';
import 'package:base_auth_lib/core/view_models/base_model.dart';
import 'package:base_auth_lib/locator.dart';

class HomeModel extends BaseModel {

  AuthService authService = locator<AuthService>();

  HomeModel(){
    authService = locator<AuthService>();
  }

}