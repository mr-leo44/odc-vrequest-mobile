


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'DemandeEnCoursCtrl.dart';

class DemandeEnCoursPage extends ConsumerStatefulWidget{

  @override
  ConsumerState<DemandeEnCoursPage> createState() => _DemandeEnCoursPage();
}

class _DemandeEnCoursPage extends ConsumerState<DemandeEnCoursPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // action initiale de la page et appel d'un controleur
      var ctrl = ref.read(demandeEnCoursCtrlProvider.notifier);
      ctrl.nombreDemande();



    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: _entete(),

        body: Column(
          children: [
            Expanded(child: _listedemande()),
          ],
        )
    );
  }

  AppBar _entete() {
    return AppBar(
      title: Center(child: Text("Demande en cours")),
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
  Widget _listedemande(){
    var state = ref.watch(demandeEnCoursCtrlProvider);
    var motif = state.demande["demandes_encours"];
    var taille = state.demande['demande_encours'];




    return ListView.builder(
        itemCount: taille,
        shrinkWrap: true,
        itemBuilder: (ctx, index){
          if(motif != null && motif.isNotEmpty){
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