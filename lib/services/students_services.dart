import 'dart:convert';
import 'package:http/http.dart' as http;

class StudentService {
  static const String baseUrl =
      'https://crudcrud.com/api/577722695adb44c195602badf01451e0/owais';

  // GET
  static Future<List<dynamic>> getStudents() async {
    Uri uri = Uri.parse(baseUrl);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      throw 'Do not found (404)';
    } else {
      throw 'Failed to load students. status code ${response.statusCode}';
    }
  } 

  // POST
  static Future<dynamic> addStudent(Map<String, dynamic> data) async {
    Uri uri = Uri.parse(baseUrl);
    var response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return response.body;
  }

  // PUT
  static Future<dynamic> updateStudent(
    String id,
    Map<String, dynamic> data,
  ) async {
    Uri uri = Uri.parse('$baseUrl/$id');
    var response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return response.body;
  }

  // DELETE
  static Future<dynamic> deleteStudent(String id) async {
    Uri uri = Uri.parse('$baseUrl/$id');
    var response = await http.delete(uri);
    return response.body;
  }
}
