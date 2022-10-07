enum ImagesConstant {
  movieDBLogo,
  avilaTek,
  movieDB,
  empty,
  noInternet,
}

const imageBase= 'assets/images/';
const iconBase = 'assets/icons/';
const imageUrl= 'http://image.tmdb.org/t/p/w500/';

extension ImagesConstantExtension on ImagesConstant {
  String get image {
    switch (this) {
      case ImagesConstant.movieDBLogo:
        return '${iconBase}movieDBLogo.png';

      case ImagesConstant.avilaTek:
        return '${imageBase}avilaTek.png';

      case ImagesConstant.movieDB:
        return '${imageBase}movieDB.png';

      case ImagesConstant.empty:
        return '${imageBase}empty.png';

      case ImagesConstant.noInternet:
        return '${imageBase}no_internet.png';
    }
  }
}