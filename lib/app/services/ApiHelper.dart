import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class ApiHelper {
  static final storage = GetStorage();

  static Future<Map<String, dynamic>> postMultipart({
    required String url,
    required Map<String, String> fields,
    File? imageFile,
    String imageKey = 'image',
  }) async {
    try {
      final uri = Uri.parse(url);
      final request = http.MultipartRequest('POST', uri);

      // Add headers
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'multipart/form-data';
      // Add Authorization token if available
      final token = storage.read('token');
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      print(token);
      // Add form fields
      request.fields.addAll(fields);

      // Add image file if provided
      if (imageFile != null) {
        request.files
            .add(await http.MultipartFile.fromPath(imageKey, imageFile.path));
      }

      // Send the request
      final response = await request.send();
      final respStr = await response.stream.bytesToString();
      final decoded = json.decode(respStr);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': decoded['message'] ?? 'Success',
          'data': decoded['data'], // optional
        };
      } else {
        return {
          'success': false,
          'message': decoded['message'] ?? 'Failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'API request failed: $e',
      };
    }
  }
}
