import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_clone/config/api_keys.dart';
import 'package:google_clone/json/api_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  bool useDummyData = false;

  Future<Map<String, dynamic>> fetchData(
      {required BuildContext context,
      required String q,
      required String start}) async {
    if (!this.useDummyData) {
      final response =
          await http.get(Uri.https("www.googleapis.com", "customsearch/v1", {
        'key': apiKey,
        'cx': ctxKey,
        'q': q,
        'start': start,
      }));
      if (response.statusCode == 200) {
        final jsonData = response.body;
        final respData = json.decode(jsonData);
        return respData;
      } else {
        print('request failed');
        return {};
      }
    }
    return apiResponse;
  }
}
