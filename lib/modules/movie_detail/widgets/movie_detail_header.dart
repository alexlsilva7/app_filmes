import 'package:app_filmes/models/movie_detail_model.dart';
import 'package:flutter/material.dart';

class MovieDetailHeader extends StatelessWidget {
  final MovieDetailModel? movie;

  const MovieDetailHeader({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (movie != null) {
      return SizedBox(
        height: 278,
        child: ListView.builder(
          itemBuilder: (context, index) {
            final image = movie!.urlImages[index];
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.network(image),
            );
          },
          itemCount: movie!.urlImages.length,
          scrollDirection: Axis.horizontal,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
