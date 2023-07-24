// Import package: http pada bagian atas file
import 'package:http/http.dart' as http;
import 'package:beta_projek/dashboard/model.dart';

class DetekApi {
  Future<List<Detek>> getAllDetek() async {
    var client = http.Client();
    var uri = Uri.parse("http://192.168.56.40:5000/api/detek");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return detekFromJson(json);
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
