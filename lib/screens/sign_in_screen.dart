import 'package:fix_map/blocs/authentication/authentication_bloc.dart';
import 'package:fix_map/blocs/authentication/authentication_event.dart';
import 'package:fix_map/blocs/authentication/authentication_state.dart';
import 'package:fix_map/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInScreen extends StatefulWidget {
  static final String routeName = "signin";
  final AuthenticationBloc authenticationBloc;

  const SignInScreen({Key key, this.authenticationBloc}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var _account = {
    "email": "",
    "password": "",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        bloc: widget.authenticationBloc,
        listener: (context, state) {
          if (state is AuthenticationSignedInState) {
            Fluttertoast.showToast(msg: "Signed In");
            Navigator.of(context).maybePop();
          }
        },
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: widget.authenticationBloc,
          builder: (context, state) {
            return Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        ClipPath(
                          clipper: WaveClipper2(),
                          child: Container(
                            child: Column(),
                            width: double.infinity,
                            height: 300,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                              Theme.of(context).primaryColorLight,
                              Theme.of(context).primaryColorDark,
                            ])),
                          ),
                        ),
                        ClipPath(
                          clipper: WaveClipper3(),
                          child: Container(
                            child: Column(),
                            width: double.infinity,
                            height: 300,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                              Theme.of(context).primaryColorDark,
                              Theme.of(context).primaryColorLight,
                            ])),
                          ),
                        ),
                        ClipPath(
                          clipper: WaveClipper1(),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 40,
                                ),
                                Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                  size: 60,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Fix Map",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 30),
                                ),
                              ],
                            ),
                            width: double.infinity,
                            height: 300,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor,
                            ])),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Input(
                          obscureText: false,
                          id: "email",
                          onChange: handleOnChange,
                          hintText: "Email",
                          icon: Icon(
                            Icons.email,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Input(
                          obscureText: true,
                          id: "password",
                          onChange: handleOnChange,
                          hintText: "Password",
                          icon: Icon(
                            Icons.lock,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            color: Theme.of(context).primaryColorDark,
                          ),
                          child: FlatButton(
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                            onPressed: () {
                              onSubmit();
                            },
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text("or continue with"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton.icon(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.0)),
                          color: Colors.red,
                          icon: Icon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                          label: Text(
                            "Google",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {},
                        ),
                        SizedBox(width: 10.0),
                        RaisedButton.icon(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.0)),
                          color: Colors.indigo,
                          icon: Icon(
                            FontAwesomeIcons.facebook,
                            color: Colors.white,
                          ),
                          label: Text(
                            "Facebook",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 40.0),
                    Center(
                      child: Text(
                        "FORGOT PASSWORD ?",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't have an Account ? ",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.normal),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(SignUpScreen.routeName);
                          },
                          child: Text("Sign Up ",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  decoration: TextDecoration.underline)),
                        ),
                      ],
                    ),
                  ],
                ),
                state is AuthenticationErrorState
                    ? Align(
                        child: Text(state.message),
                        alignment: Alignment.topCenter,
                      )
                    : Container(),
                state is AuthenticationLoadingState
                    ? Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                        color: Colors.white.withOpacity(0.8),
                      )
                    : Container()
              ],
            );
          },
        ),
      ),
    );
  }

  void handleOnChange(String id, String value) {
    this._account.forEach((k, v) {
      if (k == id) {
        this._account[k] = value;
      }
    });
  }

  void onSubmit() {
    if (this._account["email"] == "") return;
    if (this._account["password"] == "") return;

    widget.authenticationBloc.add(AuthenticationSignInEvent(
        this._account["email"], this._account["password"], ""));
  }
}
