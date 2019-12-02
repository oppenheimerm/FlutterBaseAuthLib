import 'package:base_auth_lib/core/enums/types.dart';
import 'package:base_auth_lib/core/view_models/root_model.dart';
import 'package:base_auth_lib/ui/views/base_view.dart';
import 'package:base_auth_lib/ui/views/home_view.dart';
import 'package:base_auth_lib/ui/views/login_view.dart';
import 'package:flutter/material.dart';

class RootView extends StatefulWidget {
  @override
  _RootViewState createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<RootModel>(
      builder: (context, model, child) => conditionalBuild(context, model)
    );
  }

  Widget conditionalBuild(BuildContext context, RootModel model) {
    AuthStatus authStatus = model.getAuthStatus();

    switch (authStatus) {
      case AuthStatus.notDetermined:
        return _buildWaitingScreen();
      case AuthStatus.notSignedIn:
        return LoginView(
          onSignedIn: model.signedIn,
        );
      case AuthStatus.signedIn:
        return HomeView(
          onSignedOut: model.signedOut,
        );
    }
    return null;
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

}
