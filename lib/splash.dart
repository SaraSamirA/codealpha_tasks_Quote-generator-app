import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q/quotes.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Text(
              'Random Quotes',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 50),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RandomQuotePage(),
                      ),
                    );
                  },
                  label: Text(
                    'Get Started',
                    style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                  ),
                  icon: Icon(Icons.arrow_forward, color: Colors.grey[700]),
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xffffe2c2)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}