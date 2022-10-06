import 'dart:convert';

import 'package:avila_tek_test/domain/models/movies/popular_movies_model.dart';

ActorModel getActorModelFromJson(String str) => ActorModel.fromJson(json.decode(str));

///ActorModel: Model for an actor.
class ActorModel {
  ActorModel({
    this.birthday,
    this.knownForDepartment,
    this.deathday,
    this.id,
    this.name,
    this.alsoKnownAs,
    this.gender,
    this.biography,
    this.popularity,
    this.placeOfBirth,
    this.profilePath,
    this.adult,
    this.imdbId,
    this.homepage,
    this.movies,
  });

  DateTime? birthday;
  String? knownForDepartment;
  dynamic deathday;
  int? id;
  String? name;
  List<String>? alsoKnownAs;
  int? gender;
  String? biography;
  double? popularity;
  String? placeOfBirth;
  String? profilePath;
  bool? adult;
  String? imdbId;
  dynamic homepage;
  List<MovieModel>? movies;


  factory ActorModel.fromJson(Map<String, dynamic> json) => ActorModel(
    birthday: json['birthday'] == null ? null : DateTime.parse(json['birthday']),
    knownForDepartment: json['known_for_department'],
    deathday: json['deathday'],
    id: json['id'],
    name: json['name'],
    alsoKnownAs: List<String>.from(json['also_known_as'].map((x) => x)),
    gender: json['gender'],
    biography: json['biography'],
    popularity: json['popularity'].toDouble(),
    placeOfBirth: json['place_of_birth'],
    profilePath: json['profile_path'],
    adult: json['adult'],
    imdbId: json['imdb_id'],
    homepage: json['homepage'],
    movies: List<MovieModel>.from(json['movies'].map((x) => MovieModel.fromJson(x))),
  );


  Map<String, dynamic> toJson() => {
    'birthday': birthday == null ? null : birthday!.toIso8601String(),
    'known_for_department': knownForDepartment,
    'deathday': deathday,
    'id': id,
    'name': name,
    'also_known_as': List<dynamic>.from(alsoKnownAs!.map((x) => x)),
    'gender' : gender,
    'biography': biography,
    'popularity': popularity,
    'place_of_birth': placeOfBirth,
    'profile_path': profilePath,
    'adult': adult,
    'imdb_id': imdbId,
    'homepage': homepage,
    'movies': List<dynamic>.from(movies!.map((x) => x.toJson())),
  };

}