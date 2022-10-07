import 'dart:convert';

import 'package:avila_tek_test/domain/models/movies/popular_movies_model.dart';


PopularActorModel getActorModelFromJson(String str) => PopularActorModel.fromJson(json.decode(str));

///PopularActorModel: Model for popular actors.
class PopularActorModel {

  PopularActorModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });


  int? page;
  List<Actor>? results;
  int? totalPages;
  int? totalResults;


  factory PopularActorModel.fromJson(Map<String, dynamic> json) => PopularActorModel(
    page: json['page'],
    results: List<Actor>.from(json['results'].map((x) => Actor.fromJson(x))),
    totalPages: json['total_pages'],
    totalResults: json['total_results'],
  );

  Map<String, dynamic> toJson() => {
    'page': page,
    'results': List<dynamic>.from(results!.map((x) => x.toJson())),
    'total_pages': totalPages,
    'total_results': totalResults,
  };

}


class Actor {

  Actor({
    this.profilePath,
    this.adult,
    this.id,
    this.knownFor,
    this.name,
    this.popularity,
  });


  String? profilePath;
  bool? adult;
  int? id;
  List<MovieModel>? knownFor;
  String? name;
  double? popularity;


  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
    profilePath: json['profile_path'],
    adult: json['adult'],
    id: json['id'],
    knownFor: List<MovieModel>.from(json['known_for'].map((x) => MovieModel.fromJson(x))),
    name: json['name'],
    popularity: json['popularity'].toDouble(),
  );


  Map<String, dynamic> toJson() => {
    'profile_path': profilePath,
    'adult': adult,
    'id': id,
    'known_for': List<dynamic>.from(knownFor!.map((x) => x.toJson())),
    'name': name,
    'popularity': popularity,
  };

}