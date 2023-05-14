import 'package:app_filmes/models/movie_detail_model.dart';
import 'package:flutter/material.dart';

class MovieDetailContentOverview extends StatelessWidget {
  final MovieDetailModel? movie;

  const MovieDetailContentOverview({Key? key, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 50),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          movie?.overview ?? '',
          style: const TextStyle(fontSize: 14, height: 1.3),
        ),
      ),
    );
  }
}
