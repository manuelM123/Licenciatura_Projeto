// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, avoid_print

import 'buttons.dart';
import 'dialog.dart';

import 'package:flutter/material.dart';
import 'package:strapiapp/dialog.dart';
import 'package:image_picker/image_picker.dart';

import 'main.dart';

///User's main page of the application
///this constructor takes the parameter [user_name] that holds the value of the user's username
class MainPage extends StatelessWidget {
  MainPage({Key? key, this.user_name}) : super(key: key);

  ///the variable [user_name] holds the value of the user's username that was take in as a parameter
  String? user_name;

  ///the variable [sizesMP] holds the height of device that runs the application
  static late double sizesMP;

  ///the variable [sizes1MP] holds the width of device that runs the application
  static late double sizes1MP;

  ///variable [userName] used to pass the userName value in another operations
  static late String? userName;

  @override
  Widget build(BuildContext context) {
    ///[sizesMP] holds the height of the device
    sizesMP = MediaQuery.of(context).size.height;

    ///[sizes1MP] holds the width of the device
    sizes1MP = MediaQuery.of(context).size.width;

    ///[userName] holds the value of [user_name]
    userName = user_name;
    return Scaffold(
      ///app bar in main page with a welcoming message with user's username obtained by the variable [user_name]
      appBar: AppBar(
          title: Text('Bem Vindo  $user_name'),
          automaticallyImplyLeading: false),
      backgroundColor: Color.fromARGB(255, 214, 214, 214),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ///text element to inform user of the type of operation the button performs
          Positioned(
            top: sizesMP - (sizesMP / 1.2),
            child: Text(
              "Editar conteúdo na página \"Sobre Nós\"",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          ///button that redirect's user to another page to implement the respective functionality
          Positioned(
            top: sizesMP - (sizesMP / 1.2) + 30.0,
            child: Buttons(name: "Editar conteúdo na página \"Sobre Nós\""),
          ),

          ///text element to inform user of the type of operation the button performs
          Positioned(
            top: sizesMP - (sizesMP / 1.7),
            child: Text(
              "Adicionar imagens no menu",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          ///button that implements the upload image operation
          Positioned(
            top: sizesMP - (sizesMP / 1.8),
            child: Buttons(name: "Adicionar imagem na galeria de fotos"),
          ),

          ///button that permits user to logout
          Positioned(
            top: sizesMP - (sizesMP / 2.6) + 80.0,
            child: LogoutButton(),
          ),
        ],
      ),
    );
  }
}

///class that implements functionality of user's logout operation
class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(children: [
        ///create a basic structure of button
        TextButton(

            ///when the button is pressed a dialog will be presented to user to decide if he wants to logout or not
            onPressed: () {
              DialogsUser().dialogMenu(context, "Logout Conta",
                  "Deseja efetuar logout da sua conta?");
            },
            child: Text(
              "Logout",
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              textAlign: TextAlign.center,
            )),
      ]),
    );
  }
}

///this function is used to obtain the uploaded image of the user and organize some data for the POST Request in another function
///this function has the following parameters:
///[context] contains the context of the widget to be used by the dialog
void getImageGallery(BuildContext context) async {
  ///[imageGallery] holds the image uploaded by user in MainPage
  var imageGallery = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );

  ///if the [imageGallery] is not null then certain operations will be executed to implement the upload of the image to Strapi
  if (imageGallery != null) {
    ///[urlpostImage] to upload images into MainPage
    var urlpostImage = 'http://${MyScaffold.url}:1337/api/photo-gallery-menus';

    ///[uri] contains the value of [urlpostImage] in Uri format
    final uri = Uri.parse(urlpostImage);

    ///[data] has an example data needed for the POST Request
    Map<String, dynamic> data = {'name': "test", 'tag': 1};

    ///[headers] contains headers needed for the POST Request
    final headers = {
      'Authorization': 'Bearer ${Buttons.jwtToken}',
      'Content-Type': 'multipart/form-data'
    };

    ///function that verifies if user wants to upload image or not and implements respective functionality
    DialogsUser().dialogUpload(
        "Submissão de imagem",
        "Deseja efetuar upload da imagem escolhida para a página menu?",
        data,
        headers,
        context,
        imageGallery,
        uri);
  } else {
    DialogsUser().dialog(context, "Falha a obter imagem!",
        "Imagem não foi obtida! Tente novamente!", 1);
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pop(context);
  }
}
