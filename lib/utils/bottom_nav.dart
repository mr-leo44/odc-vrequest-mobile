import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:odc_mobile_project/m_user/ui/pages/accueil/AccueilPageCtrl.dart';
import 'package:odc_mobile_project/navigation/routers.dart';
import 'package:odc_mobile_project/utils/plugins/bottom_nav_btn.dart';
import 'package:odc_mobile_project/utils/plugins/clipper.dart';
import 'package:odc_mobile_project/utils/constants.dart';
import 'package:odc_mobile_project/utils/size_config.dart';
import 'package:odc_mobile_project/utils/colors.dart';

class Bottom_nav {
  static Widget bottomNav(BuildContext context, WidgetRef ref, int _currentIndex, PageController pageController ) {

    void animateToPage(
      int page,
    ) {
      pageController.animateToPage(
        page,
        duration: const Duration(
          milliseconds: 400,
        ),
        curve: Curves.decelerate,
      );
    }

    var state = ref.watch(accueilPageCtrlProvider);
    var res = state.user?.role;
    var chatIsExist = false;

    if((res != null && res.any((e) => e.contains('charroi'))) || (res != null && res.any((e) => e.contains('chauffeur')))){
      chatIsExist = true;
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(AppSizes.blockSizeHorizontal * 4.5, 0,
          AppSizes.blockSizeHorizontal * 4.5, 10),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        color: Colors.transparent,
        elevation: 6,
        child: Container(
            height: AppSizes.blockSizeHorizontal * 15,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: AppSizes.blockSizeHorizontal * 3,
                  right: AppSizes.blockSizeHorizontal * 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BottomNavBTN(
                        onPressed: (val) {
                          // animateToPage(val);
                          context.pushNamed(Urls.accueil.name);
                          // setState(() {
                          //   _currentIndex = val;
                          // });
                        },
                        icon: IconlyLight.home,
                        currentIndex: _currentIndex,
                        index: 0,
                      ),
                      BottomNavBTN(
                        onPressed: (val) {
                          // animateToPage(val);

                          // setState(() {
                          //   _currentIndex = val;
                          // });

                          context.pushNamed(Urls.listeDemandes.name);
                        },
                        icon: IconlyLight.upload ,
                        currentIndex: _currentIndex,
                        index: 1,
                      ),
                      if(chatIsExist)
                      BottomNavBTN(
                        onPressed: (val) {
                          // animateToPage(val);

                          // setState(() {
                          //   _currentIndex = val;
                          // });

                          context.pushNamed(Urls.chatList.name);
                        },
                        icon: IconlyLight.chat,
                        currentIndex: _currentIndex,
                        index: 2,
                      ),
                      BottomNavBTN(
                        onPressed: (val) {
                          // animateToPage(val);

                          // setState(() {
                          //   _currentIndex = val;
                          // });

                          context.pushNamed(Urls.profil.name);
                        },
                        icon: IconlyLight.profile,
                        currentIndex: _currentIndex,
                        index: 3,
                      ),
                      // BottomNavBTN(
                      //   onPressed: (val) {
                      //     // animateToPage(val);

                      //     // setState(() {
                      //     //   _currentIndex = val;
                      //     // });
                      //   },
                      //   icon: IconlyLight.profile,
                      //   currentIndex: _currentIndex,
                      //   index: 4,
                      // ),
                    ],
                  ),
                ),
                AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.decelerate,
                    top: 0,
                    left: animatedPositionedLEftValue(_currentIndex, chatIsExist),
                    child: Column(
                      children: [
                        Container(
                          height: AppSizes.blockSizeHorizontal * 1.0,
                          width: AppSizes.blockSizeHorizontal * 12,
                          decoration: BoxDecoration(
                            color: Couleurs.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        ClipPath(
                          clipper: MyCustomClipper(),
                          child: Container(
                            height: AppSizes.blockSizeHorizontal * 15,
                            width: AppSizes.blockSizeHorizontal * 12,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: gradient,
                            )),
                          ),
                        ),
                      ],
                    ))
              ],
            )),
      ),
    );
  }
}
