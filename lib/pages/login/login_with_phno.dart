import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../home_page.dart';

class PhoneNumberLogin extends StatefulWidget {
  @override
  _PhoneNumberLoginState createState() => _PhoneNumberLoginState();
}

class _PhoneNumberLoginState extends State<PhoneNumberLogin> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  User _firebaseUser;
  String _status;
  bool _isLoading = false;

  void _handleError(e) {
    print(e);
    setState(() {
      _status += e + '\n';
    });
  }

  AuthCredential _phoneAuthCredential;
  String _verificationId;
  int _code;

  Future<void> _getFirebaseUser() async {
    this._firebaseUser = await FirebaseAuth.instance.currentUser;
    setState(() {
      _status =
          (_firebaseUser == null) ? 'Not Logged In\n' : 'Already LoggedIn\n';
    });
  }

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(this._phoneAuthCredential)
          .then((UserCredential authRes) {
        _firebaseUser = authRes.user;
        print(_firebaseUser.toString());
      }).catchError((e) => _handleError(e));
      setState(() {
        {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
        _status += 'Signed In\n';
      });
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _logout() async {
    /// Method to Logout the `FirebaseUser` (`_firebaseUser`)
    try {
      // signout code
      await FirebaseAuth.instance.signOut();
      _firebaseUser = null;
      setState(() {
        _status += 'Signed out\n';
      });
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _submitPhoneNumber() async {
    String phoneNumber = "+91 " + _phoneNumberController.text.toString().trim();
    print(phoneNumber);

    void verificationCompleted(AuthCredential phoneAuthCredential) {
      print('verificationCompleted');
      setState(() {
        _status += 'verificationCompleted\n';
      });
      this._phoneAuthCredential = phoneAuthCredential;
      print(phoneAuthCredential);
    }

    void verificationFailed(FirebaseAuthException error) {
      print('verificationFailed');
      _handleError(error);
    }

    void codeSent(String verificationId, [int code]) {
      print('codeSent');
      this._verificationId = verificationId;
      print(verificationId);
      this._code = code;
      print(code.toString());
      setState(() {
        _status += 'Code Sent\n';
      });
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      print('codeAutoRetrievalTimeout');
      setState(() {
        _status += 'codeAutoRetrievalTimeout\n';
      });
      print(verificationId);
    }

    // PhoneAuthProvider.verifyPhoneNumber(
    //     PhoneAuthOptions
    //         .newBuilder(FirebaseAuth.instance)
    //         .setActivity(this)
    //         .setPhoneNumber(phoneNumber)
    //         .setTimeout(60L, TimeUnit.SECONDS)
    //         .setCallbacks(mCallbacks)
    //         .build());

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(milliseconds: 10000),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    ); // All the callbacks are above
  }

  void _submitOTP() {
    String smsCode = _otpController.text.toString().trim();

    this._phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: this._verificationId, smsCode: smsCode);

    _login();
  }

  void _reset() {
    _phoneNumberController.clear();
    _otpController.clear();
    setState(() {
      _status = "";
    });
  }

  void _displayUser() {
    setState(() {
      _status += _firebaseUser.toString() + '\n';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(16),
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 24),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 1,
                  child: MaterialButton(
                    onPressed: _submitPhoneNumber,
                    child: Text('Submit'),
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 48),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _otpController,
                    decoration: InputDecoration(
                      hintText: 'OTP',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 1,
                  child: MaterialButton(
                    onPressed: _submitOTP,
                    child: Text('Submit'),
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 48),
            SizedBox(height: 48),
            MaterialButton(
              onPressed: _login,
              child: Text('Login'),
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
