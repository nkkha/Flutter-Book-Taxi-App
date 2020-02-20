import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taxiapp/src/blocs/auth_bloc.dart';
import 'package:flutter_taxiapp/src/resources/dialog/loading_dialog.dart';
import 'package:flutter_taxiapp/src/resources/dialog/msg_dialog.dart';
import 'package:flutter_taxiapp/src/resources/home_page.dart';
import 'package:flutter_taxiapp/src/resources/login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthBloc authBloc = new AuthBloc();

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xff3277D8)),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Image.asset('ic_car_red.png'),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 6),
                child: Text(
                  'Welcome Aboard!',
                  style: TextStyle(fontSize: 22, color: Color(0xff333333)),
                ),
              ),
              Text(
                'Signup with iCab in single steps',
                style: TextStyle(fontSize: 16, color: Color(0xff606470)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                child: StreamBuilder(
                  stream: authBloc.nameStream,
                  builder: (context, snapshot) => TextField(
                    controller: _nameController,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      errorText: snapshot.hasError ? snapshot.error : null,
                      labelText: 'Name',
                      prefixIcon: Container(
                        width: 50,
                        child: Image.asset('ic_user.png'),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffCED0D2), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                    ),
                  ),
                ),
              ),
              StreamBuilder(
                stream: authBloc.phoneStream,
                builder: (context, snapshot) => TextField(
                  controller: _phoneController,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    errorText: snapshot.hasError ? snapshot.error : null,
                    labelText: 'Phone Number',
                    prefixIcon: Container(
                      width: 50,
                      child: Image.asset('ic_phone.png'),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffCED0D2), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: StreamBuilder(
                  stream: authBloc.emailStream,
                  builder: (context, snapshot) => TextField(
                    controller: _emailController,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      errorText: snapshot.hasError ? snapshot.error : null,
                      labelText: 'Email',
                      prefixIcon: Container(
                        width: 50,
                        child: Image.asset('ic_mail.png'),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffCED0D2), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                    ),
                  ),
                ),
              ),
              StreamBuilder(
                stream: authBloc.passStream,
                builder: (context, snapshot) => TextField(
                  obscureText: true,
                  controller: _passController,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    errorText: snapshot.hasError ? snapshot.error : null,
                    labelText: 'Password',
                    prefixIcon: Container(
                      width: 50,
                      child: Image.asset('ic_user.png'),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffCED0D2), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: RaisedButton(
                    onPressed: _onSignUpClicked,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Color(0xff3277D8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Already a User? ',
                  style: TextStyle(color: Color(0xff606470), fontSize: 16),
                  children: [
                    TextSpan(
                      text: 'Login Now',
                      style: TextStyle(
                        color: Color(0xff327798),
                        fontSize: 16,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSignUpClicked() {
    bool isValid = authBloc.isValid(_nameController.text, _phoneController.text,
        _emailController.text, _passController.text);
    if (isValid) {
      // create user
      // loading dialog
      LoadingDialog.showLoadingDialog(context, 'Loading...');
      authBloc.signUp(_emailController.text, _passController.text,
          _nameController.text, _phoneController.text, () {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }, (msg) {
        // show msg dialog
            LoadingDialog.hideLoadingDialog(context);
            MsgDialog.showMsgDialog(context, 'Sign Up', msg);
      });
    }
  }
}
