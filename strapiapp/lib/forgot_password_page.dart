// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'buttons.dart';

///User's page to input email and code received by email to send a change password request to Strapi
//////this constructor takes the parameter [user_name] that holds the value of the user's username
class ForgottenPasswordPage extends StatelessWidget {
  ForgottenPasswordPage({Key? key, this.user_name}) : super(key: key);

  ///the variable [user_name] holds the value of the user's username that was take in as a parameter
  String? user_name;

  ///the variable [sizesMP] holds the height of device that runs the application
  static late double sizesMP;

  ///the variable [sizes1MP] holds the width of device that runs the application
  static late double sizes1MP;

  ///boolean value [emailSent] used to verify if email with code was successfully sent to user's email or not
  static bool emailSent = false;

  ///control variable [emailCode] that will hold code sent in email by Strapi for the change password request
  static String emailCode = "";

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
          ///textfield for user to input his email
          Positioned(
            top: sizesMP - (sizesMP / 1.4),
            width: sizes1MP - 40.0,
            child: TextInputs4(),
          ),

          ///button for user to sent the email that has the necessary code to be inserted in this page
          Positioned(
            top: sizesMP - (sizesMP / 1.65),
            width: sizes1MP - 200.0,
            child: Buttons(name: 'Enviar código para email'),
          ),

          ///textfield for user to input the code for reset password request he received in his email
          Positioned(
            top: sizesMP - (sizesMP / 2.2),
            width: sizes1MP - 40.0,
            child: TextInputs3(),
          ),

          ///button to submit data for the reset password request in Strapi
          Positioned(
            top: sizesMP - (sizesMP / 3),
            width: sizes1MP - 200.0,
            child: Buttons(name: 'Submeter'),
          ),

          ///button to cancel reset password request
          Positioned(
            top: sizesMP - (sizesMP / 4),
            width: sizes1MP - 200.0,
            child: Buttons(name: 'Cancelar reset password'),
          ),
        ],
      ),
    );
  }
}

///class that implements functionality of inserting code of password reset request in textfield of ForgottenPasswordPage
class TextInputs3 extends StatefulWidget {
  const TextInputs3({Key? key}) : super(key: key);

  ///control variable [value3] that will hold the value of the textfield controller
  static late TextEditingController value3;

  ///operation to create the state of the widget
  @override
  State<TextInputs3> createState() => _TextInputsState3();
}

///class that holds the state of the widget of code of password reset request in textfield
class _TextInputsState3 extends State<TextInputs3> {
  ///[control3] to be used as the controller of this textfield
  late final control3;

  ///function to initiate the state of the widget
  ///[control3] is specified as the controller for this textfield
  ///[TextInputs3.value3] holds the value of variable [control3]
  @override
  void initState() {
    control3 = TextEditingController();
    TextInputs3.value3 = control3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: control3,

      ///when a user performs a change in the textfield content, [TextInputs3.value3] will be updated with the value of [control3]
      onChanged: (value) {
        TextInputs3.value3 = control3;
      },
      textAlignVertical: TextAlignVertical.bottom,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black)),
        filled: true,
        fillColor: Color.fromARGB(255, 255, 255, 255),
        hintText: 'Inserir código que está no email',
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(500)],
    );
  }
}

///class that implements functionality to take email of the user by input in ForgottenPasswordPage
class TextInputs4 extends StatefulWidget {
  const TextInputs4({Key? key}) : super(key: key);

  ///control variable [value4] that will hold the value of the textfield controller
  static late TextEditingController value4;

  ///operation to create the state of the widget
  @override
  State<TextInputs4> createState() => _TextInputsState4();
}

///class that holds the state of the widget of email textfield in ForgottenPasswordPage
class _TextInputsState4 extends State<TextInputs4> {
  ///[control4] to be used as the controller of this textfield
  late final control4;

  ///function to initiate the state of the widget
  @override
  void initState() {
    ///[control4] is specified as the controller of this textfield
    control4 = TextEditingController();

    ///[TextInputs4.value4] holds the value of the variable [control4]
    TextInputs4.value4 = control4;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: control4,

      ///when user performs a change in textfield [TextInputs4.value4] will be updated with [control4] value
      onChanged: (value) {
        TextInputs4.value4 = control4;
      },
      textAlignVertical: TextAlignVertical.bottom,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black)),
        filled: true,
        fillColor: Color.fromARGB(255, 255, 255, 255),
        hintText: 'Inserir email',
      ),
    );
  }
}
