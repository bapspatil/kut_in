import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'about_screen.dart';
import 'quote.dart';

void main() => runApp(KutInApp());

class KutInApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kut In',
      theme: ThemeData(
        fontFamily: 'Imperator',
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  Future<void> getQuote() async {
    String baseUrl = 'http://api.kanye.rest/';
    try {
      http.Response response = await http.get(baseUrl);
      var myQuote = Quote.fromJson(jsonDecode(response.body));
      setState(() {
        _quote = myQuote.quote;
        _gradientColors.shuffle(_random);
        _colorOne = _gradientColors[0];
        _colorTwo = _gradientColors[1];
      });
    } catch (e) {}
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
    getQuote();
    _gradientColors.shuffle(_random);
    _colorOne = _gradientColors[0];
    _colorTwo = _gradientColors[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [_colorOne, _colorTwo]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text('KUT IN'),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(Icons.info, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AboutScreen()
                              ));
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: _quote != null
                        ? Text('$_quote',
                            style: TextStyle(
                              fontSize: 34.0,
                              height: 1.25,
                            ))
                        : CircularProgressIndicator(),
                  ),
                ),
                Text('- Kanye West'),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _getNewQuote, child: Icon(Icons.refresh)),
    );
  }
}
