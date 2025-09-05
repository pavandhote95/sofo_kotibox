import 'dart:convert';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class RestApi {
  final storage = GetStorage();

  /// 🔐 Save token to local storage
  Future<void> saveToken(String token) async {
    await storage.write("token", token);
    print("✅ Token saved: $token");
  }

  /// 📦 Get token from storage
  Future<String?> getToken() async {
    return storage.read("token");
  }

  /// 🔑 Common headers with/without Auth
  Future<Map<String, String>> _getHeaders({bool withAuth = false}) async {
    final token = await getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
    if (withAuth && token != null) {
      headers["Authorization"] = "Bearer $token";
    }
    return headers;
  }

  /// Generic response handler
  http.Response _handleResponse(http.Response response) {
    print("🔹 API Response [${response.statusCode}]: ${response.body}");
    return response;
  }

  /// POST API without authentication
  Future<http.Response> postApi(String url, String request) async {
    final response = await http.post(
      Uri.parse(url),
      body: request,
      headers: await _getHeaders(),
      encoding: Encoding.getByName("utf-8"),
    );
    return _handleResponse(response);
  }

  /// GET API for OTP (no headers)
  Future<http.Response> getApiOTP(String path) async {
    var response = await http.get(Uri.parse(path));
    return _handleResponse(response);
  }

  /// POST API with authentication
  Future<http.Response> postApiWithAuth(String path, String request) async {
    final response = await http.post(
      Uri.parse(path),
      body: request,
      headers: await _getHeaders(withAuth: true),
    );
    return _handleResponse(response);
  }

  /// DELETE API with authentication
  Future<http.Response> deleteApiWithAuth(String path, String request) async {
    final response = await http.delete(
      Uri.parse(path),
      body: request,
      headers: await _getHeaders(withAuth: true),
    );
    return _handleResponse(response);
  }

  /// PUT API with authentication
  Future<http.Response> putApiWithAuth(String path, String request) async {
    final response = await http.put(
      Uri.parse(path),
      body: request,
      headers: await _getHeaders(withAuth: true),
    );
    return _handleResponse(response);
  }

  /// GET API with authentication
  Future<http.Response> getWithAuthApi(String path) async {
    final headers = await _getHeaders(withAuth: true);
    print("🔑 Token Used: ${headers['Authorization']}");
    final response = await http.get(Uri.parse(path), headers: headers);
    return _handleResponse(response);
  }

  /// GET API without authentication
  Future<http.Response> getApi(String path) async {
    final response = await http.get(
      Uri.parse(path),
      headers: await _getHeaders(),
    );
    return _handleResponse(response);
  }

  /// POST with token (Map body)
  Future<http.Response> postWithToken(
      String fullUrl, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(body),
      headers: await _getHeaders(withAuth: true),
    );
    return _handleResponse(response);
  }

  /// POST Multipart with Authentication (File Upload)
  Future<http.Response> postMultipartApiWithAuth(
    String url,
    Map<String, String> fields, {
    String fileKey = "file",
    File? file,
  }) async {
    final token = await getToken();
    var request = http.MultipartRequest("POST", Uri.parse(url));
    request.headers["Authorization"] = "Bearer $token";
    request.fields.addAll(fields);

    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath(fileKey, file.path));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return _handleResponse(response);
  }
}
