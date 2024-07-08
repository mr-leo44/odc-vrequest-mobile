import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odc_mobile_project/m_user/ui/pages/compte/CompteProfilPageCtrl.dart';
import 'package:odc_mobile_project/m_user/ui/pages/profil/ProfilPageState.dart';
import '../profil/ProfilPageCtrl.dart';


class CompteProfilPage extends ConsumerStatefulWidget{
  @override
  ConsumerState createState() => _CompteProfilPageState();

}

class _CompteProfilPageState extends ConsumerState<CompteProfilPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // action initiale de la page et appel d'un controleur
      var ctrl = ref.read(compteProfilPageCtrlProvider.notifier);
      ctrl.getUser();

    });
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Center(child: Text("Compte")),
       backgroundColor: Colors.orange,
       foregroundColor: Colors.black,
       elevation: 0,
       actions: [
         IconButton(
           onPressed: () {},
           icon: Icon(Icons.sync),
         )
       ],
     ),
     body: Column(
       children: [
         SizedBox(height: 30,),
         Center(
            child: CircleAvatar(
            radius: 50.0,
            backgroundImage: NetworkImage(
           'https://static.vecteezy.com/system/resources/thumbnails/012/986/755/small/abstract-circle-logo-icon-free-png.png'),
     ),
   ),
         SizedBox(height: 30,),
         _card()
       ],
     ),
   );
  }
  Widget _card(){
    var state = ref.watch(profilPageCtrlProvider);
    var username = state.user?.username ?? "";
    var prenom = state.user?.prenom ?? "";
    var nom = state.user?.nom ?? "";

    var email = state.user?.email ?? "";
    var phone = state.user?.phone ?? "";
    var email_manager = state.user?.manager?.email?? "";
    return Card(
      child: Column(
        children: [

          ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(username,
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text('username'),
            ),
            leading: Icon(Icons.person),

          ),

          Divider(),

          ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(prenom,
              style: TextStyle(
              fontWeight: FontWeight.bold),
            )),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text('firstname'),
            ),
            leading: Icon(Icons.person_4),

          ),
          Divider(),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(nom,
                  style: TextStyle(
                  fontWeight: FontWeight.bold),
            )),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text('lastname'),
            ),
            leading: Icon(Icons.person),

          ),

          Divider(),

          ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(email,
    style: TextStyle(
    fontWeight: FontWeight.bold),
            )),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text('email'),
            ),

            leading: Icon(Icons.mail),

          ),
          Divider(),

          ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(phone,
              style: TextStyle(
    fontWeight: FontWeight.bold),
            )),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text('phone'),
            ),
            leading: Icon(Icons.phone),

          ),
          ListTile(
            title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(email_manager,
                  style: TextStyle(
                      fontWeight: FontWeight.bold),
                )),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text('email_manager'),
            ),

            leading: Icon(Icons.mail),

          ),
        ],
      ),
    );
  }
}
