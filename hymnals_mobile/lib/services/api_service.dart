import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/hymnal.dart';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000"; // Your FastAPI server

  // Upload image and get transposed file
  Future<Hymnal?> uploadFile(File file, int transposeInterval) async {
    var uri = Uri.parse("$baseUrl/upload/");
    var request = http.MultipartRequest("POST", uri);

    request.files.add(await http.MultipartFile.fromPath("file", file.path));
    request.fields["transpose_interval"] = transposeInterval.toString();

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      return Hymnal.fromJson(jsonDecode(responseData));
    } else {
      print("Error: ${response.reasonPhrase}");
      return null;
    }
  }
}
