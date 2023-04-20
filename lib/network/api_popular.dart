import 'dart:convert';

import 'package:flutter_application_1/models/popular_model.dart';
import 'package:flutter_application_1/models/actor_model.dart';

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

  Future<List<ActorModel>?> getAllActors(PopularModel popularModel) async {
    Uri link = Uri.parse(
        'https://api.themoviedb.org/3/movie/${popularModel.id}/credits?api_key=0cb894064f40656f3575e8ccae3d8d73');
    var result = await http.get(link);
    var listJSON = jsonDecode(result.body)['cast'] as List;
    if (result.statusCode == 200) {
      return listJSON.map((actor) => ActorModel.fromMap(actor)).toList();
    }
    return null;
  }

  Future<String> getVideo(int id_popular) async {
    Uri linkEN = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id_popular/videos?api_key=89dbf5270b59edd2f28730765b489b9e');
    var result = await http.get(linkEN);
    var listJSON = jsonDecode(result.body)['results'] as List;
    if (result.statusCode == 200) {
      for (var element in listJSON) {
        if (element['type'] == 'Trailer') {
          return element['key'];
        }
      }
    }
    return '';
  }
}
