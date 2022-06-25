// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:strapiapp/dialog.dart';

///User's page to register a account in Strapi

import 'buttons.dart';
import 'main_page.dart';
import 'role.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  ///[sizesRP] variable that will hold the height of the device
  static late double sizesRP;

  ///[sizes1RP] variable that hill hold the width of the device
  static late double sizes1RP;

  ///[rolesList] list of integers that will hold values for specific roles in Strapi
  static late List<int?> rolesList;

  @override
  Widget build(BuildContext context) {
    ///[sizesRP] holds the height of the device
    sizesRP = MediaQuery.of(context).size.height;

    ///[sizes1RP] holds the width of the device
    sizes1RP = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF00A4D3),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ///textfield where user can insert his username
          Positioned(
            top: sizesRP - ((sizesRP / 1.2)),
            width: sizes1RP - (sizes1RP / 20),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0),
              child: TextRegisterUsername(),
            ),
          ),

          ///textfield where user can insert his email
          Positioned(
            top: sizesRP - ((sizesRP / 1.5)),
            width: sizes1RP - (sizes1RP / 20),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0),
              child: TextRegisterEmail(),
            ),
          ),

          ///textfield where user can insert his password
          Positioned(
            top: sizesRP - ((sizesRP / 2)),
            width: sizes1RP - (sizes1RP / 20),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0),
              child: TextRegisterPassword(),
            ),
          ),

          ///button where user can confirm his registry
          Positioned(
            top: sizesRP - ((sizesRP / 3)),
            width: sizes1RP - (sizes1RP / 2),
            child: Buttons(name: 'Confirmar Registo'),
          ),

          ///button to cancel registry
          Positioned(
            top: sizesRP - ((sizesRP / 4)),
            width: sizes1RP - (sizes1RP / 2),
            child: Buttons(name: 'Cancelar'),
          )
        ],
      ),
    );
  }
}

///class that implements functionality of username entering in RegisterPage
class TextRegisterUsername extends StatefulWidget {
  TextRegisterUsername({Key? key}) : super(key: key);

  ///control variable [valueUsername] that will hold the value of the controller of this textfield
  static late TextEditingController valueUsername;

  ///operation to create the state of the widget
  @override
  State<TextRegisterUsername> createState() => _TextRegisterUsername();
}

///class that holds the state of the widget of username textfield in RegisterPage
class _TextRegisterUsername extends State<TextRegisterUsername> {
  late final controlUsername;

  ///function to initiate then state of the widget
  ///[controlUsername] is specified as the controller for this textfield
  ///[TextRegisterUsername.valueUsername] holds the value of the variable [controlUsername]
  @override
  void initState() {
    controlUsername = TextEditingController();
    TextRegisterUsername.valueUsername = controlUsername;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.bottom,
      controller: controlUsername,

      ///when user performs a change in the textfield, [TextRegisterUsername.valueUsername] will be updated with the value of [controlUsername]
      onChanged: (value) {
        TextRegisterUsername.valueUsername = controlUsername;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black)),
        filled: true,
        fillColor: Color.fromARGB(255, 255, 255, 255),
        hintText: 'Username',
      ),
      //max password of 30 characters
      inputFormatters: [LengthLimitingTextInputFormatter(30)],
    );
  }
}

///class that implements functionality of email entering in RegisterPage
class TextRegisterEmail extends StatefulWidget {
  TextRegisterEmail({Key? key}) : super(key: key);

  ///control variable [valueEmail] that will hold the value of the textfield controller
  static late TextEditingController valueEmail;

  ///boolean variable [validEmail] that will be used to validate email value inserted by user in textfield
  static bool validEmail = false;

  ///operation to create the state of the widget
  @override
  State<TextRegisterEmail> createState() => _TextRegisterEmail();
}

///class that holds the state of the widget of email textfield in RegisterPage
class _TextRegisterEmail extends State<TextRegisterEmail> {
  ///[controlEmail] to be used as the controller of this textfield
  late final controlEmail;

  ///function to initiate the state of the widget
  @override
  void initState() {
    ///[controlEmail] is specified as the controller of this textfield
    controlEmail = TextEditingController();

    ///[TextRegisterEmail.valueEmail] holds the value of the variable [controlEmail]
    TextRegisterEmail.valueEmail = controlEmail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///this function is used to validade email inserted by user using a regex
    ///it's parameter is:
    ///[val] variable that holds the email for regex to be applied on
    ///this regex matches the [val] when this variable has '@' and '.' in it's value
    bool validateEmail(String val) {
      ///if [val] matches the regex then the email is valid and the function returns true
      if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(val)) {
        return true;
      }

      ///if [val] doesn't match the regex then the email is not valid and the function returns false
      return false;
    }

    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      controller: controlEmail,

      ///when user performs a change in textfield content, [TextRegisterEmail.valueEmail] will be updated with the value of [controlEmail]
      onChanged: (value) {
        TextRegisterEmail.valueEmail = controlEmail;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black)),
        filled: true,
        fillColor: Color.fromARGB(255, 255, 255, 255),
        hintText: 'Email',
        errorStyle: TextStyle(fontWeight: FontWeight.bold),
      ),

      ///validator of the textfield which groups the validateEmail function to validate email inserted by user
      ///this validator presents a user a underlying error message at the beginning informing him the content of the email is not valid
      ///this message disappears when user inserts a valid email value
      validator: (value) {
        bool validate = validateEmail(value!);

        ///if the email is not empty and [validate] is true then [TextRegisterEmail.validEmail] is set to true
        ///then validator does not return any underlying error message
        if (value != '' && validate) {
          TextRegisterEmail.validEmail = true;
          return null;
        }

        ///if the above condition does not verify then the [TextRegisterEmail.validEmail] is set to false
        ///then the validator presents to the user a underlying error message informing him of the invalidity of the email inserted by the user
        else {
          TextRegisterEmail.validEmail = false;
          return 'Introduza email válido';
        }
      },
    );
  }
}

///class that implements functionality of password inserting in RegisterPage
class TextRegisterPassword extends StatefulWidget {
  TextRegisterPassword({Key? key}) : super(key: key);

  ///control variable [valuePassword] that will hold the value of the textfield controller
  static late TextEditingController valuePassword;

  ///boolean variable [validPassword] that will be used to validate the password inserted by the user in textfield
  static bool validPassword = false;

  ///operation to create the state of the widget
  @override
  State<TextRegisterPassword> createState() => _TextRegisterPassword();
}

///class that holds the state of the widget of password textfield in RegisterPage
class _TextRegisterPassword extends State<TextRegisterPassword> {
  ///[controlPassword] to be used as the controller of this textfield
  late final controlPassword;

  ///function to initiate the state of the widget
  @override
  void initState() {
    ///[controlPassword] is specified as the controller of this textfield
    controlPassword = TextEditingController();

    ///[TextRegisterPassword.valuePassword] holds the value of the variable [controlPassword]
    TextRegisterPassword.valuePassword = controlPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///this function is used to validade password inserted by user using a regex
    ///it's parameter is:
    ///[val] variable that holds the password for regex to be applied on
    ///this regex matches [val] when this variable has at least 8 characters in which 2 of those characters need to be 1 number and 1 letter at least
    bool validatePassword(String val) {
      ///if [val] matches the regex then the password inserted by the user is valid and the function returns true
      if (RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$").hasMatch(val)) {
        return true;
      }

      ///if [val] doesn't match the regex then the password is not valid and the function returns false
      return false;
    }

    return TextFormField(
        autovalidateMode: AutovalidateMode.always,
        controller: controlPassword,

        ///when user performs a change in textfield [TextRegisterPassword.valuePassword] will be updated with [controlPassword] value
        onChanged: (value) {
          TextRegisterPassword.valuePassword = controlPassword;
        },
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.black)),
          filled: true,
          fillColor: Color.fromARGB(255, 255, 255, 255),
          hintText: 'Password',
          errorStyle: TextStyle(fontWeight: FontWeight.bold),
        ),

        ///validator of the textfield which groups the validatePassword function to validate password inserted by user
        ///this validator presents a user a underlying error message at the beginning informing him the content of the password is not valid
        ///this message disappears when user inserts a valid password value
        validator: (value) {
          bool validate = validatePassword(value!);

          ///if the password is not empty and [validate] is true then [TextRegisterPassword.valuePassword] is set to true
          ///then validator does not return any underlying error message
          if (value != '' && validate) {
            TextRegisterPassword.validPassword = true;
            return null;
          }

          ///if the above condition does not verify then the [TextRegisterPassword.valuePassword] is set to false
          ///then the validator presents to the user a underlying error message informing him of the invalidity of the password inserted by the user
          else {
            TextRegisterPassword.validPassword = false;
            return 'Mínimo de 8 caracteres e '
                '\n'
                'pelo menos 1 letra e 1 número.';
          }
        },

        ///max length of password is 80 characters
        inputFormatters: [LengthLimitingTextInputFormatter(80)]);
  }
}

///this function returns a list with all roles of user's in Strapi
///this function has only 2 different roles defined: Public and Authenticated
///this function takes the following parameters:
///[context] to be used in dialogs
///[url] route necessary to acquire user's roles in Strapi through a api call via GET Request
Future<List<int?>> getIDRole(BuildContext context, String url) async {
  ///[roleIDPublic] will hold the integer that represents the role 'Public'
  int? roleIDPublic;

  ///[roleIDAuthenticated] will hold the integer that represents the role 'Authenticated'
  int? roleIDAuthenticated;
  try {
    ///[response] contains the content of the GET Request done with [url]
    ///this GET Request is on a timeout of 10 seconds, when this 10 seconds are reached a error dialog will be shown to the user informing him the server is offline
    var response =
        await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));

    ///if [response.statusCode] has the value 200 then a set of operations will be performed
    if (response.statusCode == 200) {
      ///[jsonMap] holds the body of the response via GET Request in a JSON decoded format
      Map<String, dynamic> jsonMap = jsonDecode(response.body);

      ///[roles] holds all the roles that Strapi has of it's user's
      ///in this case class Role is used to rearrange certain elements to be easier to manipulate
      var roles =
          (jsonMap['roles'] as List).map((element) => Role.fromJson(element));

      ///for cycle to allocate values in variables [roleIDPublic] and [roleIDAuthenticated]
      for (var element in roles) {
        if (element.type == "public") {
          ///[roleIDPublic] has the value of role 'Public' ID in Strapi
          roleIDPublic = element.id;
        }

        ///[roleIDAuthenticated] has the value of role 'Authenticated' ID in Strapi
        else {
          roleIDAuthenticated = element.id;
        }
      }
      return [roleIDPublic, roleIDAuthenticated];
    }
  } on TimeoutException {
    DialogsUser().dialog(context, 'Erro de Conexão!', 'Servidor Offline!', 0);
  }
  throw Exception("ERROR GETTING DATA!");
}

///this function is used to register a user account in Strapi
///this function takes the following parameters:
///[context] that contains the context of the widget to be used in dialogs
///[urlRegister] route necessary to call a Strapi api to authenticate a certain user via POST Request
///[urlGet] route necessary to acquire user's roles in Strapi through a api call via GET Request
void register(BuildContext context, String urlRegister, String urlGet) async {
  ///the following list will have all roles of Strapi user's that are provided by function getIDRole
  ///list has the following structure: [Public role ID, Authenticated role ID]
  RegisterPage.rolesList = await getIDRole(context, urlGet);

  ///this if condition verifies if the values inserted by the user in textfields of RegisterPage are correct
  ///if they are correct a certain group of operations will follow
  if (TextRegisterEmail.validEmail == true &&
      TextRegisterUsername.valueUsername.text != '' &&
      TextRegisterPassword.valuePassword.text != '' &&
      TextRegisterPassword.validPassword == true) {
    ///parsing the [urlRegister] in a Uri format to be used in POST Request
    final uri = Uri.parse(urlRegister);

    ///[headers] holds the headers needed for the POST Request
    final headers = {'Content-Type': 'application/json'};

    ///[body] holds the data necessary for the POST Request
    Map<String, dynamic> body = {
      'username': TextRegisterUsername.valueUsername.text,
      'email': TextRegisterEmail.valueEmail.text,
      'password': TextRegisterPassword.valuePassword.text,
      //by convention a user registered has the Authenticated role
      'role': RegisterPage.rolesList[1],
    };

    ///[jsonBody] holds the [data] in a JSON format to be used in POST Request
    String jsonBody = json.encode(body);

    ///[encoding] holds the type of encoding necessary for POST Request
    final encoding = Encoding.getByName('utf-8');

    ///the POST Request will be executed with a timeout of 10 seconds
    ///if the timeout reaches 10 seconds a dialog will be shown to the user informing him the server is offline
    try {
      ///[res] holds the content of the POST Request response
      final res = await http
          .post(uri, headers: headers, body: jsonBody, encoding: encoding)
          .timeout(const Duration(seconds: 10));
      Navigator.pop(context);

      ///if the [res] has the value 200 then the account of the user was created successfuly
      if (res.statusCode == 200) {
        ///a dialog will be shown to the user informing of his success in registering an account
        DialogsUser().dialog(context, "Registo bem sucedido!",
            "Conta criada com sucesso! Redirecionando para o menu...", 1);
        await Future.delayed(const Duration(seconds: 2));
        Navigator.of(context).pop();
        Navigator.pop(context);

        ///redirecting user to main page menu after successful register attempt
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(
                    user_name: TextRegisterUsername.valueUsername.text)));
      }

      ///if the [res] hasn't the value 200 then the account of the user was not registered
      ///this means a user is already registered with that username or email
      ///a dialog will be shown to the user informing of his unsuccessfullness
      else {
        DialogsUser().dialog(context, "Utilizador já existente!",
            "Já existe um utilizador com esse username/email", 1);
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pop(context);
      }
    } on TimeoutException {
      DialogsUser().dialog(context, 'Erro de Conexão!', 'Servidor Offline!', 0);
    }
  }

  ///dialog will be shown to user when timeout reached 10 seconds
  ///which means server is currently offline
  else {
    Navigator.pop(context);
    DialogsUser().dialog(context, "Erro na introdução de dados!",
        "Campos sem valor ou valores inválidos!", 1);

    await Future.delayed(const Duration(seconds: 2));
    Navigator.pop(context);
  }
}
