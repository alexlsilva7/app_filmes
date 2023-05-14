// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app_filmes/models/cast_model.dart';
import 'package:app_filmes/models/genre_model.dart';

class MovieDetailModel {
  final String title;
  final double stars;
  final List<GenreModel> genres;
  final List<String> urlImages;
  final DateTime releaseDate;
  final String overview;
  final List<String> productionCompanies;
  final String originalLanguage;
  final List<CastModel> cast;

  MovieDetailModel({
    required this.title,
    required this.stars,
    required this.genres,
    required this.urlImages,
    required this.releaseDate,
    required this.overview,
    required this.productionCompanies,
    required this.originalLanguage,
    required this.cast,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'stars': stars,
      'genres': genres.map((x) => x.toMap()).toList(),
      'urlImages': urlImages,
      'releaseDate': releaseDate.millisecondsSinceEpoch,
      'overview': overview,
      'productionCompanies': productionCompanies,
      'originalLanguage': originalLanguage,
      'cast': cast,
    };
  }

  factory MovieDetailModel.fromMap(Map<String, dynamic> map) {
    var urlImagesPosters = map['images']['posters'] as List<dynamic>;
    var urlImages = urlImagesPosters
        .map<String>(
            (e) => 'https://image.tmdb.org/t/p/w200${e['file_path'] ?? ''}')
        .toList();

    return MovieDetailModel(
      title: map['title'] ?? '',
      stars: map['vote_average'],
      genres: List<GenreModel>.from(
        (map['genres'] as List<dynamic>).map<GenreModel>(
          (x) => GenreModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      urlImages: urlImages,
      releaseDate: DateTime.parse(map['release_date'] as String).toLocal(),
      overview: map['overview'] as String,
      productionCompanies:
          List<dynamic>.from(map['production_companies'] ?? const [])
              .map<String>((e) => e['name'] as String)
              .toList(),
      originalLanguage: map['original_language'] as String,
      cast: List<CastModel>.from(
        (map['credits']['cast'] as List<dynamic>).map<CastModel>(
          (x) => CastModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieDetailModel.fromJson(String source) =>
      MovieDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
