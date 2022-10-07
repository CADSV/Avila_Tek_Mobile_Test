///RepositorysConstant: Enum for repositories methods.
enum RepositoryConstant {
  contentType,
  operationGet,
  operationPost,
  operationPut,
  operationDelete,
}


 const movieApiKey = 'daf06d93a38e15b05c13b95de4b4af1f';

extension RepositoryConstantExtension on RepositoryConstant {
  String get key {
    switch (this) {
      case RepositoryConstant.contentType:
        return 'application/json';
      case RepositoryConstant.operationGet:
        return 'get';
      case RepositoryConstant.operationPost:
        return 'post';
      case RepositoryConstant.operationPut:
        return 'put';
      case RepositoryConstant.operationDelete:
        return 'delete';
    }
  }
}

enum RepositoryParameterPathConstant {
  movieId,
  actorId,
}

extension RepositoryParameterPathConstantExtension on RepositoryParameterPathConstant {
  String get path {
    switch (this) {
      case RepositoryParameterPathConstant.movieId:
        return '{movie_id}';

      case RepositoryParameterPathConstant.actorId:
        return '{actor_id}';
    }
  }
}


///RepositoryPathConstant: Enum for endpoints path.
enum RepositoryPathConstant {
  moviesFeed,
  movieCredits,
  actorInfo,
  moviesByActor,
  popularActors,
}

extension RepositoryPathConstantExtension on RepositoryPathConstant {
  String get path {
    switch (this) {
      case RepositoryPathConstant.moviesFeed:
        return 'movie/popular?api_key=$movieApiKey&page=';

      case RepositoryPathConstant.movieCredits:
        return 'movie/{movie_id}/credits?api_key=$movieApiKey';

      case RepositoryPathConstant.actorInfo:
        return 'person/{actor_id}?api_key=$movieApiKey&append_to_response=credits';

      case RepositoryPathConstant.moviesByActor:
        return 'discover/movie?api_key=$movieApiKey&with_cast={actor_id}&page=1';

      case RepositoryPathConstant.popularActors:
        return 'person/popular?api_key=$movieApiKey&page=';

    }
  }
}
