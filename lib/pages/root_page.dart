import 'package:flutter/material.dart';
import 'package:base_auth_lib/services/auth_provider.dart';
import 'package:base_auth_lib/services/auth_service.dart';
import 'package:base_auth_lib/pages/login_page.dart';
import 'package:base_auth_lib/pages/home_page.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

enum AuthStatus {
  notDetermined,
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notDetermined;

  //  Because or AuthProvider object inherits from the InheritedWidget
  // class we cannot use initState() because at that state the object is
  // not fully initialized.  We must use didChangeDependencies() to
  //  initialize our app
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AuthService authService = AuthProvider.of(context).authService;
    authService.currentUser().then((user) {
      setState(() {
        authStatus = user == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
        if(user != null)
        {
          print("userid: ${user.uid} username: ${user.email}");
        }
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notDetermined:
        return _buildWaitingScreen();
      case AuthStatus.notSignedIn:
        return LoginPage(
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return HomePage(
          onSignedOut: _signedOut,
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