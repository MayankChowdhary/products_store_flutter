import 'package:android_lyrics_player/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants/ScreenArguments.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = Strings.homeScreenRoute;

  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _LoginFormValidationState createState() => _LoginFormValidationState();
}

class _LoginFormValidationState extends State<HomeScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  static late SharedPreferences prefs;

  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  String validateFields(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 3) {
      return "Field should be at least 6 characters";
    } else if (value.length > 11) {
      return "Field should not be greater than 15 characters";
    } else
      return "";
  }

  bool validateLogin(String username, String password) {
    if (username == Strings.user1id && password == Strings.user1pass) {
      return true;
    } else if (username == Strings.user2id && password == Strings.user2pass) {
      return true;
    }
    return false;
  }

  void savePreferences(String username, String password) {
    //To save data in shared preference
    prefs.setString(
        'username', username); //'firstName' is key and 'ABC' is the value
    prefs.setString('password', password);
    prefs.setBool('login', true);
  }

  void retrieveLogin() {
    String username =
        prefs.getString('username') ?? ""; //Pass the key to retrieve saved data
    String password = prefs.getString('password') ?? "";
    debugPrint("Username:" + username);
    debugPrint("Password:" + password);
    if (username == Strings.user1id && password == Strings.user2id) {
      moveToHomeScreen();
    } else if (username == Strings.user2id && password == Strings.user2pass) {
      moveToHomeScreen();
    }
  }

  void moveToHomeScreen() {
    Navigator.pushReplacementNamed(context, Strings.songDetailsRoute,
        arguments: ScreenArguments(""));
  }

  final userNameValueHolder = TextEditingController();
  final passwordFieldValueHolder = TextEditingController();

  String username = '';
  String password = '';

  getTextInputData() {
    setState(() {
      username = userNameValueHolder.text;
      password = passwordFieldValueHolder.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          //check for validation while typing
          key: formkey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                      width: 200,
                      height: 150,
                      child: Image.asset('assets/mylogo.png')),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                    controller: userNameValueHolder,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                        hintText: 'Enter Username'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      MinLengthValidator(6,
                          errorText: "Username should be atleast 3 characters"),
                      MaxLengthValidator(15,
                          errorText:
                              "Username should not be greater than 11 characters")
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                    obscureText: true,
                    controller: passwordFieldValueHolder,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      MinLengthValidator(6,
                          errorText: "Password should be atleast 3 characters"),
                      MaxLengthValidator(15,
                          errorText:
                              "Password should not be greater than 11 characters")
                    ])
                    //validatePassword,        //Function to check validation
                    ),
              ),
              FlatButton(
                onPressed: () {
                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    getTextInputData();
                    if (formkey.currentState?.validate() == true &&
                        validateLogin(username, password)) {
                      savePreferences(username, password);
                      moveToHomeScreen();
                      print("Validated");
                    } else {
                      print("Not Validated");
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Text('New User? Create Account')
            ],
          ),
        ),
      ),
    );
  }
}
