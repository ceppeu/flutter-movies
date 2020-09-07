import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:movies/src/models/movie_model.dart';

class MovieProvider {
  String _apikey = '79684e086a2965ca5f1592b24cd5971d';
  String _url = 'api.themoviedb.org';
  String _language = 'es-MX';

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apikey, 'language': _language});

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }
}
