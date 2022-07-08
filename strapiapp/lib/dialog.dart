// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:flutter/material.dart';
import 'forgot_password_page.dart';
import 'main.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'register_page.dart';

class DialogsUser {
  DialogsUser();

  ///this class takes the following parameters:
  ///[context] that will be used for further dialogs, this value groups the context of the widget
  ///[title] holds the title of the dialog
  ///[message] holds the message of the dialog
  ///[status] specifies the type of dialog to be shown
  dialog(BuildContext context, String title, String message, int status) {
    ///create a basic structure of button
    Widget okB = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        });

    ///create a basic structure of button
    ///if user chooses to confirm his account registration the function register will be called
    Widget yesB = TextButton(
        child: Text("Sim"),
        onPressed: () {
          //Navigator.of(context).pop();

          ///autenticate a user by sending a post request to auth/local api
          var urlRegister =
              'http://${MyScaffold.url}:1337/api/auth/local/register';

          ///get data of role's id's
          var urlGet =
              'http://${MyScaffold.url}:1337/api/users-permissions/roles';

          register(context, urlRegister, urlGet);
        });

    ///create a basic structure of button
    ///if user chooses to proceed with his registration in Strapi
    Widget yesB2 = TextButton(
        child: Text("Sim"),
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.pop(context);
        });

    ///create a basic structure of button
    ///if user chooses to cancel his registration he is redirected to MainPage
    Widget noB = TextButton(
        child: Text("Não"),
        onPressed: () {
          Navigator.of(context).pop();
        });

    ///create a basic structure of button
    ///if user chooses to continue with resetting his password he is redirected to ForgottenPasswordPage
    Widget yesB3 = TextButton(
        child: Text("Sim"),
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ForgottenPasswordPage()));
        });

    ///create a basic structure of button
    Widget noB1 = TextButton(
        child: Text("Não"),
        onPressed: () {
          Navigator.pop(context);
        });

    ///dialog used to show user some information
    if (status == 0) {
      AlertDialog alert = AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [okB],
      );

      ///shows the specified dialog to the user
      showDialog(
          context: context,
          builder: (context) {
            return alert;
          });
    }

    ///dialog used to show user some information
    else if (status == 1) {
      AlertDialog alert = AlertDialog(
        title: Text(title),
        content: Text(message),
      );

      ///shows the specified dialog to the user
      showDialog(
          context: context,
          builder: (context) {
            return alert;
          });
    }

    ///dialog for confirmation of registration of user account in Strapi
    else if (status == 2) {
      AlertDialog alert = AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [noB, yesB],
      );

      ///shows the specified dialog to the user
      showDialog(
          context: context,
          builder: (context) {
            return alert;
          });
    }

    ///dialog for confirmation of operation to cancel user's register in Strapi
    else if (status == 3) {
      AlertDialog alert = AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [noB, yesB2],
      );

      ///shows the specified dialog to the user
      showDialog(
          context: context,
          builder: (context) {
            return alert;
          });
    }

    ///dialog for reset password button in initial page
    ///creates a dialog with [title], [message] and buttons [noB1] and [yesB3]
    else if (status == 4) {
      AlertDialog alert = AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [noB1, yesB3],
      );

      ///shows the specified dialog to the user
      showDialog(
          context: context,
          builder: (context) {
            return alert;
          });
    }
  }

  ///this function is used to show some dialogs
  ///this function takes the following parameters:
  ///[context] contains the context of the widget to be used for the dialog
  ///[title] contains the title of the dialog
  ///[message] contains the message of the dialog
  dialogMenu(BuildContext context, String title, String message) {
    ///if user chooses to cancel, the dialog and current page will pop
    Widget yesB = TextButton(
        child: Text("Sim"),
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.pop(context);
        });

    ///if user chooses not to cancel, the dialog will pop and the user will stay in the same page
    Widget noB = TextButton(
        child: Text("Não"),
        onPressed: () {
          Navigator.of(context).pop();
        });

    ///structure of the dialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [noB, yesB],
    );

    ///function to show the dialog
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  ///this function is used to show a dialog to user in MainPage to confirm if he wants to upload the image or not
  ///this function has the following parameters:
  ///[title] the title of the dialog
  ///[message] the message of the dialog
  ///[data] data needed for the Post Request
  ///[headers] headers needed for the Post Request
  ///[context] context of the widget to be used by the dialog
  ///[imageGallery] image uploaded by the user in MainPage
  ///[uri] contains url in Uri format
  dialogUpload(String title, String message, Map<String, dynamic> data,
      final headers, BuildContext context, var imageGallery, final uri) {
    ///if user chooses to upload the image, the function uploadImage will be called
    Widget yesUpload = TextButton(
        child: Text("Sim"),
        onPressed: () {
          uploadImage(data, headers, context, imageGallery, uri);
          Navigator.pop(context);
        });

    ///if the user chooses not to upload the image, the dialog will pop and the user stays in the MainPage
    Widget noUpload = TextButton(
        child: Text("Não"),
        onPressed: () {
          Navigator.pop(context);
        });

    ///structure of the dialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [noUpload, yesUpload],
    );

    ///function to show the dialog
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  ///this function is used to show dialogs in AboutUsPage
  ///this function has the following parameters:
  ///[title] holds the title of the dialog
  ///[message] holds the message of the dialog
  ///[data] holds the data introduced by user in textfields in AboutUsPage
  ///[headers] contains the headers necessary for the following PUT Request
  ///[context] contains the context of the widget that is going to be used in the dialog
  ///[imageGallery] contains the image uploaded by the user in AboutUsPage
  ///[uri] contains the route for the PUT Request in Uri format
  dialogUploadText(String title, String message, Map<String, dynamic> data,
      final headers, BuildContext context, var imageGallery, final uri) {
    ///if user chooses to upload the changes the function uploadAboutUs will be called
    Widget yesUpload = TextButton(
        child: Text("Sim"),
        onPressed: () {
          uploadAboutUs(data, headers, context, imageGallery, uri);
          Navigator.pop(context);
        });

    ///if user chooses not to upload the changes the function the dialog will pop and changes will not be submitted to Strapi
    Widget noUpload = TextButton(
        child: Text("Não"),
        onPressed: () {
          Navigator.pop(context);
        });

    //structure of the dialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [noUpload, yesUpload],
    );

    ///function to show dialog to user
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  ///this function takes the following parameters:
  ///[data] data needed for the POST Request
  ///[headers] headers needed for the POST Request
  ///[context] context of the widget to be used by the dialog
  ///[imageGallery] image uploaded by the user in MainPage
  ///[uri] url in Uri format
  Future<void> uploadImage(Map<String, dynamic> data, final headers,
      BuildContext context, var imageGallery, final uri) async {
    ///in this section a POST Request will be made
    ///this POST Request has as headers the value in [headers]
    ///has as fields in 'data' the value in [data] in a JSON encoded format
    ///also the image uploaded by the user needs to be in a form data request
    ///this form data request needs in it's files attribute the value "files.gallery" because the attribute that determines the image in Strapi for the "Menu" page is "gallery"
    try {
      final res = http.MultipartRequest('POST', uri)
        ..headers.addAll(headers)
        ..fields['data'] = jsonEncode(data);

      res.files.add(await http.MultipartFile.fromPath(
          'files.gallery', imageGallery.path,
          contentType: MediaType.parse('image/jpeg')));

      ///if the [response.statusCode] has the value 200 then the request was successful and a dialog message will present a successful message to the user
      ///if the [response.statusCode] hasn't the value 200 then the request was not successful and a dialog message will presente a error message to the user
      res.send().timeout(const Duration(seconds: 10), onTimeout: () {
        DialogsUser()
            .dialog(context, 'Erro de Conexão!', 'Servidor Offline!', 0);
        throw TimeoutException;
      }).then((response) async {
        if (response.statusCode == 200) {
          DialogsUser().dialog(context, "Imagem adicionada!",
              "Adicionou com sucesso a imagem na página do menu!", 1);
          await Future.delayed(const Duration(seconds: 2));
          Navigator.pop(context);
        } else {
          DialogsUser().dialog(context, "Imagem não adicionada!",
              "Ocorreu um erro a adicionar a imagem! Tente novamente!", 1);
        }
      });
    } on TimeoutException {
      DialogsUser().dialog(context, 'Erro de Conexão!', 'Servidor Offline!', 0);
    }
  }

  ///this function takes the following parameters:
  ///[data] contains the data introduced by the user in textfields in AboutUsPage
  ///[headers] contains the headers necessary for the PUT Request
  ///[context] contains the context of the widget to be used in a dialog
  ///[imageGallery] contains the uploaded image
  ///[uri] contains the route necessary for the PUT Request in a Uri format
  Future<void> uploadAboutUs(Map<String, dynamic> data, final headers,
      BuildContext context, var imageGallery, final uri) async {
    ///in a first moment it's necessary to eliminate a image that already exists in the page "Sobre Nós"
    Map<String, dynamic> delete = {"aboutImage": null};

    ///a PUT Request is made with [delete] value in PUT Request 'data'
    ///this permits the PUT Request to eliminate the already existing image and emptying the media associated with that page
    try {
      final deleteImage = http.MultipartRequest('PUT', uri)
        ..fields['data'] = jsonEncode(delete);

      deleteImage.send().timeout(const Duration(seconds: 10), onTimeout: () {
        DialogsUser()
            .dialog(context, 'Erro de Conexão!', 'Servidor Offline!', 0);
        throw TimeoutException;
      });

      ///after the media element has been sucessfully deleted a second PUT Request is needed in order to apply the changes that
      ///the user made in textfields of AboutUsPage
      ///the PUT Request fields will contain the [data] value encoded in a JSON format and it's headers will have the value of [headers]
      final res = http.MultipartRequest('PUT', uri)
        ..headers.addAll(headers)
        ..fields['data'] = jsonEncode(data);

      ///after this the image uploaded by the user will be allocated as well in the PUT Request files
      ///in this case the attribute that defines the media in Strapi for this page is "aboutImage" and because of this the
      ///value 'files.aboutImage' needs to be added in this form data request
      ///for uploading images into Strapi the image needs to be in form data request along with the data defined above
      res.files.add(await http.MultipartFile.fromPath(
          'files.aboutImage', imageGallery.path,
          contentType: MediaType.parse('image/jpeg')));

      ///the request is sent
      ///if the [response.statusCode] has the value 200 then the request was succesfull and then the changes are applied and the user informed of this success
      ///if the [response.statusCode] hasn't the value 200 then the request was not sucessfull and the user is informed of this error
      res.send().then((response) async {
        if (response.statusCode == 200) {
          DialogsUser().dialog(context, "Alterações efetuadas!",
              "Alterou com sucesso o conteúdo do website!", 1);
          await Future.delayed(const Duration(seconds: 2));
          Navigator.pop(context);
          Navigator.of(context).pop();
        } else {
          DialogsUser().dialog(context, "Erro a introduzir alterações",
              "Ocorreu um erro! Tente novamente!", 1);
        }
      });
    } on TimeoutException {
      DialogsUser().dialog(context, 'Erro de Conexão!', 'Servidor Offline!', 0);
    }
  }
}
