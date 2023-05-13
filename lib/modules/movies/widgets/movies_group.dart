import 'package:app_filmes/application/ui/widgets/movie_card.dart';
import 'package:app_filmes/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoviesGroup extends StatelessWidget {
  final String title;
  final List<MovieModel> movies;

  const MoviesGroup({Key? key, required this.title, required this.movies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 233,
          child: Obx(
            () {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return MovieCard(movie: movies[index]);
                },
                itemCount: movies.length,
                scrollDirection: Axis.horizontal,
              );
            },
          ),
        ),
      ],
    );
  }
}
