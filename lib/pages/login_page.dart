import 'package:flutter/material.dart';
import 'package:base_auth_lib/services/auth_service.dart';
import 'package:base_auth_lib/services/auth_provider.dart';
import 'package:base_auth_lib/models/user.dart';
import 'package:base_auth_lib/services/form_validation.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({this.onSignedIn});
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

enum FormType {
  login,
  register,
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  String _email;
  String _password;
  String _displayName;
  FormType _formType = FormType.login;
  //  ‘autovalidate’ is used to validate the input as soon as we enter the data.
  //  Initially it is set it to false.  The reason that it is initially set to
  //  false, is because when the user opens the form, all the fields will by
  //  default empty, and an empty field is invalid. We don’t want to show such
  //  an invalid error.
  //
  //  Once the user submits the form, if there are any validation error then
  //  we'll start validating the input automatically by updating _autoValidate to true.
  bool _autoValidate = false;

  bool validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> validateAndSubmit() async {
    print("validateAndSubmit() called!");
    if (validateAndSave()) {
      try {
        final AuthService authService = AuthProvider.of(context).authService;
        if (_formType == FormType.login) {
          final User _user = await authService.signInWithEmailAndPassword(_email, _password);
          print('Signed in: ${_user.uid}');
        } else {
          final User _user = await authService.createUserWithEmailAndPassword(_email, _password, _displayName);
          print('Registered user: ${_user.uid}');
        }
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final AuthService authService = AuthProvider.of(context).authService;
      final User _user = await authService.signInWithGoogle();
      widget.onSignedIn();
    }
    catch(e){
      print('Google SignIn Error: $e');
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: ListView(
        children: <Widget>[
          //  Hero title
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text('Hello', style: TextStyle(
                    fontSize: 80.0,fontWeight: FontWeight.bold,),),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 175.0, 0.0, 0.0),
                  child: Text('There', style: TextStyle(fontSize: 80.0,fontWeight: FontWeight.bold),),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
                  child: Text('.', style: TextStyle(fontSize: 80.0,fontWeight: FontWeight.bold, color: Colors.green),),
                ),
              ],
            ),
          ),
          //  Form layout
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Form(
              key:formKey,
              autovalidate: _autoValidate,
              child: Column(
                children: buildInputs() + buildSubmitButtons(),
              ),
            ),
          ),

        ],
      ),
    );
  }

  List<Widget> buildInputs() {


    if (_formType == FormType.register) {
      return <Widget>[
        //  Email entry
        TextFormField(
          key: Key('email'),
          decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              color: Colors.grey
          ),
            //style focus underline colour
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green)
            ),
          ),
          validator: EmailFieldValidator.validate /*longhand version - (value) => EmailFieldValidator.validate(value)*/,
          onSaved: (String value) => _email = value,
        ),
        SizedBox(height:20.0),
        //  Password entry
        TextFormField(
          key: Key('password'),
          decoration: InputDecoration(labelText: 'Password', labelStyle: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              color: Colors.grey
          ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)
              )),
          obscureText: true,
          validator: PasswordFieldValidator.validate,
          onSaved: (String value) => _password = value,
        ),

        SizedBox(height:20.0),
        TextFormField(
          key: Key('displayname'),
          decoration: InputDecoration(labelText: 'Display name', labelStyle: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              color: Colors.grey
          ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)
              )),
          validator: DisplayNameValidator.validate,
          onSaved: (String value) => _displayName = value,
        ),



        Container(
          alignment: Alignment(1.0, 0.0),
          padding: EdgeInsets.only(top:15.0, left: 20.0),
          child: InkWell(
            child: Text('Forgot Password',
              style: TextStyle(color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                  decoration: TextDecoration.underline),),
            onTap: (){},
          ),
        ),
        SizedBox(height: 20.0),
      ];
    }else{
      return <Widget>[
        //  Email entry
        TextFormField(
          key: Key('email'),
          decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              color: Colors.grey
          ),
            //style focus underline colour
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green)
            ),
          ),
          validator: EmailFieldValidator.validate /*longhand version - (value) => EmailFieldValidator.validate(value)*/,
          onSaved: (String value) => _email = value,
        ),
        SizedBox(height:20.0),
        //  Password entry
        TextFormField(
          key: Key('password'),
          decoration: InputDecoration(labelText: 'Password', labelStyle: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              color: Colors.grey
          ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)
              )),
          obscureText: true,
          validator: PasswordFieldValidator.validate,
          onSaved: (String value) => _password = value,
        ),
        Container(
          alignment: Alignment(1.0, 0.0),
          padding: EdgeInsets.only(top:15.0, left: 20.0),
          child: InkWell(
            child: Text('Forgot Password',
              style: TextStyle(color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                  decoration: TextDecoration.underline),),
            onTap: (){},
          ),
        ),
        SizedBox(height: 20.0),
      ];
    }

  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return <Widget>[
        //  Login button
        Container(
          height: 40.0,
          child: Material(
            key: Key("signIn"),
            borderRadius: BorderRadius.circular(20.0),
            shadowColor: Colors.greenAccent,
            color: Colors.green,
            elevation: 4.0,
            child: GestureDetector(
              onTap: () => validateAndSubmit(),
              child: Center(
                child: Text("LOGIN",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato'
                  ),),
              ),
            ),
          ),
        ),
        //
        SizedBox(height: 20.0,),
        //  Login with facebook button
        Container(
          height: 40.0,
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () => _signInWithGoogle(),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.0
                  ),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20.0)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    /*child: ImageIcon(AssetImage('assets/google_logo.png')),*/
                    child: Image(
                      image: AssetImage('assets/google_logo.png'),
                      height: 24.0,
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Center(
                    child: Text("Sign In with Google",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Lato"
                      ),),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          alignment: Alignment(1.0, 0.0),
          padding: EdgeInsets.only(top:15.0, left: 20.0),
          child: InkWell(
            child: Text('Create an account',
              style: TextStyle(color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                  decoration: TextDecoration.underline),),
            onTap: () => moveToRegister(),
          ),
        ),

      ];
    } else {
      return <Widget>[
        //  Login button
        Container(
          height: 40.0,
          child: Material(
            borderRadius: BorderRadius.circular(20.0),
            shadowColor: Colors.greenAccent,
            color: Colors.green,
            elevation: 4.0,
            child: GestureDetector(
              onTap: () => validateAndSubmit(),
              child: Center(
                child: Text("Create Account",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato'
                  ),),
              ),
            ),
          ),
        ),

        SizedBox(height: 20.0,),

        Container(
          alignment: Alignment(1.0, 0.0),
          padding: EdgeInsets.only(top:15.0, left: 20.0),
          child: InkWell(
            child: Text('Have an account? Login',
              style: TextStyle(color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                  decoration: TextDecoration.underline),),
            onTap: () => moveToLogin(),
          ),
        ),

      ];
    }
  }
}