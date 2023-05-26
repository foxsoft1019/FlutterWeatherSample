
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter_weather_sample/entities/response_entity.dart';
import 'package:flutter_weather_sample/constants/method.dart';


class ApiClient{
  ApiClient();

  Future<ResponseEntity> request(String uri, String method, Map<String, dynamic>? params, {bool passHeader = true, bool isOnlyAcceptType = false,}) async {

    Uri url = Uri.parse(uri);
    http.Response response;

    try {
      if (method == Method.postMethod) {
        response = await http.post(url, body: params, headers: {
          "Accept": "application/json",
        });
      } else if (method == Method.deleteMethod) {
        response = await http.delete(url, body: params, headers: {
          "Accept": "application/json",
        });
      }else if (method == Method.putMethod) {
        response = await http.put(url, body: params, headers: {
          "Accept": "application/json",
        });
      } else if (method == Method.updateMethod) {
        response = await http.patch(url);
      } else {
        response = await http.get(
          url,
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ResponseEntity(true, 'Success', 200, response.body);
      } else if (response.statusCode == 401) {
        return ResponseEntity(false, 'Unauthorized', 401, response.body);
      } else if (response.statusCode == 500) {
        return ResponseEntity(false, 'Server Error', 500, response.body);
      } else {
        return ResponseEntity(false, 'Something Wrong', 499, response.body);
      }
    } on SocketException catch (e) {
      return ResponseEntity(false, 'No Internet Connection', 503, e.message.toString());
    } on FormatException {
      return ResponseEntity(false, 'Bad Response Format!', 400, '');
    } catch (e) {
      return ResponseEntity(false, 'Something Went Wrong', 499, '');
    }
  }
}