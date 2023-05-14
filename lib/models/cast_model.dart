// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CastModel {
  final String name;
  final String imagePath;
  final String character;

  CastModel({
    required this.name,
    required this.imagePath,
    required this.character,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'original_name': name,
      'profile_path': imagePath,
      'character': character,
    };
  }

  factory CastModel.fromMap(Map<String, dynamic> map) {
    return CastModel(
      name: map['original_name'] as String,
      imagePath:
          'https://image.tmdb.org/t/p/w200${(map['profile_path'] ?? '')}',
      character: map['character'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CastModel.fromJson(String source) =>
      CastModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
