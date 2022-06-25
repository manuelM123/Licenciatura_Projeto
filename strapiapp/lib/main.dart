// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_import, must_be_immutable, prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, todo, import_of_legacy_library_into_null_safe, avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'buttons.dart';
import 'dialog.dart';
import 'main_page.dart';
import 'about_us_page.dart';
import 'register_page.dart';
import 'role.dart';
import 'data.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';
import 'package:http_parser/http_parser.dart';
import 'package:strapiapp/dialog.dart';

///Initial page for Strapi App

///This page it's the first one to appear to the user and provides the following structure:
///1 - Representative image of the Strapi Logo;
///2 - Login functionality for user's that possess an account on Strapi;
///3 - Register button to redirect user to another page that provides the register functionality;
///4 - Reset password button to redirect user to another page that provides the reset password functionality
///This page extends a type of widget named "StatelessWidget", this kind of widget specifies that this widget never changes acording user input

class MyScaffold extends StatelessWidget {
  const MyScaffold({Key? key}) : super(key: key);

  ///this url specifies the typing of testing for the application and further HTTP Requests
  ///yourIPAddress for real time testing
  ///10.0.2.2 for emulator testing
  ///localhost for iOS testing
  //static String url = "192.168.1.72";
  //static String url = "localhost";

  static String url = "10.0.2.2";
  static late double sizes;
  static late double sizes1;

  @override
  Widget build(BuildContext context) {
    ///getting size of device's screen to implement responsiveness in widgets
    sizes = MediaQuery.of(context).size.height;
    sizes1 = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 164, 211),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ///element that holds logo of Strapi
          Positioned(
            top: sizes - (sizes - 110.0),
            child: Image.asset(
              "images/logostrapi.png",
              width: sizes1 - 40.0,
              height: 120.0,
            ),
          ),

          ///element that holds email textfield for user input
          Positioned(
            top: sizes - ((sizes / 1.7)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0),
              child: TextInputs2(),
              width: sizes1 - (sizes1 / 8),
            ),
          ),

          ///element that holds password textfield for user input
          Positioned(
            top: sizes - (sizes / 2.05),
            child: Container(
              //height: 55.0,
              padding: EdgeInsets.symmetric(horizontal: 80.0),
              child: TextInputs(),
              width: sizes1 - (sizes1 / 8),
            ),
          ),

          ///element that holds the button for login functionality
          Positioned(
            top: sizes - (sizes / 3),
            child: Buttons(name: "Login"),
          ),

          ///element that holds the button for register
          Positioned(
            top: sizes - (sizes / 3) + 80.0,
            child: Buttons(
              name: 'Registar',
            ),
          ),

          ///element that holds the button for reset password
          Positioned(
            top: sizes - (sizes / 3) + 160.0,
            //width: sizes1RP - (sizes1RP / 2),
            child: Buttons(name: 'Reset Password'),
          ),
        ],
      ),
      //),
    );
  }
}

///class that implements the email textfield widget
class TextInputs2 extends StatefulWidget {
  const TextInputs2({Key? key}) : super(key: key);

  ///control variable [value2] that will have the value stored by textfield controller
  static late TextEditingController value2;

  ///operation to create state of the widget
  @override
  State<TextInputs2> createState() => _TextInputsState2();
}

///class that holds the state of the widget of email textfield
class _TextInputsState2 extends State<TextInputs2> {
  late final control2;

  ///function that initiates the state of the widget
  ///variable [control2] that will hold the value introduced by user's input in the email textfield
  ///control variable [value2] will have the value of the variable  [control2]
  @override
  void initState() {
    control2 = TextEditingController();
    TextInputs2.value2 = control2;
    super.initState();
  }

  ///building of the textfield widget for email input
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: control2,

      ///according to user input the value of [value2] changes as does the value of [control2]
      onChanged: (value) {
        TextInputs2.value2 = control2;
      },
      textAlignVertical: TextAlignVertical.bottom,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black)),
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Color.fromARGB(255, 255, 255, 255),
        hintText: 'Email',
      ),

      ///max password of 80 characters
      inputFormatters: [LengthLimitingTextInputFormatter(80)],
    );
  }
}

///class that implements the password textfield widget
class TextInputs extends StatefulWidget {
  const TextInputs({Key? key}) : super(key: key);

  ///control variable [value] that will have the value stored by textfield controller
  static late TextEditingController value;

  ///operation to create state of the widget
  @override
  State<TextInputs> createState() => _TextInputsState();
}

///class that holds the state of the widget of password textfield
class _TextInputsState extends State<TextInputs> {
  late final control;

  ///function that initiates the state of the widget
  ///variable [control] that will hold the value introduced by user's input in the password textfield
  ///control variable [value] will have the value of the variable [control]
  @override
  void initState() {
    control = TextEditingController();
    TextInputs.value = control;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: control,
      obscureText: true,

      ///according to user input the value of [value] changes as does the value of [control]
      onChanged: (value) {
        TextInputs.value = control;
      },
      textAlignVertical: TextAlignVertical.bottom,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black)),
        filled: true,
        fillColor: Color.fromARGB(255, 255, 255, 255),
        hintText: 'Password',
      ),

      ///max password of 80 characters
      inputFormatters: [LengthLimitingTextInputFormatter(80)],
    );
  }
}

///this function is responsible for the process of login/authentication of user in Strapi
///function login takes as parameters:
///[context] that will be used for further dialogs, this value groups the context of the widget
///[urlAuthUser] this url will be used in a further POST Request to call the Strapi api
///this function is an asynchronous function as it takes a http request to be done in the background
void login(BuildContext context, String urlAuthUser) async {
  ///the following variables are to be used as follows:
  ///[uri] this variable parses the [urlAuthUser] to be used in POST Request
  ///[headers] this variable holds the value of headers to be used in POST Request
  ///[body] this variable holds the body to be used in POST Request
  ///[jsonBody] this variable will encode the [body] for it to be used as a JSON in POST Request
  ///[encoding] specifies the type of encoding to be used in POST Request

  final uri = Uri.parse(urlAuthUser);
  final headers = {'Content-Type': 'application/json'};
  Map<String, dynamic> body = {
    'identifier': TextInputs2.value2.text,
    'password': TextInputs.value.text
  };
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  try {
    ///variable [response] will hold the content that the POST Request returns
    ///this POST Request is declared on a timeout, this timeout specifies a duration of 10 seconds, this is used to determine if the server is offline or not
    var response = await http
        .post(uri, headers: headers, body: jsonBody, encoding: encoding)
        .timeout(const Duration(seconds: 10));

    ///if the value of [response.statusCode] is 200 then that means the authentication of the user was successfull
    ///in a sucessfull authentication the response in it's content will have a JWT Token that will be used to identify that specific user in further operations
    if (response.statusCode == 200) {
      ///[jsBody] will have the JSON content in a decoded form to be used in class Data that will group different attributes according to content present in [jsBody]
      var jsBody = jsonDecode(response.body);
      Data dl = Data.fromJson(jsBody);

      ///the variable [jwtToken] holds authentication code generated when user has performed a sucessfull authentication
      String jwtToken = dl.jwt;

      ///the variable [Buttons.jwtToken] holds the same value as [jwtToken] to be used in further operations of the application
      Buttons.jwtToken = jwtToken;

      ///the variable [userName] holds the username of the user that has logged-in and this will be used as a Text element in the appBar of the main menu page
      String? userName = dl.user?.username;

      ///dialog containing a sucessfull message to be shown to the user when he performs a sucessfull login
      ///this dialog pops after 2 seconds to give enough time for the user to read
      DialogsUser().dialog(
          context, "Login bem sucedido", "Redirecionando para menu...", 1);
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context).pop();

      ///redirecting user to main page menu after successful login attempt
      ///MainPage class takes a parameter [userName] that contains the value of his username in account
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MainPage(user_name: userName)));
    }

    ///if the response provided after the POST Request returns a error 400 a dialog will show the user a error message
    else if (response.statusCode == 400) {
      DialogsUser().dialog(context, "Credenciais incorretas!",
          "Volte a inserir credenciais!", 0);
    }

    ///in case the timeout defined above reaches 10 seconds the following dialog error is presented to the user indicating him the server is offline
  } on TimeoutException {
    DialogsUser().dialog(context, 'Erro de Conexão!', 'Servidor Offline!', 0);
  }
}

///this function defines the url to be used in another function to perform a POST Request
///this function takes as parameter [context] to be passed on to function login
void fetchUsers(BuildContext context) {
  ///autenticate a user by sending a post request to auth/local api in Strapi
  var urlAuthUser = 'http://${MyScaffold.url}:1337/api/auth/local';

  login(context, urlAuthUser);
}

///this function takes as parameters:
///[context] that holds the context of the widget to be used in dialogs
///[urlGet] that holds the url needed to verify a certain call to the Strapi api
Future<bool?> verifyServerStatus(BuildContext context, String url) async {
  ///the variable response will hold the content of the GET Request
  ///this GET Request has a timeout that has a duration of 10 seconds, if this 10 seconds are reached it will be shown to the user a dialog message informing the server is offline
  try {
    var response =
        await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));

    ///if the [response.statusCode] has the value 200 then the function returns true through [Future<bool>.value(true)]
    if (response.statusCode == 200) {
      return Future<bool>.value(true);
    }
  } on TimeoutException {
    DialogsUser().dialog(context, 'Erro de Conexão!', 'Servidor Offline!', 0);
  }

  ///if the [response.statusCode] hasn't the value 200 then the function returns false through [Future<bool>.value(false)]
  return Future<bool>.value(false);
}

///main to run the application
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'StrapiApp',

    /// used by the OS task switcher
    /// first structure to initialize when application starts
    home: MyScaffold(),
  ));
}
