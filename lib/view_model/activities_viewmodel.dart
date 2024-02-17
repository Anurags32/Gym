import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news/model/activities_model.dart';

class ActivitesProvider extends ChangeNotifier {
  ActivitesProvider() {
    fitness();
  }

  Activitis_Model? _activitesModel;
  Activitis_Model? get activitesModel => _activitesModel;

  Future<void> fitness() async {
    try {
      final Map<String, dynamic> queryParameters = {
        'user_id': '0',
      };

      final uri = Uri.https(
          'gymwise.in', 'api/v1/partner/categories/list', queryParameters);

      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);
        print("API Response: ${response.body}");

        if (responseData != null) {
          _activitesModel = Activitis_Model.fromJson(responseData);
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
