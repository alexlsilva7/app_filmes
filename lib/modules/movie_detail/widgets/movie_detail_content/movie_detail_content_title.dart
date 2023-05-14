import 'package:app_filmes/application/ui/theme_extension.dart';
import 'package:app_filmes/models/movie_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class MovieDetailContentTitle extends StatelessWidget {
  final MovieDetailModel? movie;

  const MovieDetailContentTitle({Key? key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movie?.title ?? '',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          RatingStars(
            value: (movie?.stars ?? 1) / 2,
            valueLabelVisibility: false,
            starColor: context.colorOrange,
            starSize: 14,
          ),
          const SizedBox(height: 8),
          Text(
            movie?.genres.map((e) => e.name).join(', ') ?? '',
            style: TextStyle(
              fontSize: 11,
              color: context.colorGrey,
            ),
          ),
        ],
      ),
    );
  }
}
