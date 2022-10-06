//Flutter imports
import 'package:flutter/material.dart';

//Project imports
import 'package:avila_tek_test/infraestructure/core/constants/images_constants.dart';
import 'package:avila_tek_test/infraestructure/ui/styles/colors.dart';
import 'package:avila_tek_test/domain/models/movies/movie_credits_model.dart';


///This component is used to render the actor card in the movie credit page.
class ActorCardComponent extends StatelessWidget {

  final MovieCast actor;
  const ActorCardComponent({
    Key? key,
    required this.actor,
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
            ClipRRect( //IMAGE
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: Hero(
                tag: actor.id.toString(),
                child: Image.network(
                  imageUrl + actor.profilePath!,
                  fit: BoxFit.fill,
                  height: double.infinity,
                  width: double.infinity,
                ),
              )),
            Column( //ACTOR NAME
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  padding: const EdgeInsets.only(bottom: 2, left: 8),
                  child: Text(
                    actor.name!,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: colorWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
                Container( //ACTOR CHARACTER
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 8, left: 8),
                  color: Colors.transparent,
                  child: Text(
                    actor.character!,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: colorWhite,
                      fontSize: 13,
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