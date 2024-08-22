
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odc_mobile_project/m_demande/business/interactor/demandeInteractor.dart';
import 'package:odc_mobile_project/m_user/ui/pages/accueil/AccueilPageCtrl.dart';

import '../../../../navigation/routers.dart';
import '../../../../shared/business/model/Notification.dart';
import '../../../../shared/ui/pages/notification/NotificationController.dart';
import '../../../../shared/ui/pages/shared/SharedCtrl.dart';
import '../profil/ProfilPageCtrl.dart';

class AccueilPage extends ConsumerStatefulWidget{

  @override
  ConsumerState<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends ConsumerState<AccueilPage> {

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
  var height,width;

  List imageData = [
    "images/new.png",
    "images/encours.png",
    "images/list.png",
    "images/valide.png",
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
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    var notifState = ref.watch(notificationControllerProvider);
    print("NotifState: ${notifState.initialAction}");
    return Scaffold(
        appBar: _entete(),
        drawer: _menu(),
        body: ListView(
            children: [ SafeArea(
              child :Container(
                color: Colors.orange,
                height: height,
                width: width,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                      ),
                      height: height*0.15,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Dashboard",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                  ),),
                                SizedBox(height: 5,),
                                Text("Last demand : 4 june 2024",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                  ),)
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
                            topRight: Radius.circular(30)
                        ),

                      ),
                      height: height*0.50,
                      width: width,
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.1,
                              mainAxisSpacing: 20
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: imageData.length,
                          itemBuilder: (context, index){
                            var state = ref.watch(accueilPageCtrlProvider);
                            var nombre = state.nombre["demande_encours"];
                            var traiter = state.nombre['demande_traite'];
                            var res = state.user?.role;

                            if( res != null && res.any((e) => e.contains('charroi'))){
                              var demande = state.nombre['demande_non_traite'];
                              if(index == 1){
                                return InkWell(
                                  onTap: (){
                                    if(index==3){
                                      context.pushNamed(Urls.stat.name);
                                    }

                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        boxShadow: [BoxShadow(
                                            color: Colors.black26,
                                            spreadRadius: 1,
                                            blurRadius: 6

                                        )]
                                    ),
                                    child: InkWell(
                                      onTap: () => NotificationController
                                          .createNewNotification(NotificationPush(
                                          title: "Manu Tshibs",
                                          body: "Bomboclat",
                                          notificationActionButtons: [
                                            NotificationActionButton(
                                                key: 'REDIRECT', label: 'Ouvrir'),
                                            NotificationActionButton(
                                                key: 'REPLY',
                                                label: 'Repondre',
                                                requireInputText: true,
                                                actionType:
                                                ActionType.SilentAction),
                                            NotificationActionButton(
                                                key: 'DISMISS',
                                                label: 'Dismiss',
                                                actionType:
                                                ActionType.DismissAction,
                                                isDangerousOption: true)
                                          ])),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [

                                          Text('Demande',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17
                                            ),),
                                          Image.asset(
                                            imageData[index],
                                            width: 100,
                                          ),

                                          Text(
                                            "$demande  non traitée",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Spacer()
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }


                              else if(index == 3){
                                return InkWell(
                                  onTap: (){
                                    if(index==3){
                                      context.pushNamed(Urls.stat.name);
                                    }



                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        boxShadow: [BoxShadow(
                                            color: Colors.black26,
                                            spreadRadius: 1,
                                            blurRadius: 6

                                        )]
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [

                                        Image.asset("images/stats.png",width: 100,),


                                        Text("Statistiques",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),),


                                      ],
                                    ),
                                  ),
                                );
                              }

                              return InkWell(
                                onTap: (){
                                  if(index==3){
                                    context.pushNamed(Urls.stat.name);
                                  }
                                  else if(index==2){
                                    context.pushNamed(Urls.listeDemandes.name);
                                  }
                                  else if(index==0){
                                    context.pushNamed(Urls.demande.name);
                                  }

                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(
                                          color: Colors.black26,
                                          spreadRadius: 1,
                                          blurRadius: 6

                                      )]
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(imageData[index],width: 100,),

                                      Text(title[index],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),),

                                    ],
                                  ),
                                ),
                              );
                            }


                            //si l'utilisateur n'a pas le role charroi
                            if(index == 1){
                              return InkWell(
                                onTap: (){

                                  if(index==1){
                                    context.pushNamed(Urls.demande_encours.name);
                                  }


                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(
                                          color: Colors.black26,
                                          spreadRadius: 1,
                                          blurRadius: 6

                                      )]
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [

                                      Image.asset(imageData[index],width: 100,),
                                      Text("$nombre",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),),

                                      Text("Demandes en cours",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      Spacer()

                                    ],
                                  ),
                                ),
                              );
                            }

                            else if(index == 3){
                              return InkWell(
                                onTap: (){
                                  if(index==3){
                                    context.pushNamed(Urls.demandeTraite.name);
                                  }



                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(
                                          color: Colors.black26,
                                          spreadRadius: 1,
                                          blurRadius: 6

                                      )]
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(height: 19,),
                                      Image.asset(imageData[index],width: 100,),
                                      Text("$traiter",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),),

                                      Text("Demandes Traitées",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      Spacer()

                                    ],
                                  ),
                                ),
                              );
                            }


                            return InkWell(
                              onTap: (){
                                if(index==3){
                                  context.pushNamed(Urls.stat.name);
                                }
                                else if(index==2){
                                  context.pushNamed(Urls.listeDemandes.name);
                                }
                                else if(index==0){
                                  context.pushNamed(Urls.demande.name);
                                }



                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(
                                        color: Colors.black26,
                                        spreadRadius: 1,
                                        blurRadius: 6

                                    )]
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    Image.asset(imageData[index],width: 100,),

                                    Text(title[index],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),),

                                  ],
                                ),
                              ),
                            );
                          }
                      ),

                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,


                      ),
                      height: height*0.25,
                      width: width,
                      child: Column(
                        children: [
                          Text("Demandes Recentes",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),),
                          Expanded(child:_listedemande() )
                        ],
                      ),
                    )

                  ],

                ),




              ),

            )
            ]
        )
    );
  }

  AppBar _entete() {
    return AppBar(
      title: Center(child: Text("Accueil")),
      backgroundColor: Colors.orange,
      foregroundColor: Colors.black,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {

          },
          icon: Icon(Icons.sync),
        )
      ],
    );
  }

  Drawer _menu(){
    var state = ref.watch(accueilPageCtrlProvider);
    var res = state.user?.role;


    if( res != null && res.any((e) => e.contains('charroi'))){
      return Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.orange
                ),
                child: Text('Vrequest'),
              ),

              ListTile(
                title: TextButton(
                  onPressed: () {
                    context.pushNamed(Urls.accueil.name);
                  },
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,),
                  child: Text(
                    'Tableau de bord',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                leading: Icon(Icons.mouse_rounded),

              ),
              Divider(),
              ListTile(
                title: TextButton(
                  onPressed: () {
                    context.pushNamed(Urls.listeDemandes.name);
                  },
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,),
                  child: Text(
                    'Mes demandes',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                leading: Icon(Icons.save),

              ),
              Divider(),
              ListTile(
                title: TextButton(
                  onPressed: () {
                    context.goNamed(Urls.chatList.name);
                  },
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,),
                  child: Text(
                    'Chat',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                leading: Icon(Icons.chat),

              ),
              Divider(),
              ListTile(
                title: TextButton(
                  onPressed: () {
                    context.pushNamed(Urls.profil.name);
                  },
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,),
                  child: Text(
                    'Profil',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                leading: Icon(Icons.people),

              ),
              Divider(),
              ListTile(
                title: TextButton(
                  onPressed: () async{
                    var dis = ref.read(profilPageCtrlProvider.notifier);
                    var rep = await dis.disconnect();
                    if(rep){
                      while (context.canPop()) {
                        context.pop();
                      }
                      context.pushReplacement(Urls.home.name, );
                    }

                  },
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,),
                  child: Text(
                    'Deconnexion',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                leading: Icon(Icons.logout),

              ),
            ],
          )
      );
    }
    else if (res != null && res.any((e) => e.contains('chauffeur'))) {
      return Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.orange),
                child: Text('Vrequest'),
              ),
              ListTile(
                title: TextButton(
                  onPressed: () {
                    context.pushNamed(Urls.accueil.name);
                  },
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                  ),
                  child: Text(
                    'Tableau de bord',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                leading: Icon(Icons.mouse_rounded),
              ),
              Divider(),
              ListTile(
                title: TextButton(
                  onPressed: () {
                    context.pushNamed(Urls.listeDemandes.name);
                  },
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                  ),
                  child: Text(
                    'Mes demandes',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                leading: Icon(Icons.save),
              ),
              Divider(),
              ListTile(
                title: TextButton(
                  onPressed: () {
                    context.goNamed(Urls.chatList.name);
                  },
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                  ),
                  child: Text(
                    'Chat',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                leading: Icon(Icons.chat),
              ),
              Divider(),
              ListTile(
                title: TextButton(
                  onPressed: () {
                    context.pushNamed(Urls.profil.name);
                  },
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                  ),
                  child: Text(
                    'Profil',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                leading: Icon(Icons.people),
              ),
              Divider(),
              ListTile(
                title: TextButton(
                  onPressed: () async {
                    var dis = ref.read(profilPageCtrlProvider.notifier);
                    var rep = await dis.disconnect();
                    if(rep){
                      while (context.canPop()) {
                        context.pop();
                      }
                      context.pushReplacement(Urls.home.name, );
                    }

                  },
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                  ),
                  child: Text(
                    'Deconnexion',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                leading: Icon(Icons.logout),
              ),
            ],
          ));
    }
    else{
      return Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.orange
                ),
                child: Text('Vrequest'),
              ),

              ListTile(
                title: TextButton(
                  onPressed: () {

                  },
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,),
                  child: Text(
                    'Tableau de bord',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                leading: Icon(Icons.mouse_rounded),

              ),
              Divider(),
              ListTile(
                title: TextButton(
                  onPressed: () {
                    context.pushNamed(Urls.listeDemandes.name);
                  },
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,),
                  child: Text(
                    'Mes demandes',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                leading: Icon(Icons.save),

              ),

              Divider(),
              ListTile(
                title: TextButton(
                  onPressed: () {
                    context.pushNamed(Urls.profil.name);
                  },
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,),
                  child: Text(
                    'Profil',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                leading: Icon(Icons.people),

              ),
              Divider(),
              ListTile(
                title: TextButton(
                  onPressed: () async{
                    var dis = ref.read(profilPageCtrlProvider.notifier);
                    var rep = await dis.disconnect();
                    if(rep){
                      while (context.canPop()) {
                        context.pop();
                      }
                      context.pushReplacement(Urls.home.name, );
                    }
                  },
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,),
                  child: Text(
                    'Deconnexion',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                leading: Icon(Icons.logout),

              ),
            ],
          )
      );
    }


  }
  Widget _listedemande(){
    var state = ref.watch(accueilPageCtrlProvider);
    var motif = state.last;


    return ListView.builder(
        itemCount: motif.length,
        shrinkWrap: true,
        itemBuilder: (ctx, index){
          if(motif.isNotEmpty){
            return  ListTile(
              leading: Text("${index+1}",
                style: TextStyle(
                    fontSize: 18
                ),),
              title: Text("${motif[index]['motif']}",style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              )),
              subtitle: Text("${motif[index]['date']}"),
              trailing: Icon(Icons.arrow_right),
            );
          }

        }
    );
  }
}
