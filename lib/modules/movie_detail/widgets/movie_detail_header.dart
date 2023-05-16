import 'package:app_filmes/models/movie_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

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
              child: CachedNetworkImage(
                placeholder: (ctx, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.white.withOpacity(0.5),
                  child: Container(
                    width: 148,
                    height: 184,
                    color: Colors.grey[800],
                  ),
                ),
                imageUrl: 'https://image.tmdb.org/t/p/w200$image',
                width: 148,
                height: 184,
                fit: BoxFit.cover,
              ),
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
