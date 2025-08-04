import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:dio/dio.dart' as RESPONSE;
import 'package:dio/dio.dart';

class RestApi {
  var storage = GetStorage();

  //Post api without authentication
  Future<http.Response> postApi(String url, String request) async {
    var response = await http.post(
      Uri.parse(url),
      body: request,
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
      encoding: Encoding.getByName("utf-8"),
    );
    return response;
  }

  //OTP api with url
  Future<http.Response> getApiOTP(String path) async {
    var response = await http.get(Uri.parse(path));
    print(response.body);
    return response;
  }

  //Post api with authentication
  Future<http.Response> postApiWithAuth(String path, String request) async {
    var response = await http.post(
      Uri.parse(path),
      body: request,
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "Authorization": 'Bearer ${storage.read("token")}',
      },
    );

    return response;
  }

  //Delete api with authentication
  Future<http.Response> deleteApiWithAuth(String path, String request) async {
    var response = await http.delete(
      Uri.parse(path),
      body: request,
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "Authorization": 'Bearer ${storage.read("token")}',
      },
    );

    return response;
  }

  //Put api with authentication
  Future<http.Response> putApiWithAuth(String path, String request) async {
    var response = await http.put(
      Uri.parse(path),
      body: request,
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "Authorization": 'Bearer ${storage.read("token")}',
      },
    );

    return response;
  }

  //Get api with authentication
  Future<http.Response> getWithAuthApi(String path) async {
    // print("my token is here >>>>");
    // print(storage.read("token"));

    var response = await http.get(
      Uri.parse(path),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "Authorization": 'Bearer ${storage.read("token")}',
      },
    );

    return response;
  }

  Future<http.Response> getApi(String path) async {
    var response = await http.get(
      Uri.parse(path),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );

    return response;
  }


  Future<http.Response> postWithToken(String fullUrl, Map<String, dynamic> body) async {

    final token = storage.read("token");
    print(token);
    final response = await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": 'Bearer $token',
      },
    );

    return response;
  }

}
