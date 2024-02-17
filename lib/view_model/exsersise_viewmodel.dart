import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news/model/excersise_model.dart';

class ExcersisProvider extends ChangeNotifier {
  ExcersisProvider() {
    fitness();
  }

  Excersise_Model? _excersiseModel;
  Excersise_Model? get excersiseModel => _excersiseModel;

  Future<void> fitness() async {
    try {
      final Map<String, dynamic> queryParameters = {
        'category_id': '1',
      };

      final uri = Uri.https(
          'gymwise.in', 'api/v1/customer/gymListByCategory', queryParameters);

      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);
        print("API Response: ${response.body}");

        if (responseData != null) {
          _excersiseModel = Excersise_Model.fromJson(responseData);
          notifyListeners();
        }
      } else {
        print('API request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
