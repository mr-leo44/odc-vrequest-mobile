import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odc_mobile_project/m_user/ui/pages/compte/CompteProfilPageCtrl.dart';
import 'package:odc_mobile_project/m_user/ui/pages/profil/ProfilPageCtrl.dart';
import 'package:odc_mobile_project/navigation/routers.dart';

class Profilpage extends ConsumerStatefulWidget {
  const Profilpage({super.key});

  @override
  ConsumerState createState() => _TestpageState();
}


class _TestpageState extends ConsumerState<Profilpage> {

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


      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Center(child: photoProfil()),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0,),
              child: _infoProfil(),
            ),
            SizedBox(height: 40,),
            _card(),
            SizedBox(height: 40,),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  AppBar _enteteProfil() {
    return AppBar(
      title: Center(child: Text("Profil")),
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

  Widget photoProfil() {
    return Center(
      child: CircleAvatar(
        radius: 50.0,
        backgroundImage: NetworkImage(
            'https://static.vecteezy.com/system/resources/thumbnails/012/986/755/small/abstract-circle-logo-icon-free-png.png'),
      ),
    );
  }

  Widget _infoProfil() {
    var state = ref.watch(profilPageCtrlProvider);
    // var res = ctrl.getUser();
    var nom = state.user?.username ?? "" ;// res.name;
    var email =state.user?.email ?? "" ;// res.email;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Text(nom)),
        SizedBox(height: 8.0),
        Center(child: Text(email)),
      ],
    );
  }



  Widget _card(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Column(
          children: [

            ListTile(
              title: TextButton(
                onPressed: () {
                  context.goNamed(Urls.compte.name);
                },
              style: TextButton.styleFrom(
              alignment: Alignment.centerLeft,),
                child: Text(
                  'Mon compte',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ),
              leading: Icon(Icons.people),
              trailing: Icon(Icons.arrow_right),
            ),

            Divider(),

            ListTile(
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text("Synchroniser"),
              ),
              leading: Icon(Icons.sync),

            ),


            Divider(),

            ListTile(
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text("Version 1.0"),
              ),
              leading: Icon(Icons.dock),

            ),
          ],
        ),
      ),
    );

  }
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () async{
           var dis = ref.read(profilPageCtrlProvider.notifier);
           var rep = await dis.disconnect();
           if(rep){
             context.goNamed(Urls.auth.name);
           }

          },
          child: Text('Se déconnecter'),
        ),
      ],
    );
  }

}
