import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:new_project/models/jokes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String joke = '';
  @override
  void initState() {
    getRandomJolke();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 300,
              child: Column(children: [
                Text(
                  joke,
                  style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                )
              ]),
            ),
            IconButton(
              onPressed: () {

                
              },
              icon: const Icon(Icons.heart_broken_outlined),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      translateFromRuToEn();
                      setState(() {});
                    },
                    child: const Text(
                      'English',
                    )),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      translateFromEnToRu();
                      setState(() {});
                    },
                    child: const Text(
                      "Русский",
                    )),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getRandomJolke();
          setState(() {});
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> getRandomJolke() async {
    final Dio dio = Dio();
    try {
      final Response response =
          await dio.get('https://api.chucknorris.io/jokes/random');
      final JokesModel model = JokesModel.fromJson(response.data);
      joke = model.value ?? 'Hello';
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  void translateFromEnToRu() async {
    final translator = GoogleTranslator();
    final input = joke;

    var translatedText = translator.translate(input, to: 'ru');
    await translatedText.then((value) => joke = value.toString());
    setState(() {});

    // prints exemplo
  }

  void translateFromRuToEn() async {
    final translator = GoogleTranslator();
    final input = joke;
    var translatedText = translator.translate(input, to: 'en');
    await translatedText.then((value) => joke = value.toString());

    setState(() {});

    // prints exemplo
  }

  Future<void> sharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('num', 4);
    await prefs.setString('str', 'murat');
    
  }
}
