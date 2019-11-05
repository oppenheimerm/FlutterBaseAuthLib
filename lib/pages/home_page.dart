import 'package:base_auth_lib/pages/chat_page.dart';
import 'package:base_auth_lib/pages/dashboard_page.dart';
import 'package:base_auth_lib/pages/groups_page.dart';
import 'package:base_auth_lib/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:base_auth_lib/services/auth_service.dart';
import 'package:base_auth_lib/services/auth_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({this.onSignedOut, Key key}) : super(key: key);
  final VoidCallback onSignedOut;

  @override
  _HomePageState createState() => _HomePageState(onSignedOut: onSignedOut);
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  final VoidCallback onSignedOut;

  _HomePageState({this.onSignedOut});

  Future<void> _signOut(BuildContext context) async {
    try {
      final AuthService authService = AuthProvider.of(context).authService;
      await authService.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashbord'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text('Logout', style: TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: () => _signOut(context),
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Dashboard(),
          ChatPage(),
          GroupsPage(),
          ProfilePage()
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.teal,
        child: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.home),),
            Tab(icon: Icon(Icons.chat),),
            Tab(icon: Icon(Icons.group),),
            Tab(icon: Icon(Icons.person),)
          ],
        ),
      ),
    );
  }
}