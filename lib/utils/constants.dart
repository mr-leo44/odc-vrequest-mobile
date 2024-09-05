import 'package:flutter/material.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatList/ChatListPage.dart';
import 'package:odc_mobile_project/m_demande/ui/page/list_demande/DemandeListPage.dart';
import 'package:odc_mobile_project/m_user/ui/pages/accueil/AccueilPage.dart';
import 'package:odc_mobile_project/m_user/ui/pages/profil/ProfilPage.dart';
import 'package:odc_mobile_project/utils/size_config.dart';
import 'package:odc_mobile_project/utils/colors.dart';

List<Widget> screens = [
  // const SampleWidget(
  //   label: 'HOME',
  //   color: Colors.deepPurpleAccent,
  // ),
  // const SampleWidget(
  //   label: 'SEARCH',
  //   color: Colors.amber,
  // ),
  // const SampleWidget(
  //   label: 'EXPLORE',
  //   color: Colors.cyan,
  // ),
  // const SampleWidget(
  //   label: 'SETTINGS',
  //   color: Colors.deepOrangeAccent,
  // ),
  // const SampleWidget(
  //   label: 'PROFILE',
  //   color: Colors.redAccent,
  // ),
  AccueilPage(),
  DemandeListPage(),
  ChatListPage(),
  Profilpage(),
  // AccueilPage(),
];

double animatedPositionedLEftValue(int currentIndex, bool chatIsExist) {
  if (chatIsExist) {
    switch (currentIndex) {
      case 0:
        return AppSizes.blockSizeHorizontal * 7.5;
      case 1:
        return AppSizes.blockSizeHorizontal * 28.5;
      case 2:
        return AppSizes.blockSizeHorizontal * 50;
      case 3:
        return AppSizes.blockSizeHorizontal * 71;
      default:
        return 0;
    }
  } else {
    switch (currentIndex) {
      case 0:
        return AppSizes.blockSizeHorizontal * 10.8;
      case 1:
        return AppSizes.blockSizeHorizontal * 39.2;
      case 3:
        return AppSizes.blockSizeHorizontal * 67.8;
      default:
        return 0;
    }
  }
}

final List<Color> gradient = [
  Couleurs.primary.withOpacity(0.8),
  Couleurs.primary.withOpacity(0.5),
  Colors.transparent
];
