import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odc_mobile_project/m_user/ui/pages/compte/CompteProfilPageCtrl.dart';
import 'package:odc_mobile_project/m_user/ui/pages/profil/ProfilPageCtrl.dart';
import 'package:odc_mobile_project/navigation/routers.dart';

class AccueilPage extends ConsumerStatefulWidget {
  const AccueilPage({super.key});

  @override
  ConsumerState createState() => _AccueilPageState();
}


class _AccueilPageState extends ConsumerState<AccueilPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // action initiale de la page et appel d'un controleur
      var ctrl = ref.read(profilPageCtrlProvider.notifier);
      ctrl.getUser();

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _enteteProfil(),

      drawer: _menuPrincipale(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          ],
        ),
      ),
    );
  }

  AppBar _enteteProfil() {
    return AppBar(
      title: Center(child: Text("Accueil")),
      backgroundColor: Colors.orange,
      foregroundColor: Colors.black,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.sync),
        )
      ],
    );
  }



  Drawer _menuPrincipale(){
    var state = ref.watch(profilPageCtrlProvider);
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
                    context.goNamed(Urls.profil.name);
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
                      context.goNamed(Urls.auth.name);
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
                    context.goNamed(Urls.profil.name);
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
                      context.goNamed(Urls.home.name);
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




}
