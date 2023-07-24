import 'package:flutter/material.dart';

class SplashKonfigurasiNeutral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reaction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NEUTRAL',
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 16),
            Icon(
              Icons.sentiment_neutral,
              size: 250,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

class SplashKonfigurasiCalm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reaction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CALM',
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 16),
            Icon(
              Icons.sentiment_satisfied_alt,
              size: 250,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

class SplashKonfigurasiHappy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reaction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'HAPPY',
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 16),
            Icon(
              Icons.sentiment_very_satisfied,
              size: 250,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

class SplashKonfigurasiSad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reaction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SAD',
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 16),
            Icon(
              Icons.sentiment_very_dissatisfied,
              size: 250,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

class SplashKonfigurasiAngry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reaction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ANGRY',
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 16),
            Icon(
              Icons.sentiment_very_dissatisfied,
              size: 250,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

class SplashKonfigurasiFearful extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reaction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'FEARFUL',
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 16),
            Icon(
              Icons.sentiment_very_dissatisfied,
              size: 250,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

class SplashKonfigurasiSurprised extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reaction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SURPRISED',
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 16),
            Icon(
              Icons.sentiment_satisfied_alt,
              size: 250,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

class SplashKonfigurasiDisgust extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reaction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'DISGUST',
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 16),
            Icon(
              Icons.sentiment_very_dissatisfied,
              size: 250,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
