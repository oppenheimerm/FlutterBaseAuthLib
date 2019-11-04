import 'package:flutter/material.dart';
import 'package:base_auth_lib/services/auth_service.dart';

//  This is our InheritedWidget class.  Whenever we need access to Auth object
//  (this class) we need to access it through this class
//  see: https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html
class AuthProvider extends InheritedWidget {
  const AuthProvider({Key key, Widget child, this.authService}) : super(key: key, child: child);
  final AuthService authService;

  //  Whether the framework should notify widgets that inherit from this widget.
  //  *** Required *** for extending InheritedWidget class,
  //  see: https://api.flutter.dev/flutter/widgets/InheritedWidget/updateShouldNotify.html
  //  Example:
  //  bool updateShouldNotify(FrogColor old) => color != old.color;
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  //  The convention is to provide a static method of on the InheritedWidget which does the
  //  call to BuildContext.inheritFromWidgetOfExactType. This allows the class to define
  //  its own fallback logic in case there isn't a widget in scope. In the example above,
  //  the value returned will be null in that case, but it could also have defaulted to
  //  a value.
  static AuthProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AuthProvider);
  }
}