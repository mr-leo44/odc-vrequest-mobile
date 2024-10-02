import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odc_mobile_project/m_demande/business/interactor/demandeInteractor.dart';
import 'package:odc_mobile_project/m_demande/ui/composant/MyListTile.dart';
import 'package:odc_mobile_project/m_user/ui/pages/accueil/AccueilPageCtrl.dart';
import 'package:odc_mobile_project/utils/size_config.dart';
import 'package:odc_mobile_project/utils/bottom_nav.dart';
import 'package:odc_mobile_project/utils/colors.dart';
import 'package:odc_mobile_project/utils/layouts/header.dart';
import 'package:odc_mobile_project/utils/logout.dart';

import '../../../../navigation/routers.dart';
import '../../../../shared/ui/pages/notification/NotificationController.dart';
import '../../../../shared/ui/pages/shared/SharedCtrl.dart';
import '../profil/ProfilPageCtrl.dart';

class AccueilPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends ConsumerState<AccueilPage> {
  int _currentIndex = 0;
  final PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // action initiale de la page et appel d'un controleur
      var ctrl = ref.read(accueilPageCtrlProvider.notifier);
      ctrl.getUser();
      ctrl.nombreDemande();
      ctrl.recentDemande();

      var sharedCtrl = ref.read(sharedCtrlProvider.notifier);
      sharedCtrl.init();

      var notifCtrl = ref.read(notificationControllerProvider.notifier);
      notifCtrl.listen();
    });
  }

  var height, width;

  List imageData = [
    "assets/images/icon-add.png",
    "assets/images/icon-progress.png",
    "assets/images/icon-list.png",
    "assets/images/icon-done.png",
    //"images/stats.png",
    // "images/recent.png",
    //"images/about.png",
  ];

  List title = [
    "Nouvelle demande",
    "Number",
    "Liste demande",
    "Statistiques",
    "Recent",
    "About"
  ];

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    var notifState = ref.watch(notificationControllerProvider);
    print("NotifState: ${notifState.initialAction}");

    return Scaffold(
      appBar: _entete(),
      // drawer: Navigate.menu(context, ref),
      body: Container(
        color: Colors.white ,
        height: AppSizes.screenHeight,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: [
              Container(
                height: AppSizes.screenHeight * 0.89,
                child: ListView(
                  children: [
                    Container(
                      height: height,
                      width: width,
                      child: Column(
                        children: [
                          Container(
                            height: height * 0.15,
                            width: width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                    left: 30,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Tableau de bord",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Derniere demande : 4 Juin 2024",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: GridView.builder(
                              padding: EdgeInsets.all(8),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.1,
                                      mainAxisSpacing: 20),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: imageData.length,
                              itemBuilder: (context, index) {
                                var state = ref.watch(accueilPageCtrlProvider);
                                var nombre = state.nombre["demande_encours"];
                                var traiter = state.nombre['demande_traite'];
                                var res = state.user?.role;

                                if (res != null &&
                                    res.any((e) => e.contains('charroi'))) {
                                  var demande =
                                      state.nombre['demande_non_traite'];
                                  if (index == 1) {
                                    return InkWell(
                                      onTap: () {
                                        if (index == 3) {
                                          context.pushNamed(Urls.stat.name);
                                        }
                                      },
                                      child: InkWell(
                                        onDoubleTap: () => Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    AccueilPage())),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 21),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black26,
                                                    spreadRadius: 1,
                                                    blurRadius: 6)
                                              ]),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                'Demande',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                              Image.asset(
                                                "assets/images/icon-request.png",
                                                width: 70,
                                              ),
                                              Text(
                                                "$demande non traitée",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  } else if (index == 3) {
                                    return InkWell(
                                      onTap: () {
                                        if (index == 3) {
                                          context.pushNamed(Urls.stat.name);
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 21),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  spreadRadius: 1,
                                                  blurRadius: 6)
                                            ]),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.asset(
                                              "assets/images/icon-chart.png",
                                              width: 70,
                                            ),
                                            Text(
                                              "Statistiques",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }

                                  return InkWell(
                                    onTap: () {
                                      if (index == 3) {
                                        context.pushNamed(Urls.stat.name);
                                      } else if (index == 2) {
                                        context
                                            .pushNamed(Urls.listeDemandes.name);
                                      } else if (index == 0) {
                                        context.pushNamed(Urls.demande.name);
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 21),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black26,
                                                spreadRadius: 1,
                                                blurRadius: 6)
                                          ]),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(
                                            imageData[index],
                                            width: 100,
                                          ),
                                          Text(
                                            title[index],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                //si l'utilisateur n'a pas le role charroi
                                if (index == 1) {
                                  return InkWell(
                                    onTap: () {
                                      if (index == 1) {
                                        context.pushNamed(
                                            Urls.demande_encours.name);
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black26,
                                                spreadRadius: 1,
                                                blurRadius: 6)
                                          ]),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(
                                            imageData[index],
                                            width: 100,
                                          ),
                                          Text(
                                            "$nombre",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Demandes en cours",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Spacer()
                                        ],
                                      ),
                                    ),
                                  );
                                } else if (index == 3) {
                                  return InkWell(
                                    onTap: () {
                                      if (index == 3) {
                                        context
                                            .pushNamed(Urls.demandeTraite.name);
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black26,
                                                spreadRadius: 1,
                                                blurRadius: 6)
                                          ]),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(
                                            imageData[index],
                                            width: 90,
                                          ),
                                          Text(
                                            "$traiter",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Demandes traitées",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Spacer()
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                return InkWell(
                                  onTap: () {
                                    if (index == 3) {
                                      context.pushNamed(Urls.stat.name);
                                    } else if (index == 2) {
                                      context
                                          .pushNamed(Urls.listeDemandes.name);
                                    } else if (index == 0) {
                                      context.pushNamed(Urls.demande.name);
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              spreadRadius: 1,
                                              blurRadius: 6)
                                        ]),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          imageData[index],
                                          width: 100,
                                        ),
                                        Text(
                                          title[index],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            height: height * 0.38,
                            width: width,
                            child: Column(
                              children: [
                                Text(
                                  "Demandes Recentes",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(child: _listedemande()),
                                    
                              ],
                            ),
                          ),
                                                      
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Bottom_nav.bottomNav(
                    context, ref, _currentIndex, pageController),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _entete() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Header.header(
        context,
        Text(
          "",
          style: TextStyle(
            color: Colors.black,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () async {
            Logout.logout(context, ref);
          },
          icon: Icon(Icons.logout,color: Colors.black,),
        ),
        IconButton(
          onPressed: () {
            var ctrl = ref.read(accueilPageCtrlProvider.notifier);
            ctrl.nombreDemande();
          },
          icon: Icon(Icons.sync),
        )
      ],
    );
  }

  Widget _listedemande() {
    var state = ref.watch(accueilPageCtrlProvider);
    var demande = state.last;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: ListView.separated(
          itemCount: demande.length,
          itemBuilder: (ctx, index) {
            var _demande = demande[index];
            return MyListTile(demande: _demande);
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 10.0,
            );
          },
        ),
      ),
    );
  }
}
