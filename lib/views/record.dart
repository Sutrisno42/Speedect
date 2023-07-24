import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:beta_projek/views/reaction.dart';

class Recording extends StatefulWidget {
  @override
  _RecordingState createState() => _RecordingState();
}

class _RecordingState extends State<Recording> {
  FlutterSoundRecorder? _recorder;
  bool _isRecording = false;
  String _filePath = '';

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _initRecorder();
  }

  @override
  void dispose() {
    _recorder?.closeAudioSession();
    super.dispose();
  }

  Future<void> _initRecorder() async {
    await _recorder?.openAudioSession();
  }

  Future<void> _startRecording() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final uuid = Uuid();
      final fileName = '${uuid.v4()}.wav';
      final filePath = '${tempDir.path}/$fileName';

      await _recorder?.startRecorder(
        toFile: filePath,
        codec: Codec.pcm16WAV,
      );

      setState(() {
        _isRecording = true;
        _filePath = filePath;
      });
    } catch (e) {
      print('Terjadi kesalahan saat memulai rekaman audio: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      await _recorder?.stopRecorder();
      setState(() {
        _isRecording = false;
      });
      final file = File(_filePath);

      await _sendAudioToAPI(file);
    } catch (e) {
      print('Terjadi kesalahan saat menghentikan rekaman audio: $e');
    }
  }

  Future<void> _sendAudioToAPI(File audioFile) async {
    try {
      final url = Uri.parse('http://192.168.56.40:5000/detect_emotion');
      final request = http.MultipartRequest('POST', url);
      request.files
          .add(await http.MultipartFile.fromPath('audio', audioFile.path));
      final response = await request.send();

      if (response.statusCode == 200) {
        final jsonString = await response.stream.bytesToString();
        final json = jsonDecode(jsonString);
        var label = json['labels'];
        if (label == 'neutral') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SplashKonfigurasiNeutral()));
        } else if (label == 'calm') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SplashKonfigurasiCalm()));
        } else if (label == 'happy') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SplashKonfigurasiHappy()));
        } else if (label == 'sad') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SplashKonfigurasiSad()));
        } else if (label == 'angry') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SplashKonfigurasiAngry()));
        } else if (label == 'fearful') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SplashKonfigurasiFearful()));
        } else if (label == 'disgust') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SplashKonfigurasiDisgust()));
        } else if (label == 'surprised') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SplashKonfigurasiSurprised()));
        } else {
          print("Tidak Diketahui");
          //   // Navigator.push(context,
          //   //     MaterialPageRoute(builder: (context) => SplashKonfigurasiAnak()));
        }
      } else {
        print('Gagal mengirim audio ke API. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Terjadi kesalahan saat mengirim audio ke API: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rekam Suara'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isRecording)
              Column(
                children: [
                  Icon(
                    Icons.mic_rounded,
                    size: 50,
                    color: Colors.blue,
                  ),
                  Text('Sedang merekam...'),
                  SizedBox(height: 16),
                ],
              ),
            if (!_isRecording)
              Padding(
                padding: EdgeInsets.only(
                    bottom: 16), // Menambahkan jarak bawah pada ikon mic
                child: ElevatedButton(
                  onPressed: _startRecording,
                  child: Icon(
                    Icons.mic_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ElevatedButton(
              onPressed: _stopRecording,
              child: Icon(
                Icons.stop_circle,
                size: 50,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
