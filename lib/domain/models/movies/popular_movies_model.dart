import 'dart:convert';

PopularMoviesModel getPopularMoviesModelFromJson(String str) => PopularMoviesModel.fromJson(json.decode(str));


///PopularMoviesModel: Model for popular movies.
class PopularMoviesModel {
PopularMoviesModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int? page;
  List<MovieModel>? results;
  int? totalPages;
  int? totalResults;

  factory PopularMoviesModel.fromJson(Map<String, dynamic> json) => PopularMoviesModel(
    page: json['page'],
    results: List<MovieModel>.from(json['results'].map((x) => MovieModel.fromJson(x))),
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


///MovieModel: Model for a movie.
class MovieModel {
  MovieModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
    adult: json['adult'],
    backdropPath: json['backdrop_path'],
    genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
    id: json['id'],
    originalLanguage: json['original_language'],
    originalTitle: json['original_title'],
    overview: json['overview'],
    popularity: json['popularity'].toDouble(),
    posterPath: json['poster_path'],
    releaseDate: json['release_date'],
    title: json['title'],
    video: json['video'],
    voteAverage: json['vote_average'].toDouble(),
    voteCount: json['vote_count'],
  );

  Map<String, dynamic> toJson() => {
    'adult': adult,
    'backdrop_path': backdropPath,
    'genre_ids': List<dynamic>.from(genreIds!.map((x) => x)),
    'id': id,
    'original_language': originalLanguage,
    'original_title': originalTitle,
    'overview': overview,
    'popularity': popularity,
    'poster_path': posterPath,
    'release_date': releaseDate,
    'title': title,
    'video': video,
    'vote_average': voteAverage,
    'vote_count': voteCount,
  };

}