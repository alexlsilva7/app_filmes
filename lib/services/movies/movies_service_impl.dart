import 'package:app_filmes/models/movie_model.dart';
import 'package:app_filmes/repositories/movies/movies_repository.dart';

import './movies_service.dart';

class MoviesServiceImpl implements MoviesService {
  final MoviesRepository _moviesRepository;

  MoviesServiceImpl({required MoviesRepository moviesRepository})
      : _moviesRepository = moviesRepository;

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    return _moviesRepository.getPopularMovies();
  }

  @override
  Future<List<MovieModel>> getTopRated() async {
    return _moviesRepository.getTopRated();
  }
}
