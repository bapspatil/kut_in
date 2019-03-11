import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'quote.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kut In',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Kut In'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _quote;

  Future<String> getQuote() async {
    String baseUrl = 'http://api.kanye.rest/';
    try {
      http.Response response = await http.get(baseUrl);
      Map quoteMap = jsonDecode(response.body);
      var myQuote = Quote.fromJson(quoteMap);
      setState(() {
        _quote = myQuote.quote;
      });
      return myQuote.quote;
    } catch (e) {
      e.toString();
      return null;
    }
  }

  void _getNewQuote() {
    setState(() async {
      getQuote();
    });
  }

  @override
  void initState() {
    super.initState();
    this.getQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$_quote',
                style: Theme.of(context).textTheme.display2,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  '- Kanye West',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ],
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
