enum ImagesConstant {
  a
}

const imageBase= 'assets/images/';
const imageUrl= 'http://image.tmdb.org/t/p/w500/';

extension ImagesConstantExtension on ImagesConstant {
  String get image {
    switch (this) {
      case ImagesConstant.a:
        return '${imageBase}logo.png';
    }
  }
}