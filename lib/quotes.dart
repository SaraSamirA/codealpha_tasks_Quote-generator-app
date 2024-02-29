import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'favorite.dart';

class RandomQuotePage extends StatefulWidget {
  @override
  _RandomQuotePageState createState() => _RandomQuotePageState();
}

class _RandomQuotePageState extends State<RandomQuotePage> {
  final List<String> _quotes = [
    "The only way to do great work is to love what you do. - Steve Jobs",
    "Innovation distinguishes between a leader and a follower. - Steve Jobs",
    "Stay hungry, stay foolish. - Steve Jobs",
    "Don't let the noise of others' opinions drown out your own inner voice. - Steve Jobs",
    "Your time is limited, don't waste it living someone else's life. - Steve Jobs",
    "Believe you can and you're halfway there. - Theodore Roosevelt",
    "The only impossible journey is the one you never begin. - Tony Robbins",
    "The only limit to our realization of tomorrow will be our doubts of today. - Franklin D. Roosevelt",
    "You are never too old to set another goal or to dream a new dream. - C.S. Lewis",
    "The future belongs to those who believe in the beauty of their dreams. - Eleanor Roosevelt",
  ];

  List<String> _favoriteQuotes = [];

  String _currentQuote = '';

  @override
  void initState() {
    super.initState();
    _generateRandomQuote();
  }

  void _generateRandomQuote() {
    final random = Random();
    final index = random.nextInt(_quotes.length);
    setState(() {
      _currentQuote = _quotes[index];
    });
  }

  void _addToFavorites() {
    setState(() {
      if (_favoriteQuotes.contains(_currentQuote)) {
        _favoriteQuotes.remove(_currentQuote);
      } else {
        _favoriteQuotes.add(_currentQuote);
      }
    });
  }

  void _shareQuote() {
    Share.share(_currentQuote);
  }

  void _shareOnFacebook() async {
    String url = 'https://www.facebook.com/sharer/sharer.php?u=$_currentQuote';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _shareOnInstagram() async {
    String url = 'https://www.instagram.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _shareOnLinkedIn() async {
    String url = 'https://www.linkedin.com/sharing/share-offsite/?url=$_currentQuote';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteQuotesScreen(
                    favoriteQuotes: _favoriteQuotes,
                  ),
                ),
              );
            },
            icon: Icon(Icons.favorite, color: Colors.red),
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/q2.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: Text(
                  _currentQuote,
                  style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _generateRandomQuote,
                    child: Text(
                      'New Quote',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff615a57)
                          .withOpacity(0.5)),
                    ),
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    onPressed: () {
                      _addToFavorites();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(_favoriteQuotes.contains(_currentQuote)
                              ? 'Added to favorites'
                              : 'Removed from favorites'),
                        ),
                      );
                    },
                    icon: Icon(
                      _favoriteQuotes.contains(_currentQuote)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: _favoriteQuotes.contains(_currentQuote)
                          ? Colors.red
                          : Colors.white,
                    ),
                    iconSize: 40,
                  ),
                  SizedBox(width: 20),

                ],
              ),
              SizedBox(height: 70,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _shareOnFacebook,
                    icon: Icon(Icons.facebook),
                    color: Colors.white,
                    iconSize: 40,
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    onPressed: _shareOnInstagram,
                    icon: Icon(FontAwesomeIcons.instagram),
                    color: Colors.white,
                    iconSize: 40,
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    onPressed: _shareOnLinkedIn,
                    icon: Icon(FontAwesomeIcons.linkedin),
                    color: Colors.white,
                    iconSize: 40,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}