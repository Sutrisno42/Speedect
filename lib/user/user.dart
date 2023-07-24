import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UbahDataPage extends StatefulWidget {
  @override
  _UbahDataPageState createState() => _UbahDataPageState();
}

class _UbahDataPageState extends State<UbahDataPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController tokenController = TextEditingController();
  TextEditingController currentNameController = TextEditingController();
  TextEditingController newNameController = TextEditingController();

  bool _isTokenSent = false;

  void _sendToken() async {
    String email = emailController.text;
    String url = 'http://172.20.10.2:5000/send_token';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {'email': email},
      );

      if (response.statusCode == 200) {
        setState(() {
          _isTokenSent = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Token berhasil dikirim!'),
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

  void _ubahData() async {
    String email = emailController.text;
    String token = tokenController.text;
    String currentName = currentNameController.text;
    String newName = newNameController.text;
    String url = 'http://172.20.10.2:5000/edit';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': email,
          'token': token,
          'current_name': currentName,
          'new_name': newName,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data berhasil diubah!'),
          ),
        );
        // Lakukan tindakan lain setelah data diubah
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengubah data.'),
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

  Widget _buildEmailForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Masukkan Email',
          ),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: _sendToken,
          child: Text('Kirim Token'),
        ),
      ],
    );
  }

  Widget _buildEditDataForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: tokenController,
          decoration: InputDecoration(
            labelText: 'Masukkan Token',
          ),
        ),
        SizedBox(height: 16.0),
        TextField(
          controller: currentNameController,
          decoration: InputDecoration(
            labelText: 'Nama Lama',
          ),
        ),
        SizedBox(height: 16.0),
        TextField(
          controller: newNameController,
          decoration: InputDecoration(
            labelText: 'Nama Baru',
          ),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: _ubahData,
          child: Text('Ubah Data'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: _isTokenSent ? _buildEditDataForm() : _buildEmailForm(),
      ),
    );
  }
}
