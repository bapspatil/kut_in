import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  _openWebsite() async {
    const url = 'https://bapspatil.com';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image(image: AssetImage('assets/bapspatil.png')),
            SizedBox(height: 15),
            Text('Bapusaheb Patil', style: TextStyle(fontSize: 32.0)),
            SizedBox(height: 20),
            Text('I make apps, watchfaces & memes.', style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () { _openWebsite(); },
              child: Text('bapspatil.com', style: TextStyle(fontSize: 18.0, backgroundColor: Colors.white, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
