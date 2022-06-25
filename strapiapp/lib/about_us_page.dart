// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'buttons.dart';

///User's page that provides altering text and image of page "Sobre Nós" functionality in the website
///this constructor takes the parameter [user_name] that holds the value of the user's username
class AboutUsPage extends StatelessWidget {
  AboutUsPage({Key? key, this.user_name}) : super(key: key);

  ///the variable [user_name] holds the value of the user's username that was take in as a parameter
  String? user_name;

  ///the variable [sizesMP] holds the height of device that runs the application
  static late double sizesMP;

  ///the variable [sizes1MP] holds the width of device that runs the application
  static late double sizes1MP;

  @override
  Widget build(BuildContext context) {
    sizesMP = MediaQuery.of(context).size.height;
    sizes1MP = MediaQuery.of(context).size.width;
    return Scaffold(
      ///app bar that has the User's username
      appBar:
          AppBar(title: Text('$user_name'), automaticallyImplyLeading: false),
      backgroundColor: Color.fromARGB(255, 214, 214, 214),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ///text element to inform user the type of operation he is about to perform
          Positioned(
            top: sizesMP - (sizesMP / 1.05),
            child: Text(
              "Editar título",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          ///textfield widget to alter title of the page "Sobre Nós" of the website
          Positioned(
            top: sizesMP - (sizesMP / 1.10),
            width: sizes1MP - (sizes1MP / 3),
            height: sizesMP - (sizesMP - 30.0),
            child: TextAboutUsTitle(),
          ),

          ///text element to inform user the type of operation he is about to perform
          Positioned(
            top: sizesMP - (sizesMP / 1.2),
            child: Text(
              "Editar primeiro parágrafo",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          ///textfield widget to alter the first paragraph of the page "Sobre Nós" of the website
          Positioned(
            top: sizesMP - (sizesMP / 1.25),
            width: sizes1MP - (sizes1MP / 4),
            child: TextAboutUsFirstParagraph(),
          ),

          ///text element to inform user the type of operation he is about to perform
          Positioned(
            top: sizesMP - (sizesMP / 1.6),
            child: Text(
              "Editar segundo parágrafo",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          ///textfield widget to alter the second paragraph of the page "Sobre Nós" of the website
          Positioned(
            top: sizesMP - (sizesMP / 1.7),
            width: sizes1MP - (sizes1MP / 4),
            child: TextAboutUsSecondParagraph(),
          ),

          ///button for user to choose a image to upload to the page "Sobre Nós" of the website
          Positioned(
            top: sizesMP - ((sizesMP / 2.5)),
            width: sizes1MP - (sizes1MP / 1.5),
            child: Buttons(name: 'Escolher imagem'),
          ),

          ///button for user to upload changes made in the AboutUsPage to the page "Sobre Nós" of the website
          Positioned(
            top: sizesMP - ((sizesMP / 3.5)),
            width: sizes1MP - (sizes1MP / 2),
            child: Buttons(name: 'Confirmar alterações'),
          ),

          ///button for user to cancel changes made in the AboutUsPage to the page "Sobre Nós" of the website
          Positioned(
            top: sizesMP - ((sizesMP / 5)),
            width: sizes1MP - (sizes1MP / 2),
            child: Buttons(name: 'Cancelar alterações'),
          )
        ],
      ),
    );
  }
}

///class that implements functionality of altering title in page "Sobre Nós"
class TextAboutUsTitle extends StatefulWidget {
  const TextAboutUsTitle({Key? key}) : super(key: key);

  ///control variable [title] that will hold the value of the textfield controller
  static late TextEditingController title;

  ///operation to create the state of the widget
  @override
  State<TextAboutUsTitle> createState() => _TextAboutUsTitleState();
}

///class that holds the state of the widget of title textfield
class _TextAboutUsTitleState extends State<TextAboutUsTitle> {
  ///[control] to be used as the controller of this textfield
  late final control;

  ///function to initiate the state of the widget
  ///[control] is specified as the controller for this textfield
  ///[TextAboutUsTitle.title] holds the value of variable [control]
  ///the text element of the textfield is initialized with the value of [Buttons.aboutUsTitle] which contains the title of the page "Sobre Nós" obtained via GET Request from a Strapi api
  @override
  void initState() {
    control = TextEditingController(text: Buttons.aboutUsTitle);
    TextAboutUsTitle.title = control;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: control,

      ///when user performs a change in the textfield content, [TextAboutUsTitle.title] will be updated with [control] value
      onChanged: (value) {
        TextAboutUsTitle.title = control;
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Color.fromARGB(255, 255, 255, 255)),
    );
  }
}

///class that implements functionality of altering first paragraph in page "Sobre Nós"
class TextAboutUsFirstParagraph extends StatefulWidget {
  const TextAboutUsFirstParagraph({Key? key}) : super(key: key);

  ///control variable [first] that will hold the value of the textfield controller
  static late TextEditingController first;

  ///operation to create the state of the widget
  @override
  State<TextAboutUsFirstParagraph> createState() =>
      _TextAboutUsFirstParagraphState();
}

///class that holds the state of the widget of first paragraph textfield
class _TextAboutUsFirstParagraphState extends State<TextAboutUsFirstParagraph> {
  ///[control] to be used as the controller of this textfield
  late final control;

  ///function to initiate the state of the widget
  ///[control] is specified as the controller for this textfield
  ///[TextAboutUsFirstParagraph.first] holds the value of variable [control]
  ///the text element of the textfield is initialized with the value of [Buttons.aboutUsFirst] which contains the first paragraph of the page "Sobre Nós" obtained via GET Request from a Strapi api
  @override
  void initState() {
    control = TextEditingController(text: Buttons.aboutUsFirst);
    TextAboutUsFirstParagraph.first = control;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 120, minHeight: 120),
        child: TextField(
          textAlignVertical: TextAlignVertical.top,

          ///when user's performs a change in the textfield content, [TextAboutUsFirstParagraph.first] will be updated with [control] value
          onChanged: (value) {
            TextAboutUsFirstParagraph.first = control;
          },

          ///[maxLines] attribute authorizes text cursor to be redirected below when max length in a line is reached
          ///basically permits multiple lines with a scroll function in this textfield
          maxLines: null,
          controller: control,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color.fromARGB(255, 255, 255, 255)),
        ));
  }
}

///class that implements functionality of altering second paragraph in page "Sobre Nós"
class TextAboutUsSecondParagraph extends StatefulWidget {
  const TextAboutUsSecondParagraph({Key? key}) : super(key: key);

  ///control variable [second] that will hold the value of the textfield controller
  static late TextEditingController second;

  ///operation to create the state of the widget
  @override
  State<TextAboutUsSecondParagraph> createState() =>
      _TextAboutUsSecondParagraphState();
}

///class that holds the state of the widget of second paragraph textfield
class _TextAboutUsSecondParagraphState
    extends State<TextAboutUsSecondParagraph> {
  ///[control] to be used as the controller of this textfield
  late final control;

  ///function to initiate the state of the widget
  ///[control] is specified as the controller for this textfield
  ///[TextAboutUsSecondParagraph.second] holds the value of variable [control]
  ///the text element of the textfield is initialized with the value of [Buttons.aboutUsSecond] which contains the second paragraph of the page "Sobre Nós" obtained via GET Request from a Strapi api
  @override
  void initState() {
    control = TextEditingController(text: Buttons.aboutUsSecond);
    TextAboutUsSecondParagraph.second = control;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 120, minHeight: 120),
        child: TextField(
          textAlignVertical: TextAlignVertical.top,

          ///[maxLines] attribute authorizes text cursor to be redirected below when max length in a line is reached
          ///basically permits multiple lines with a scroll function in this textfield
          maxLines: null,

          ///when user's performs a change in the textfield content, [TextAboutUsSecondParagraph.second] will be updated with [control] value
          onChanged: (value) {
            TextAboutUsSecondParagraph.second = control;
          },
          controller: control,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color.fromARGB(255, 255, 255, 255)),
        ));
  }
}
