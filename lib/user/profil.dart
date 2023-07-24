import 'package:beta_projek/user/password.dart';
import 'package:beta_projek/user/user.dart';
import 'package:flutter/material.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/editUser': (context) => EditUserPage(),
        '/editPassword': (context) => EditPasswordPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UbahDataPage()));
              },
              child: Text('Edit User', style: TextStyle(fontSize: 18.0)),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(200, 60)),
              ),
            ),
            SizedBox(height: 20), // Jarak antara tombol
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PasswordResetPage()));
              },
              child: Text('Edit Password', style: TextStyle(fontSize: 18.0)),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(200, 60)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
      ),
      body: Center(
        child: Text('Edit User Page', style: TextStyle(fontSize: 24.0)),
      ),
    );
  }
}

class EditPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Password'),
      ),
      body: Center(
        child: Text('Edit Password Page', style: TextStyle(fontSize: 24.0)),
      ),
    );
  }
}
