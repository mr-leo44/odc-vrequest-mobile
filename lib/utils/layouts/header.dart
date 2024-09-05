import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:odc_mobile_project/navigation/routers.dart';

class Header {
  static Widget header(BuildContext context, Widget title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => context.pushNamed(Urls.accueil.name),
          child: Container(
            width: 40,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Image.asset(
                "assets/logo/orange.png",
              ),
            ),
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 12,
            ),
            title,
          ],
        ),
      ],
    );
  }
}
