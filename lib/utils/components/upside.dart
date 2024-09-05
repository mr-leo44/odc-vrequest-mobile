import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:odc_mobile_project/utils/colors.dart';

class Upside extends StatelessWidget {
  const Upside({Key? key, required this.imgUrl, required this.scale}) : super(key: key);
  final String imgUrl;
  final double scale;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height / 2.5,
          color: Couleurs.primary,
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Image.asset(
              imgUrl,
              alignment: Alignment.topCenter,
              scale: scale,
            ),
          ),
        ),
        // iconBackButton(context),
        Positioned(
          left: 0,
          top: 185,
          child: Image.network(
            "https://img.icons8.com/hands/400/car.png",
            scale: 5,
          ),
        ),
        Positioned(
          right: 0,
          top: 60,
          child: Image.network(
            "https://img.icons8.com/doodle/96/car--v1.png",
            scale: 3,
          ),
        ),
      ],
    );
  }
}

iconBackButton(BuildContext context) {
  return IconButton(
    color: Colors.white,
    iconSize: 28,
    icon: const Icon(CupertinoIcons.arrow_left),
    onPressed: () {
      Navigator.pop(context);
    },
  );
}
