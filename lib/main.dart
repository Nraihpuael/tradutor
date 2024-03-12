// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Traducto',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController normalText = TextEditingController();
  TextEditingController translate = TextEditingController();
  String selectedLanguage = 'es';

  void translateText() async {
    GoogleTranslator translator = new GoogleTranslator();
    String textToTranslate = normalText.text;

    var translatedText = await translator.translate(
      textToTranslate,
      from: 'auto',
      to: selectedLanguage,
    );
    setState(() {
      translate.text = translatedText.text.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Traductor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: normalText,
                      decoration: InputDecoration(
                        labelText: 'Ingresa el texto',
                      ),
                    ),
                    SizedBox(height: 10),
                    DropdownButton<String>(
                      value: selectedLanguage,
                      onChanged: (value) {
                        setState(() {
                          selectedLanguage = value!;
                        });
                      },
                      items: <DropdownMenuItem<String>>[
                        DropdownMenuItem<String>(
                          value: 'es',
                          child: Text('Español'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'en',
                          child: Text('Inglés'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'fr',
                          child: Text('Francés'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'de',
                          child: Text('Alemán'),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: translateText,
                      child: Text('Traducir Texto'),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Texto traducido:',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: translate,
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Texto traducido',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
