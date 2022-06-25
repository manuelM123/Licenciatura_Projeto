// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'buttons.dart';

///User's page to reset his password, in this page he needs to input 2 passwords: 1 new and 1 to confirm the new password
class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({Key? key}) : super(key: key);

  ///the variable [sizesMP] holds the height of device that runs the application
  static late double sizesMP;

  ///the variable [sizes1MP] holds the width of device that runs the application
  static late double sizes1MP;

  @override
  Widget build(BuildContext context) {
    ///[sizesMP] holds the height of the device
    sizesMP = MediaQuery.of(context).size.height;

    ///[sizes1MP] holds the width of the device
    sizes1MP = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 164, 211),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ///textfield for user to input his new password
          Positioned(
            top: sizesMP - (sizesMP / 1.4),
            width: sizes1MP - 40.0,
            child: TextInputsnewPassword(),
          ),

          ///textfield for user to input his new password again for confirmation
          Positioned(
            top: sizesMP - (sizesMP / 1.9),
            width: sizes1MP - 40.0,
            child: TextInputsconfirmationPassword(),
          ),

          ///button that implements the reset password functionality
          Positioned(
            top: sizesMP - (sizesMP / 3.5),
            width: sizes1MP - 200.0,
            child: Buttons(name: 'Submeter nova password'),
          ),

          ///button to cancel reset password request
          Positioned(
            top: sizesMP - (sizesMP / 4.8),
            width: sizes1MP - 200.0,
            child: Buttons(name: 'Cancelar reset password'),
          )
        ],
      ),
    );
  }
}

///class that implements functionality for user to input his new password in ResetPasswordPage
class TextInputsnewPassword extends StatefulWidget {
  const TextInputsnewPassword({Key? key}) : super(key: key);

  ///control variable [value5] that will hold the value of the textfield controller
  static late TextEditingController value5;

  ///boolean variable [validPassword] to validate password input
  static bool validPassword = false;

  ///operation to create the state of the widget
  @override
  State<TextInputsnewPassword> createState() => _TextInputsnewPassword();
}

///class that holds the state of the widget of new password textfield in ResetPasswordPage
class _TextInputsnewPassword extends State<TextInputsnewPassword> {
  ///[control5] to be used as the controller of this textfield
  late final control5;

  ///function to initiate the state of the widget
  @override
  void initState() {
    ///[control5] is specified as the controller of this textfield
    control5 = TextEditingController();

    ///[TextInputsnewPassword.validPassword] is set to false in first execution
    TextInputsnewPassword.validPassword = false;

    ///[TextInputsnewPassword.value5] holds the value of the variable [control5]
    TextInputsnewPassword.value5 = control5;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///this function is used to validade password inserted by user using a regex
    ///it's parameter is:
    ///[val] variable that holds the email for regex to be applied on
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

        ///when user performs a change in textfield [TextInputsnewPassword.value5] will be updated with [control5] value
        onChanged: (value) {
          TextInputsnewPassword.value5 = control5;
        },
        controller: control5,
        obscureText: true,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Color.fromARGB(255, 255, 255, 255),
          hintText: 'Inserir nova password',
        ),

        ///validator of the textfield which groups the validatePassword function to validate password inserted by user
        ///this validator presents a user a underlying error message at the beginning informing him the content of the password is not valid
        ///this message disappears when user inserts a valid password value
        validator: (value) {
          bool validate = validatePassword(value!);

          ///if password is not empty and validatePassword validates the password inserted then:
          ///[TextInputsnewPassword.validPassword] is set to true which means the password is valid
          if (value != '' && validate) {
            TextInputsnewPassword.validPassword = true;
            return null;
          }

          ///if the above condition is not met then the password is not valid and [TextInputsnewPassword.validPassword] is set to false
          else {
            TextInputsnewPassword.validPassword = false;
            return 'Mínimo de 8 caracteres e '
                '\n'
                'pelo menos 1 letra e 1 número.';
          }
        },

        ///max length of password is 80 characters
        inputFormatters: [LengthLimitingTextInputFormatter(80)]);
  }
}

///class that implements functionality of user to input the new password again for confirmation
class TextInputsconfirmationPassword extends StatefulWidget {
  const TextInputsconfirmationPassword({Key? key}) : super(key: key);

  ///control variable [value6] that will hold the value of the textfield controller
  static late TextEditingController value6;

  ///boolean variable [validPassword] to validate password input
  static bool validPassword = false;

  ///operation to create the state of the widget
  @override
  State<TextInputsconfirmationPassword> createState() =>
      _TextInputsconfirmationPassword();
}

///class that holds the state of the widget of confirmation password textfield in ResetPasswordPage
class _TextInputsconfirmationPassword
    extends State<TextInputsconfirmationPassword> {
  ///[control6] to be used as the controller of this textfield
  late final control6;

  ///function to initiate the state of the widget
  @override
  void initState() {
    ///[control6] is specified as the controller of this textfield
    control6 = TextEditingController();

    ///[TextInputsconfirmationPassword.validPassword] is set to false in first execution
    TextInputsconfirmationPassword.validPassword = false;

    ///[TextInputsconfirmationPassword.value6] holds the value of the variable [control6]
    TextInputsconfirmationPassword.value6 = control6;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///this function is used to validade password inserted by user using a regex
    ///it's parameter is:
    ///[val] variable that holds the email for regex to be applied on
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
      controller: control6,

      ///when user performs a change in textfield [TextInputsconfirmationPassword.value6] will be updated with [control6] value
      onChanged: (value) {
        TextInputsconfirmationPassword.value6 = control6;
      },
      obscureText: true,
      textAlignVertical: TextAlignVertical.bottom,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Color.fromARGB(255, 255, 255, 255),
        hintText: 'Confirmar nova password',
      ),

      ///validator of the textfield which groups the validatePassword function to validate password inserted by user
      ///this validator presents a user a underlying error message at the beginning informing him the content of the password is not valid
      ///this message disappears when user inserts a valid password value
      validator: (value) {
        bool validate = validatePassword(value!);

        ///if password is not empty and validatePassword validates the password inserted then:
        ///[TextInputsconfirmationPassword.validPassword] is set to true which means the password is valid
        if (value != '' && validate) {
          TextInputsconfirmationPassword.validPassword = true;
          return null;
        }

        ///if the above condition is not met then the password is not valid and [TextInputsconfirmationPassword.validPassword] is set to false
        else {
          TextInputsconfirmationPassword.validPassword = false;
          return 'Mínimo de 8 caracteres e '
              '\n'
              'pelo menos 1 letra e 1 número.';
        }
      },

      ///max length of password is 80 characters
      inputFormatters: [LengthLimitingTextInputFormatter(80)],
    );
  }
}
