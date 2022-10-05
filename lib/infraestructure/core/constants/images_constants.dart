enum ImagesConstant {
  movieDBLogo,
  avilaTek,
  movieDB,
}

const imageBase= 'assets/images/';
const iconBase = 'assets/icons/';
const imageUrl= 'http://image.tmdb.org/t/p/w500/';

extension ImagesConstantExtension on ImagesConstant {
  String get image {
    switch (this) {
      case ImagesConstant.movieDBLogo:
        return '${iconBase}movieDBLogo.svg';

      case ImagesConstant.avilaTek:
        return '${imageBase}avilaTek.png';

      case ImagesConstant.movieDB:
        return '${imageBase}movieDB.png';
    }
  }
}