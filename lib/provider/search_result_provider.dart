import 'package:flutter/material.dart';
import 'package:google_clone/services/api_service.dart';

class SearchResultProvider extends ChangeNotifier {
  final apiService = ApiService();
  Map<String, dynamic>? searchResult;
}
