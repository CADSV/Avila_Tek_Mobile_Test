import 'dart:convert';

MovieCreditModel getMovieCreditModelFromJson(String str) => MovieCreditModel.fromJson(json.decode(str));

///MovieCreditModel: Model for movie credits.
class MovieCreditModel {
  MovieCreditModel({
    this.id,
    this.cast,
    this.crew,
  });

  int? id;
  List<MovieCast>? cast;
  List<MovieCrew>? crew;

  factory MovieCreditModel.fromJson(Map<String, dynamic> json) => MovieCreditModel(
    id: json['id'],
    cast: List<MovieCast>.from(json['cast'].map((x) => MovieCast.fromJson(x))),
    crew: List<MovieCrew>.from(json['crew'].map((x) => MovieCrew.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'cast': List<dynamic>.from(cast!.map((x) => x.toJson())),
    'crew': List<dynamic>.from(crew!.map((x) => x.toJson())),
  };
}


///MovieCast: Model for movie cast.
class MovieCast {
  MovieCast({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
  });

  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;

  factory MovieCast.fromJson(Map<String, dynamic> json) => MovieCast(
    adult: json['adult'],
    gender: json['gender'],
    id: json['id'],
    knownForDepartment: json['known_for_department'],
    name: json['name'],
    originalName: json['original_name'],
    popularity: json['popularity'].toDouble(),
    profilePath: json['profile_path'],
    castId: json['cast_id'],
    character: json['character'],
    creditId: json['credit_id'],
    order: json['order'],
  );

  Map<String, dynamic> toJson() => {
    'adult': adult,
    'gender': gender,
    'id': id,
    'known_for_department': knownForDepartment,
    'name': name,
    'original_name': originalName,
    'popularity': popularity,
    'profile_path': profilePath,
    'cast_id': castId,
    'character': character,
    'credit_id': creditId,
    'order': order,
  };

}


///MovieCrew: Model for movie crew.
class MovieCrew {
  MovieCrew({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.creditId,
    this.department,
    this.job,
  });

  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  String? creditId;
  String? department;
  String? job;


  factory MovieCrew.fromJson(Map<String, dynamic> json) => MovieCrew(
    adult: json['adult'],
    gender: json['gender'],
    id: json['id'],
    knownForDepartment: json['known_for_department'],
    name: json['name'],
    originalName: json['original_name'],
    popularity: json['popularity'].toDouble(),
    profilePath: json['profile_path'],
    creditId: json['credit_id'],
    department: json['department'],
    job: json['job'],
  );

  Map<String, dynamic> toJson() => {
    'adult': adult,
    'gender': gender,
    'id': id,
    'known_for_department': knownForDepartment,
    'name': name,
    'original_name': originalName,
    'popularity': popularity,
    'profile_path': profilePath,
    'credit_id': creditId,
    'department': department,
    'job': job,
  };

}

