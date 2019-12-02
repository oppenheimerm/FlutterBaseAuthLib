import 'package:base_auth_lib/ui/views/root_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:base_auth_lib/core/models/user.dart';
import 'package:base_auth_lib/core/services/auth_service.dart';
import 'package:base_auth_lib/locator.dart';


void main() {
  //  call setupLocator before we run the app
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>(
      initialData: User.initial(),
      builder: (context) => locator<AuthService>().getStreamController().stream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter login demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RootView(),
      ),
    );
  }
}
