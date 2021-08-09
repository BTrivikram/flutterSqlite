import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqlite/models/user.dart';
import 'package:flutter_sqlite/pages/login/login_with_phno.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  final _auth = FirebaseAuth.instance;
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _email, _password;

  LoginPagePresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginPagePresenter(this);
  }

  void _register() {
    Navigator.of(context).pushNamed("/register");
  }

  void _submit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', _presenter.toString());

    final form = formKey.currentState;
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString(
      'emailId',
    );
    // final user = await _auth.signInWithEmailAndPassword(
    //     email: _email, password: _password);
    // if (user != null) {
    //   Navigator.pushNamed(context, '/profilePage');
    // }

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_email, _password);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = GestureDetector(
      onTap: _submit,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue,
        ),
        alignment: Alignment.center,
        child: Text(
          "Login",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );

    var registerBtn = GestureDetector(
      onTap: _register,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 60),
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue,
        ),
        alignment: Alignment.center,
        child: Text(
          "Register",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
    var phnoBtn = GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PhoneNumberLogin()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 60),
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue,
        ),
        alignment: Alignment.center,
        child: Text(
          "Phno Login",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
    var loginForm = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            "Sqflite App Login",
            textScaleFactor: 2.0,
          ),
        ),
        Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new TextFormField(
                  onSaved: (val) => _email = val,
                  decoration: InputDecoration(
                      labelText: "Email", prefixIcon: Icon(Icons.email)),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: new InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.security),
                  ),
                ),
              )
            ],
          ),
        ),
        new Padding(padding: const EdgeInsets.all(10.0), child: loginBtn),
        SizedBox(
          height: 10,
        ),
        registerBtn,
        SizedBox(
          height: 20,
        ),
        phnoBtn
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Login Page"),
      ),
      key: scaffoldKey,
      body: new Container(
        child: new Center(
          child: loginForm,
        ),
      ),
    );
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showSnackBar("Login not successful");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(Auser user) async {
    // TODO: implement onLoginSuccess
    if (user.username == "") {
      _showSnackBar("Login not successful");
    } else {
      _showSnackBar('Not Registered');
    }
    setState(() {
      _isLoading = false;
    });
    if (user.flaglogged == "logged") {
      print("Logged");
      Navigator.of(context).pushNamed("/home");
    } else {
      print("Not Logged");
    }
  }
}
