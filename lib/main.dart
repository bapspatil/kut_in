import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'quote.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kut In',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Imperator',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _quote;
  List<Color> _gradientColors = [
    const Color(0xfff44336),
    const Color(0xffba000d),
    const Color(0xff9c27b0),
    const Color(0xff6a0080),
    const Color(0xff2196f3),
    const Color(0xff0069c0),
    const Color(0xfffdd835),
    const Color(0xffc6a700)
  ];
  final _random = Random();
  Color _colorOne, _colorTwo;

  Future<String> getQuote() async {
    String baseUrl = 'http://api.kanye.rest/';
    try {
      http.Response response = await http.get(baseUrl);
      var myQuote = Quote.fromJson(jsonDecode(response.body));
      setState(() {
        _quote = myQuote.quote;
        _colorOne = _gradientColors[_random.nextInt(_gradientColors.length)];
        _colorTwo = _gradientColors[_random.nextInt(_gradientColors.length)];
      });
      return myQuote.quote;
    } catch (e) {
      return null;
    }
  }

  void _getNewQuote() {
    setState(() {
      _quote = null;
    });
    getQuote();
  }

  @override
  void initState() {
    super.initState();
    this.getQuote();
    this._colorOne = _gradientColors[_random.nextInt(_gradientColors.length)];
    this._colorTwo = _gradientColors[_random.nextInt(_gradientColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_colorOne, _colorTwo],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    'KUT IN',
                    style: TextStyle(
                      color: Color(0xffeeeeee),
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: _quote != null
                        ? Text(
                            '$_quote',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 34.0,
                              height: 1.25,
                            ),
                          )
                        : CircularProgressIndicator(),
                  ),
                ),
                Text(
                  '- Kanye West',
                  style: TextStyle(
                    color: Color(0xffeeeeee),
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getNewQuote,
        tooltip: 'New Quote',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
