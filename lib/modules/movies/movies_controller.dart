import 'package:app_filmes/application/ui/messages/messages_mixin.dart';
import 'package:app_filmes/models/genre_model.dart';
import 'package:app_filmes/models/movie_model.dart';
import 'package:app_filmes/services/genres/genres_service.dart';
import 'package:app_filmes/services/movies/movies_service.dart';
import 'package:diacritic/diacritic.dart';
import 'package:get/get.dart';

class MoviesController extends GetxController with MessagesMixin {
  final GenresService _genresService;
  final MoviesService _moviesService;
  final _message = Rxn<MessageModel>();

  final _genres = <GenreModel>[].obs;
  final popularMovies = <MovieModel>[].obs;
  final topRatedMovies = <MovieModel>[].obs;

  var _popularMoviesOriginal = <MovieModel>[];
  var _topRatedMoviesOriginal = <MovieModel>[];

  final genreSelected = Rxn<GenreModel>();

  List<GenreModel> get genres => _genres;

  MoviesController({
    required GenresService genresService,
    required MoviesService moviesService,
  })  : _genresService = genresService,
        _moviesService = moviesService;

  @override
  void onInit() {
    messageListener(_message);
    super.onInit();
  }

  @override
  void onReady() async {
    try {
      final genresData = await _genresService.getGenres();
      _genres.assignAll(genresData);
    } catch (e) {
      _message(
        MessageModel.error(
          title: 'Erro',
          message: 'Erro ao buscar categorias',
        ),
      );
    }

    try {
      final popularMoviesData = await _moviesService.getPopularMovies();
      final topRatedMoviesData = await _moviesService.getTopRated();

      popularMovies.assignAll(popularMoviesData);
      _popularMoviesOriginal = popularMoviesData;
      topRatedMovies.assignAll(topRatedMoviesData);
      _topRatedMoviesOriginal = topRatedMoviesData;
    } catch (e, s) {
      print(e);
      print(s);
      _message(
        MessageModel.error(
          title: 'Erro',
          message: e.toString(),
        ),
      );
    }

    super.onReady();
  }

  void filterByName(String title) {
    if (title.isNotEmpty) {
      var newPopularMovies = _popularMoviesOriginal.where(
        (movie) => removeDiacritics(movie.title.toLowerCase())
            .contains(removeDiacritics(title.toLowerCase())),
      );
      var newTopRatedMovies = _topRatedMoviesOriginal.where(
        (movie) => removeDiacritics(movie.title.toLowerCase())
            .contains(removeDiacritics(title.toLowerCase())),
      );

      popularMovies.assignAll(newPopularMovies);
      topRatedMovies.assignAll(newTopRatedMovies);
    } else {
      popularMovies.assignAll(_popularMoviesOriginal);
      topRatedMovies.assignAll(_topRatedMoviesOriginal);
    }
  }

  void filterByGenre(GenreModel? genreModel) {
    if (genreModel?.id == genreSelected.value?.id) {
      genreModel = null;
    }

    if (genreModel != null) {
      var newPopularMovies = _popularMoviesOriginal.where(
        (movie) => movie.genreIds.contains(genreModel?.id),
      );
      var newTopRatedMovies = _topRatedMoviesOriginal.where(
        (movie) => movie.genreIds.contains(genreModel?.id),
      );

      popularMovies.assignAll(newPopularMovies);
      topRatedMovies.assignAll(newTopRatedMovies);
    } else {
      popularMovies.assignAll(_popularMoviesOriginal);
      topRatedMovies.assignAll(_topRatedMoviesOriginal);
    }

    genreSelected.value = genreModel;
  }
}
