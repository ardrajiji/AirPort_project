import 'dart:convert';
import 'dart:io';

import 'package:airport_search_project/view/constants/urls.dart';
import 'package:airport_search_project/view/sorting_page/model/airport_model.dart';
import 'package:http/http.dart' as http;

Future<AirportModel> airportListService() async {
  try {

    Map<String, dynamic> params = {
      'value': 'd',
      'culture' : '1',
      'size': '100'

    };

    final resp = await http.get(
      Uri.parse('http://betaelastic.q8booking.net/Data/GetAirport').replace(queryParameters: params),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    
    if (resp.statusCode == 200) {
      final dynamic decoded = jsonDecode(resp.body);
      final response = AirportModel.fromJson(decoded);
      return response;
    } else {
      throw Exception('Failed to load response');
    }
  } on SocketException {
    throw Exception('Server error');
  } on HttpException {
    throw Exception('Something went wrong');
  } on FormatException {
    throw Exception('Bad request');
  } catch (e) {
    throw Exception(e.toString());
  }
}
