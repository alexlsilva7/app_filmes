import 'package:app_filmes/application/ui/messages/messages_mixin.dart';
import 'package:app_filmes/models/genre_model.dart';
import 'package:app_filmes/services/genres/genres_service.dart';
import 'package:get/get.dart';

class MoviesController extends GetxController with MessagesMixin {
  final GenresService _genresService;
  final _message = Rxn<MessageModel>();

  final _genres = <GenreModel>[].obs;

  List<GenreModel> get genres => _genres;

  MoviesController({required GenresService genresService})
      : _genresService = genresService;

  @override
  void onInit() {
    messageListener(_message);
    super.onInit();
  }

  @override
  void onReady() async {
    try {
      final genres = await _genresService.getGenres();
      _genres.assignAll(genres);
    } catch (e) {
      _message(
        MessageModel.error(
          title: 'Erro',
          message: 'Erro ao buscar categorias',
        ),
      );
    }

    super.onReady();
  }
}
