import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:movies/src/models/actors_model.dart';
import 'package:movies/src/models/movie_model.dart';

class MovieProvider {
  String _apikey = '79684e086a2965ca5f1592b24cd5971d';
  String _url = 'api.themoviedb.org';
  String _language = 'es-MX';

  int _popularsPage = 0;
  bool _loading = false;

  List<Movie> _populars = new List();

  final _popularsStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;

  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  void disposeStreams() {
    _popularsStreamController?.close();
  }

  Future<List<Movie>> _processResponse(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final movies = new Movies.fromJsonList(decodedData['results']);
    return movies.items;
  }

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apikey, 'language': _language});
    return await _processResponse(url);
  }

  Future<List<Movie>> getPopularMovies() async {
    if (_loading) return [];
    _loading = true;
    _popularsPage++;
    final url = Uri.http(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularsPage.toString()
    });

    final response = await _processResponse(url);

    _populars.addAll(response);
    popularsSink(_populars);
    _loading = false;
    return response;
  }

  Future<List<Actor>> getCast(String movieId) async {
    final url = Uri.https(_url, '3/movie/$movieId/credits',
        {'api_key': _apikey, 'language': _language});

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);
    return cast.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apikey, 'language': _language, 'query': query});
    return await _processResponse(url);
  }
}
