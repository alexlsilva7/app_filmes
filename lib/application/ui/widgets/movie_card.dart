import 'package:app_filmes/application/ui/theme_extension.dart';
import 'package:app_filmes/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class MovieCard extends StatelessWidget {
  final DateFormat dateFormat = DateFormat('y');
  final MovieModel movie;
  final VoidCallback favoriteCallback;
  MovieCard({Key? key, required this.movie, required this.favoriteCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/movie/detail', arguments: movie.id);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        width: 148,
        height: 270,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    clipBehavior: Clip.antiAlias,
                    child: CachedNetworkImage(
                      placeholder: (ctx, url) => Shimmer.fromColors(
                        baseColor: context.colorGrey,
                        highlightColor: Colors.white.withOpacity(0.5),
                        child: Container(
                          width: 148,
                          height: 184,
                          color: Colors.grey[800],
                        ),
                      ),
                      imageUrl:
                          'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                      width: 148,
                      height: 184,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  dateFormat.format(DateTime.parse(movie.releaseDate)),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 40,
              right: -8,
              child: Material(
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  height: 30,
                  child: IconButton(
                    iconSize: 13,
                    onPressed: favoriteCallback,
                    icon: Icon(movie.favorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    color:
                        movie.favorite ? context.colorRed : context.colorGrey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
