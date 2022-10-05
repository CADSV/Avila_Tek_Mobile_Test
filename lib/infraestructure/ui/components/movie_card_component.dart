//Flutter imports
import 'package:flutter/material.dart';

//Project imports
import 'package:avila_tek_test/infraestructure/core/constants/images_constants.dart';
import 'package:avila_tek_test/domain/models/movies/popular_movies_model.dart';
import 'package:avila_tek_test/infraestructure/ui/styles/colors.dart';

class MovieCardComponent extends StatelessWidget {

  final MovieModel movie;
  const MovieCardComponent({
    Key? key,
    required this.movie,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(cardTheme: Theme.of(context).cardTheme),
      child: Card(
        color: colorBlack,
        // shadowColor: colorBlack,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: Image.network(
                imageUrl + movie.posterPath!,
                fit: BoxFit.fill,
                height: double.infinity,
                width: double.infinity,
              )),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  padding: const EdgeInsets.only(bottom: 2, left: 8),
                  child: Text(
                    movie.title!,
                    maxLines: 5,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: colorWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 8, left: 8),
                  color: Colors.transparent,
                  child: Text(
                    '${(movie.voteAverage!*10).toStringAsFixed(0)}% User Score',
                    maxLines: 5,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: colorWhite,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Baloo 2'
                    ),
                  )
                ),
              ],
            )
        ]),
        ));
  }
}