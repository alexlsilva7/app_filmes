import 'dart:developer';

import 'package:app_filmes/application/rest_client/rest_client.dart';
import 'package:app_filmes/models/movie_detail_model.dart';
import 'package:app_filmes/models/movie_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import './movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final RestClient _restClient;

  MoviesRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final result = await _restClient.get<List<MovieModel>>(
      '/movie/popular',
      query: {
        'api_key': FirebaseRemoteConfig.instance.getString('api_token'),
        'language': 'pt-br',
        'page': '1',
      },
      decoder: (data) {
        final resultData = data['results'];
        if (resultData != null) {
          return resultData
              .map<MovieModel>((movie) => MovieModel.fromMap(movie))
              .toList();
        }
        return <MovieModel>[];
      },
    );

    if (result.hasError) {
      log('Erro ao buscar filmes populares', error: result.statusText);
      print(result.statusText);
      throw Exception('Erro ao buscar filmes populares ${result.statusText}}');
    }

    return result.body ?? <MovieModel>[];
  }

  @override
  Future<List<MovieModel>> getTopRated() async {
    final result = await _restClient.get<List<MovieModel>>(
      '/movie/top_rated',
      query: {
        'api_key': FirebaseRemoteConfig.instance.getString('api_token'),
        'language': 'pt-br',
        'page': '1',
      },
      decoder: (data) {
        final resultData = data['results'];
        if (resultData != null) {
          return resultData
              .map<MovieModel>((topMovie) => MovieModel.fromMap(topMovie))
              .toList();
        }
        return <MovieModel>[];
      },
    );

    if (result.hasError) {
      log('Erro ao buscar top filmes', error: result.statusText);
      print(result.statusText);
      throw Exception('Erro ao buscar top filmes ${result.statusText}}');
    }

    return result.body ?? <MovieModel>[];
  }

  @override
  Future<MovieDetailModel?> getMovieDetail(int id) async {
    final result = await _restClient.get<MovieDetailModel>(
      '/movie/$id',
      query: {
        'api_key': FirebaseRemoteConfig.instance.getString('api_token'),
        'language': 'pt-br',
        'append_to_response': 'images,credits',
        'include_image_language': 'en,pt-br',
      },
      decoder: (data) {
        return MovieDetailModel.fromMap(data);
      },
    );

    if (result.hasError) {
      log('Erro ao buscar detalhes do filme', error: result.statusText);
      print(result.statusText);
      throw Exception('Erro ao buscar detalhes do filme ${result.statusText}}');
    }

    return result.body;
  }

  @override
  Future<void> addOrRemoveFavorite(String userId, MovieModel movie) async {
    try {
      var favoriteColletion = FirebaseFirestore.instance
          .collection('favorities')
          .doc(userId)
          .collection('movies');
      print(movie.toMap());
      if (movie.favorite) {
        favoriteColletion.add(movie.toMap());
      } else {
        var favoriteData = await favoriteColletion
            .where('id', isEqualTo: movie.id)
            .limit(1)
            .get();
        favoriteData.docs.first.reference.delete();
      }
    } on Exception {
      print('Erro ao favoritar filme');
      rethrow;
    }
  }

  @override
  Future<List<MovieModel>> getFavoritiesMovies(String userId) async {
    var favoritesMovies = await FirebaseFirestore.instance
        .collection('favorities')
        .doc(userId)
        .collection('movies')
        .get();

    return favoritesMovies.docs
        .map((m) => MovieModel.fromMap(m.data()))
        .toList();
  }
}
