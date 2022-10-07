//Flutter imports
import 'package:flutter/material.dart';

//Project imports
import 'package:avila_tek_test/infraestructure/core/constants/images_constants.dart';
import 'package:avila_tek_test/infraestructure/ui/styles/colors.dart';


///This component is used to render cards.
class CardComponent extends StatelessWidget {

  final String? title;
  final String? subtitle;
  final String? imagePath;
  final String cardId;
  const CardComponent({
    Key? key,
    required this.title,
    this.subtitle,
    required this.imagePath,
    required this.cardId,
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
            _renderCardImage(context),
            Column( 
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _renderCardTitle(context),
                _renderCardSubtitle(context),
              ],
            )
        ]),
        ));
  }


  ///This method is used to render the image of the card.
  Widget _renderCardImage(BuildContext context) =>
    ClipRRect( //IMAGE
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: Hero(
        tag: cardId,
        child: imagePath !=  null ? Image.network(
          imageUrl + imagePath!,
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
        ) : Image.asset(
          ImagesConstant.empty.image,
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,),
      )
    );


  ///This method is used to render the title of the card.
  Widget _renderCardTitle(BuildContext context) =>
    Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: const EdgeInsets.only(bottom: 2, left: 8),
      child: Text(
        title != null ? title! : '',
        maxLines: 5,
        textAlign: TextAlign.start,
        style: const TextStyle(
          color: colorWhite,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      )
    );


  ///This method is used to render the subtitle of the card.
  Widget _renderCardSubtitle(BuildContext context) =>
    Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 8, left: 8),
      color: Colors.transparent,
      child: Text(
        subtitle != null ? subtitle! : '',
        maxLines: 5,
        textAlign: TextAlign.start,
        style: const TextStyle(
          color: colorWhite,
          fontSize: 13,
          fontWeight: FontWeight.w400,
          fontFamily: 'Baloo 2'
        ),
      )
    );

}