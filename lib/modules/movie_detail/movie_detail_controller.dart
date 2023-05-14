import 'package:app_filmes/application/ui/loader/loader_mixin.dart';
import 'package:app_filmes/application/ui/messages/messages_mixin.dart';
import 'package:app_filmes/models/movie_detail_model.dart';
import 'package:app_filmes/services/movies/movies_service.dart';
import 'package:get/get.dart';

class MovieDetailController extends GetxController
    with LoaderMixin, MessagesMixin {
  final MoviesService _moviesService;

  MovieDetailController({required MoviesService moviesService})
      : _moviesService = moviesService;

  var loading = false.obs;
  var message = Rxn<MessageModel>();

  var movie = Rxn<MovieDetailModel>();

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
  }

  @override
  void onReady() async {
    super.onReady();
    try {
      final movieId = Get.arguments;
      loading(true);
      final movieDetailData = await _moviesService.getMovieDetail(movieId);
      movie.value = movieDetailData;
    } on Exception catch (e) {
      print(e);
      message(MessageModel.error(
        title: 'Erro',
        message: 'Erro ao buscar detalhes do filme',
      ));
    } finally {
      loading(false);
    }
  }
}
