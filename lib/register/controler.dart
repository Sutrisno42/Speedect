import 'dart:convert';
import 'dart:io';
import 'package:beta_projek/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:beta_projek/otp.dart';

class HttpService {
  static final _client = http.Client();

  static var _registerUrl = Uri.parse('http://172.20.10.7:5000/register');

  static flutter_register(email, name, password, context) async {
    http.Response response = await _client.post(_registerUrl, body: {
      "email": email,
      "name": name,
      "password": password,
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == 'Email Telah digunakan!') {
        // EasyLoading.showError(json[0]);
      } else {
        // Jika data tidak ada maka akan masuk ke menu selanjutnya
        // await EasyLoading.showSuccess(json[0]);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
    } else {
      // await EasyLoading.showError(
      //     "Error Code : ${response.statusCode.toString()}");
    }
  }
}
