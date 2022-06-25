// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, avoid_print

import 'dart:async';
import 'dart:convert';

import 'dialog.dart';
import 'forgot_password_page.dart';
import 'main.dart';
import 'main_page.dart';
import 'about_us_page.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:strapiapp/dialog.dart';

import 'register_page.dart';
import 'reset_password_page.dart';

///class Buttons that holds different purposes according different functionalities of different buttons in application
class Buttons extends StatelessWidget {
  ///constructor for class Buttons that holds a required parameter [name]
  ///variable [name] will hold a String value that specifies which functionality a certain button should implement
  Buttons({Key? key, required this.name}) : super(key: key);
  final String name;

  ///variable [jwtToken] that holds the value of JWT Token generated after a sucessfull authentication by a user
  static var jwtToken = "";

  ///variable [aboutUsTitle] will hold the value of the textfield related to the title of the page "Sobre Nós" in AboutUsPage
  static var aboutUsTitle;

  ///variable [aboutUsFirst] will hold the value of the textfield related to the first paragraph of the page "Sobre Nós" in AboutUsPage
  static var aboutUsFirst;

  ///variable [aboutUsSecond] will hold the value of the textfield related to the second paragraph of the page "Sobre Nós" in AboutUsPage
  static var aboutUsSecond;

  ///variable [image] will hold the image uploaded by the user in AboutUsPage
  static XFile? image;

  ///widget build for different buttons according to respectives functionalities, these functionalities are determined according the value of paramater [name]
  @override
  Widget build(BuildContext context) {
    ///if the value of [name] holds the value 'Login' then the login functionality will be implemented
    if (name == 'Login') {
      return Container(
        height: 52.0,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 214, 214, 214),
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(children: [
          ///this class will implement the basic structure of a button
          TextButton(
              onPressed: () {
                ///the function fetchUsers takes the variable [context] as parameter to be used for further dialogs, this value groups the context of the widget
                fetchUsers(context);
              },
              child: Text(
                name,
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                textAlign: TextAlign.center,
              )),
        ]),
      );
    }

    ///if the value of [name] holds the value 'Registar' then the user will be redirected to RegisterPage for the functionality to be implemented
    else if (name == 'Registar') {
      return Container(
        height: 52.0,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 214, 214, 214),
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(children: [
          ///this class will implement the basic structure of a button
          TextButton(
              onPressed: () async {
                ///example to test if server is online
                var urlGet =
                    'http://${MyScaffold.url}:1337/api/users-permissions/roles';

                ///the function verifyServerStatus is used to verify if the server is online
                bool? val = await verifyServerStatus(context, urlGet);

                ///if the [val] is true then user is redirected to RegisterPage
                if (val == true) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                }
              },
              child: Text(
                name,
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                textAlign: TextAlign.center,
              )),
        ]),
      );
    }

    ///if the value of [name] holds the value 'Cancelar' then the user chose to cancel his account's register
    else if (name == 'Cancelar') {
      return Container(
        height: 52.0,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 214, 214, 214),
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(children: [
          ///class that implements basic structure of a button
          TextButton(
              onPressed: () {
                ///redirecting user to register page after user pressed register button
                DialogsUser().dialog(context, "Cancelar operação de registo",
                    "Deseja cancelar operação de registo?", 3);
              },
              child: Text(
                name,
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                textAlign: TextAlign.center,
              )),
        ]),
      );
    }

    ///if the value of [name] holds the value 'Reset Password' then the user will be redirected to ForgottenPasswordPage
    else if (name == "Reset Password") {
      return Container(
        height: 52.0,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 214, 214, 214),
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(children: [
          ///this class will implement the basic structure of a button
          TextButton(
              onPressed: () async {
                ///example to test if server is online
                var urlGet =
                    'http://${MyScaffold.url}:1337/api/users-permissions/roles';

                ///the function verifyServerStatus is used to verify if the server is online
                bool? val2 = await verifyServerStatus(context, urlGet)
                    .timeout(const Duration(seconds: 10));

                ///if the variable [val2] is true then user will be shown a dialog to ask him if he wants to proceed with resetting the password
                if (val2 == true) {
                  DialogsUser().dialog(context, "Esquecimento da password",
                      "Deseja repor uma nova password da sua conta?", 4);
                }
              },
              child: Text(
                name,
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                textAlign: TextAlign.center,
              )),
        ]),
      );
    }

    ///if the value of [name] holds the value 'Submeter' then the user will be redirected to ResetPasswordPage to reset his password
    else if (name == "Submeter") {
      return Container(
        height: 52.0,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 214, 214, 214),
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(children: [
          ///class that implements the basic structure of a button
          TextButton(
              onPressed: () async {
                ///if [ForgottenPasswordPage.emailSent] and [ForgottenPasswordPage.emailCode] have the correct values then it means that:
                ///1- the email was successfully sent to the user with the respective code
                ///2- the code that the user inserted in the textfield corresponds to the real code sent in the email
                ///when this condition is verified the user will be able to input a new password and a confirmation password to finally reset his account's password
                if (ForgottenPasswordPage.emailSent == true &&
                    ForgottenPasswordPage.emailCode ==
                        TextInputs3.value3.text) {
                  ///user goes to ResetPasswordPage
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResetPasswordPage()));
                }

                ///if [ForgottenPasswordPage.emailSent] is false, then it mean's that the email was not sent because the email was not registered in Strapi's database
                else if (ForgottenPasswordPage.emailSent == false) {
                  ///a dialog with the information about the error will be shown to the user
                  DialogsUser().dialog(context, "Email não enviado!",
                      "Submeta o email para receber o código", 0);
                }

                ///if [ForgottenPasswordPage.emailCode] is not the same as the value that user put in the textfield, then it means the code inserted was not valid
                else {
                  ///a dialog with the information about the error will be shown to the user
                  DialogsUser().dialog(
                      context,
                      "Código inválido!",
                      "Insira novamente o código ou faça requisição de um novo código",
                      0);
                }
              },
              child: Text(
                name,
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                textAlign: TextAlign.center,
              )),
        ]),
      );
    }

    ///if the value of [name] holds the value 'Enviar código para email' then a email with the code will be sent to user for him to write it in another textfield in ForgottenPasswordPage
    else if (name == "Enviar código para email") {
      return Container(
        height: 52.0,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 214, 214, 214),
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(children: [
          ///this class will implement the basic structure of a button
          TextButton(
              onPressed: () async {
                ///[urlforgotPassword] holds the route that corresponds to the forgot password request in Strapi for the POST Request
                var urlforgotPassword =
                    'http://${MyScaffold.url}:1337/api/auth/forgot-password';

                ///[uri] holds the value of variable [urlforgotPassword] in a Uri format for the POST Request
                final uri = Uri.parse(urlforgotPassword);

                ///[headers] holds the headers necessary for the POST Request
                final headers = {'Content-Type': 'application/json'};

                ///[body] holds the data necessary for the POST Request
                Map<String, dynamic> body = {
                  'email': TextInputs4.value4.text,
                };

                ///[jsonBody] holds the value of [body] in a JSON encoded format for the POST Request
                String jsonBody = json.encode(body);

                ///[encoding] holds the type of enconding necessary for the POST Request
                final encoding = Encoding.getByName('utf-8');

                try {
                  ///[res] holds the content of the POST Request response
                  ///this POST Request is set on a timeout of 10 seconds
                  ///if this timeout reaches the 10 seconds then it will be shown to user a error message informing him the server is offline
                  final res = await http
                      .post(uri,
                          headers: headers, body: jsonBody, encoding: encoding)
                      .timeout(const Duration(seconds: 10));

                  ///if [res.statusCode] has the value 200 then a series of operations will follow
                  if (res.statusCode == 200) {
                    ///[ForgottenPasswordPage.emailSent] is set to true for another operations
                    ForgottenPasswordPage.emailSent = true;

                    ///[forgotData] holds the [res.body] in a JSON decoded format
                    Map<String, dynamic> forgotData = jsonDecode(res.body);

                    ///[emailCode] holds the code value in [forgotData]["code"]
                    ForgottenPasswordPage.emailCode = forgotData["code"];

                    ///dialog will be shown to user to inform him of his successful attempt in sending the email with the code for the reset password request
                    DialogsUser().dialog(
                        context,
                        "Email Enviado!",
                        "Verifique o seu email para inserir o código para alteração de password",
                        1);
                    await Future.delayed(const Duration(seconds: 2));
                    Navigator.pop(context);
                  }

                  ///if [res.statusCode] hasn't the value 200 then a dialog will be shown to user informing him of his unsuccessfullness
                  else {
                    DialogsUser().dialog(context, "Email não existente!",
                        "Email não existe! Insira um email de conta válido", 1);
                    await Future.delayed(const Duration(seconds: 2));
                    Navigator.pop(context);
                  }
                } on TimeoutException {
                  DialogsUser().dialog(
                      context, 'Erro de Conexão!', 'Servidor Offline!', 0);
                }
              },
              child: Text(
                name,
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                textAlign: TextAlign.center,
              )),
        ]),
      );
    }

    ///if the value of [name] holds the value 'Cancelar reset password' then the user will be sent to application initial page
    else if (name == "Cancelar reset password") {
      return Container(
        height: 52.0,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 214, 214, 214),
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(children: [
          ///class that implements basic structure of a button
          TextButton(
              onPressed: () {
                ///user is redirected to application initial page
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyScaffold()));
              },
              child: Text(
                name,
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                textAlign: TextAlign.center,
              )),
        ]),
      );
    }

    ///if the value of [name] holds the value 'Submeter nova password' then the user's password will be updated with the new value he inserted
    else if (name == "Submeter nova password") {
      return Container(
        height: 52.0,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 214, 214, 214),
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(children: [
          ///class that implements basic structure of a button
          TextButton(
              onPressed: () async {
                ///if the condition below is verified then it means that:
                ///the new password inputed by user is valid
                ///the confirmation password inputed by user is the same as the new password inputted therefore it's correct
                ///if conditions above are correct then the password will be updated
                if (TextInputsnewPassword.validPassword == true &&
                    TextInputsconfirmationPassword.validPassword == true) {
                  ///[urlresetPassword] contains the route needed for the reset password request in Strapi for the POST Request
                  var urlresetPassword =
                      'http://${MyScaffold.url}:1337/api/auth/reset-password';

                  ///[uri] holds the value of [urlresetPassword] in Uri format to be used in POST Request
                  final uri = Uri.parse(urlresetPassword);

                  ///[headers] holds the headers necessary for the POST Request
                  final headers = {'Content-Type': 'application/json'};

                  ///[body] holds the data necessary for the POST Request
                  Map<String, dynamic> body = {
                    'code': TextInputs3.value3.text,
                    'password': TextInputsnewPassword.value5.text,
                    'passwordConfirmation':
                        TextInputsconfirmationPassword.value6.text
                  };

                  ///[jsonBody] holds the value of [body] in a JSON encoded format for the POST Request
                  String jsonBody = json.encode(body);

                  ///[encoding] specifies the type of encoding necessary for the POST Request
                  final encoding = Encoding.getByName('utf-8');

                  try {
                    ///[response] holds the content of POST Request response
                    ///a timeout is defined with a duration of 10 seconds
                    ///when these 10 seconds are reached a dialog will be show to the user to inform him the server is offline
                    var response = await http
                        .post(uri,
                            headers: headers,
                            body: jsonBody,
                            encoding: encoding)
                        .timeout(const Duration(seconds: 10));

                    ///if [response.statusCode] has the value 200 then the update of user's password was sucessfull and he will be informed via dialog
                    if (response.statusCode == 200) {
                      DialogsUser().dialog(
                          context,
                          "Palavra passe alterada!",
                          "Alterou com sucesso a sua palavra passe! A redirecionar para o menu principal...",
                          1);
                      await Future.delayed(const Duration(seconds: 2));
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyScaffold()));
                    }

                    ///if [response.statusCode] hasn't the value 200 then the update of user's password was unsuccessfull and he will be informed via dialog
                    else {
                      DialogsUser().dialog(
                          context,
                          "Palavra passe não é a mesma!",
                          "Introduziu valores diferentes na palavra passe. Volte a introduzir!",
                          1);
                      await Future.delayed(const Duration(seconds: 2));
                      Navigator.pop(context);
                    }
                  }

                  ///dialog for timeout exception
                  on TimeoutException {
                    DialogsUser().dialog(
                        context, 'Erro de Conexão!', 'Servidor Offline!', 0);
                  }
                }

                ///in the first if condition, if this isn't verified then the password inputed by the user was not valid
                ///this means the user did not respect the password structure
                else {
                  DialogsUser().dialog(
                      context,
                      "Palavra passe inválida!",
                      "Introduziu valores inválidos na palavra passe. Volte a introduzir!",
                      1);
                  await Future.delayed(const Duration(seconds: 2));
                  Navigator.pop(context);
                }
              },
              child: Text(
                name,
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                textAlign: TextAlign.center,
              )),
        ]),
      );
    }

    ///if the value of [name] holds the value 'Editar conteúdo na página \"Sobre Nós\"' then the user will be redirected to AboutUsPage for the functionality to be implemented
    else if (name == "Editar conteúdo na página \"Sobre Nós\"") {
      return Container(
          height: MyScaffold.sizes - (MyScaffold.sizes - 80.0),
          padding: EdgeInsets.symmetric(horizontal: 60.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: SizedBox(
            height: MyScaffold.sizes - 30.0,
            width: MyScaffold.sizes1 - 150.0,

            ///implements a basic structure of a button but with a icon
            child: IconButton(
              padding: EdgeInsets.all(0.0),

              ///button is displayed as a image to the user
              icon: Image.asset(
                'images/aboutus.png',
              ),
              onPressed: () async {
                ///[url] holds the specific route to call a Strapi api
                var url = 'http://${MyScaffold.url}:1337/api/about-us';

                try {
                  ///[response] holds the content resulting from the Get Request
                  var response = await http
                      .get(Uri.parse(url))
                      .timeout(const Duration(seconds: 10));

                  ///if the [response.statusCode] has the value 200 then certain data will be reunited to be used in AboutUsPage
                  if (response.statusCode == 200) {
                    ///[jsonMap] holds the data decoded from JSON response that it's present in [response.body]
                    Map<String, dynamic> jsonMap = jsonDecode(response.body);

                    ///[aboutUsTitle] holds the title value from the variable [jsonMap]
                    aboutUsTitle = jsonMap['data']['attributes']['title'];

                    ///[aboutUsFirst] holds the firstParagraph value from the variable [jsonMap]
                    aboutUsFirst =
                        jsonMap['data']['attributes']['firstParagraph'];

                    ///[aboutUsSecond] holds the secondParagraph value from the variable [jsonMap]
                    aboutUsSecond =
                        jsonMap['data']['attributes']['secondParagraph'];

                    ///redirecting user to AboutUsPage to implement the functionality of altering text and image in page "Sobre Nós" of Deliart Caffé
                    ///the class AboutUsPage takes the parameter [MainPage.userName] that holds the user's username to be shown in the app bar
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AboutUsPage(user_name: MainPage.userName)));
                  }

                  ///if the [response.statusCode] hasn't value 200 then a dialog will be shown to user with a error message
                  else {
                    DialogsUser().dialog(context, "Erro a obter dados!",
                        "Tente novamente mais tarde!", 1);
                    await Future.delayed(const Duration(seconds: 2));
                    Navigator.pop(context);
                  }

                  ///exception to be shown to user if the above verifications do not return any values desired
                } on TimeoutException {
                  DialogsUser().dialog(
                      context, 'Erro de Conexão!', 'Servidor Offline!', 0);
                }
              },
            ),
          ));
    }

    ///if the value of [name] holds the value 'Adicionar imagem na galeria de fotos' then functionality of uploading image to page "Menu" will be implemented
    else if (name == "Adicionar imagem na galeria de fotos") {
      return Container(
          height: MyScaffold.sizes - (MyScaffold.sizes - 80.0),
          padding: EdgeInsets.symmetric(horizontal: 60.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: SizedBox(
            height: MyScaffold.sizes - 30.0,
            width: MyScaffold.sizes1 - 150.0,

            ///implements a basic structure of a button but with a icon
            child: IconButton(
              padding: EdgeInsets.all(0.0),
              icon: Image.asset(
                'images/gallery.png',
              ),

              ///when button is pressed function getImageGallery will be called
              onPressed: () {
                getImageGallery(context);
              },
            ),
          ));
    }

    ///if the value of [name] holds the value 'Confirmar alterações' then the user chose to upload the changes he made in AboutUsPage
    else if (name == 'Confirmar alterações') {
      return Container(
        height: 52.0,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(children: [
          ///this class will implement the basic structure of a button
          TextButton(

              ///when the button is pressed various operations are performed
              onPressed: () async {
                ///exists a verification to verify if the path of the image uploaded by the user is null or not
                ///if it is the user will be greeted by a dialog informing him of the error
                if (image?.path == null) {
                  DialogsUser().dialog(
                      context,
                      "Imagem não encontrada!",
                      "Não adicionou a imagem. Por favor insira uma imagem para a página \"Acerca de Nós\"",
                      1);
                  await Future.delayed(const Duration(seconds: 2));
                  Navigator.pop(context);
                }

                ///if the path of the image uploaded by the user is not null there will be applied a lot of operations to treat the data needed to be sent to Strapi
                ///this data will alter specific content on the "Sobre Nós" page of the website
                else {
                  ///[url] holds the url necessary to call the specific Strapi api
                  var url = 'http://${MyScaffold.url}:1337/api/about-us';

                  ///[uri] contains the [url] parsed in Uri to be used in PUT Request
                  final uri = Uri.parse(url);

                  ///[data] contains data introduced by user in textfields of AboutUsPage
                  Map<String, dynamic> data = {
                    "title": TextAboutUsTitle.title.text,
                    "firstParagraph": TextAboutUsFirstParagraph.first.text,
                    "secondParagraph": TextAboutUsSecondParagraph.second.text
                  };

                  ///[headers] contains headers necessary for the PUT Request to function properly
                  final headers = {
                    'Authorization': 'Bearer ${Buttons.jwtToken}',
                    'Content-Type': 'multipart/form-data'
                  };

                  ///function to inform user if he is certain of the changes he is about to make
                  DialogsUser().dialogUploadText(
                      "Confirmação de alterações",
                      "Deseja efetuar as alterações para a página \"Sobre Nós\"?",
                      data,
                      headers,
                      context,
                      image,
                      uri);
                }
              },
              child: Text(
                "Confirmar alterações",
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                textAlign: TextAlign.center,
              )),
        ]),
      );
    }

    ///if the value of [name] holds the value 'Cancelar alterações' then the user chose to cancel the changes he made in AboutUsPage
    else if (name == 'Cancelar alterações') {
      return Container(
        height: 52.0,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(children: [
          ///this class will implement the basic structure of a button
          TextButton(

              ///when this button is pressed, a dialog will be presented to user to confirm if he chooses to cancel his changes or not
              onPressed: () {
                DialogsUser().dialogMenu(context, "Cancelar operação",
                    "Deseja cancelar as alterações?");
              },
              child: Text(
                "Cancelar alterações",
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                textAlign: TextAlign.center,
              )),
        ]),
      );

      ///if the value of [name] holds the value 'Escolher imagem' then the user will have to choose a image from the gallery to upload for the page "Sobre Nós" of the website
    } else if (name == 'Escolher imagem') {
      return Container(
        height: 52.0,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(children: [
          ///this class will implement the basic structure of a button
          TextButton(

              ///when the button is pressed, the user needs to choose a image from the gallery to upload
              ///if the image uploaded has some error, there is a verification that informs the user of that error
              ///[image] will hold the image uploaded by the user
              onPressed: () async {
                image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (image == null) {
                  DialogsUser().dialog(context, "Falha a obter a imagem!",
                      "Imagem não foi obtida! Tente novamente!", 1);

                  await Future.delayed(const Duration(seconds: 2));
                  Navigator.pop(context);
                }
              },
              child: Text(
                "Escolher imagem",
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                textAlign: TextAlign.center,
              )),
        ]),
      );
    }

    ///section to confirm user register operation
    return Container(
      height: 52.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 214, 214, 214),
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(children: [
        ///implements the basic structure of a button
        TextButton(

            ///when the button is pressed a dialog will be shown to user for him to confirm if he wants to register his account or not
            onPressed: () {
              DialogsUser().dialog(context, "Confirmar registo de conta",
                  "Deseja confirmar o registo da sua conta?", 2);
            },
            child: Text(
              name,
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              textAlign: TextAlign.center,
            )),
      ]),
    );
  }
}
