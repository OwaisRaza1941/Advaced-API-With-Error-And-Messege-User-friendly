import 'dart:convert';
import 'package:http/http.dart' as http;

class StudentService {
  static const String baseUrl =
      'https://crudcrud.com/api/b9f656d316bf496a8ac5b71d8527917f/students';

  // GET
  static Future<List<dynamic>> getStudents() async {
    Uri uri = Uri.parse(baseUrl);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 404) {
      throw 'Error: ${response.statusCode} – Data not found';
    } else {
      throw 'Failed to load students. Status code: ${response.statusCode}';
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

    if (response.statusCode == 201) {
      return response.body;
    } else if (response.statusCode == 400 || response.statusCode == 404) {
      throw 'Error : ${response.statusCode} Wrong Input Data';
    } else {
      throw 'Failed to load students. Status code: ${response.statusCode}';
    }
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

    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 404) {
      throw 'Not Found (404) – Student ID doesn\'t exist';
    } else {
      throw 'Failed to update student. Status Code: ${response.statusCode}';
    }
  }

  // DELETE
  static Future<dynamic> deleteStudent(String id) async {
    Uri uri = Uri.parse('$baseUrl/$id');
    var response = await http.delete(uri);
    if (response.statusCode == 200 || response.statusCode == 204) {
      return response.body;
    } else if (response.statusCode == 404) {
      throw 'Not Found (404) – Student already deleted or not found';
    } else {
      throw 'Failed to delete student. Status Code: ${response.statusCode}';
    }
  }
}
