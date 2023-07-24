import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PasswordResetPage extends StatefulWidget {
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

  void _sendToken() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String url = 'http://192.168.230.132:5000/send_token';

      try {
        final response = await http.post(
          Uri.parse(url),
          body: {'email': email},
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Token berhasil dikirim!'),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyTokenPage(email: email),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal mengirim token.'),
            ),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $error'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukkan email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _sendToken,
                child: Text('Kirim Token'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VerifyTokenPage extends StatefulWidget {
  final String email;

  const VerifyTokenPage({required this.email});

  @override
  _VerifyTokenPageState createState() => _VerifyTokenPageState();
}

class _VerifyTokenPageState extends State<VerifyTokenPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _tokenController = TextEditingController();
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();

  void _verifyToken() async {
    if (_formKey.currentState!.validate()) {
      String email = widget.email;
      String token = _tokenController.text;
      String currentPassword = _currentPasswordController.text;
      String newPassword = _newPasswordController.text;
      String url = 'http://192.168.230.132:5000/changepassword';

      try {
        final response = await http.post(
          Uri.parse(url),
          body: {
            'email': email,
            'token': token,
            'current_password': currentPassword,
            'new_password': newPassword,
          },
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Password berhasil diubah!'),
            ),
          );
          Navigator.pushNamed(context, '/success');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal mengubah password.'),
            ),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $error'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verifikasi Token'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tokenController,
                decoration: InputDecoration(
                  labelText: 'Token',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukkan token';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _currentPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password Lama',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukkan password lama';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password Baru',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukkan password baru';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _verifyToken,
                child: Text('Verifikasi Token'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
