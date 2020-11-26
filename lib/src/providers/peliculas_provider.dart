import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/src/models/actores_model.dart';
import 'package:movie_app/src/models/pelicula_model.dart';

class PeliculasProvider {
  int _popularesPage = 0;
  String _apiKey = '29aa7c6bc6fe17ef23da62c61c29b604';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  List<Pelicula> _populares = new List();
  List<Actor> _actores = new List();
  bool _cargando = false;

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  final _actoresStreamController = StreamController<List<Actor>>.broadcast();

  Function(List<Actor>) get actoresSink => _actoresStreamController.sink.add;

  Stream<List<Actor>> get actoresStream => _actoresStreamController.stream;

  void disposeStream() {
    _popularesStreamController?.close();
    _actoresStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Actor>> _procesarRespuestaActores(Uri url) async {
    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);
    final actores = new Cast.fromJsonMap(decodedData['cast']);
    return actores.actores;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> searchMovie(String query) async {
    final url = Uri.https(_url, '/3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];
    _cargando = true;
    _popularesPage++;
    final url = Uri.https(_url, '/3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': "$_popularesPage",
    });

    final respuesta = await _procesarRespuesta(url);

    _populares.addAll(respuesta);
    popularesSink(_populares);
    _cargando = false;
    return respuesta;
  }

  Future<List<Actor>> getCast(int idPelicula) async {
    final url = Uri.https(_url, '/3/movie/$idPelicula/credits', {
      'api_key': _apiKey,
    });

    final respuesta = await _procesarRespuestaActores(url);

    _actores.addAll(respuesta);
    actoresSink(_actores);
    return respuesta;
  }
}

//video 25
