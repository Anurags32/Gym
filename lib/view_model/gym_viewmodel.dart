import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news/model/gymelist_model.dart';

class FitnessModeProvider extends ChangeNotifier {
  FitnessModeProvider() {
    fitness();
  }

  Gymlist_model? _fitnessModel;
  Gymlist_model? get fitnessModel => _fitnessModel;

  Future<void> fitness() async {
    try {
      final Map<String, dynamic> queryParameters = {
        'latitude': '28.583745',
        'longitude': '77.3155413'
      };

      final uri =
          Uri.https('gymwise.in', '/api/v1/customer/gymList', queryParameters);

      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);
        print("API Response: ${response.body}");

        if (responseData != null) {
          _fitnessModel = Gymlist_model.fromJson(responseData);
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
