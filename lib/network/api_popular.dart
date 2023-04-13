import 'dart:convert';

import 'package:flutter_application_1/models/popular_model.dart';
import 'package:http/http.dart' as http;

class ApiPopular {
  Uri link = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=0cb894064f40656f3575e8ccae3d8d73&language=es-MX&page=1');

  Future<List<PopularModel>> getAllPopular() async {
    var result = await http.get(link);
    var listJson = jsonDecode(result.body)['results'] as List;
    if (result.statusCode == 200) {
      return listJson.map((popular) => PopularModel.fromMap(popular)).toList();
    }
    return null!;
  }
}
