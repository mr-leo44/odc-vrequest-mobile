import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odc_mobile_project/m_demande/business/interactor/demandeInteractor.dart';

import 'package:odc_mobile_project/m_user/ui/pages/accueil/AccueilPageCtrl.dart';

import '../../../../../navigation/routers.dart';
import 'StatCtrl.dart';


class StatPage extends ConsumerStatefulWidget{

  @override
  ConsumerState<StatPage> createState() => _StatPage();
}

class _StatPage extends ConsumerState<StatPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // action initiale de la page et appel d'un controleur
      var ctrl = ref.read(statCtrlProvider.notifier);

      ctrl.nombreDemande();
      ctrl.getUser();

    });
  }
  var height,width;

  List imageData = [

    "images/encours.png",
    "images/valide.png",

    "images/voiture.png",
    "images/car.png",
  ];



  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: _entete(),

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
                      height: height*0.1,
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
                                Text("Statistiques ",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                  ),),
                                SizedBox(height: 5,),

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
                      height: height*0.85,
                      width: width,
                      child: Column(
                        children: [
                          GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.1,
                                  mainAxisSpacing: 20
                              ),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 4,
                              itemBuilder: (context, index){

                                var state = ref.watch(accueilPageCtrlProvider);
                                var res = state.user?.role;
                                if( !(res != null && res.any((e) => e.contains('charroi')))){
                                  if(index == 2){
                                    return SizedBox.shrink();
                                  }
                                  else if(index == 3){
                                    return SizedBox.shrink();
                                  }

                                }
                                var encours = state.nombre["demande_encours"];
                               // var total = state.nombre["demande_total"];
                                var valider = state.nombre["demande_traite"];
                                var vehicule_dispo = state.nombre["Vehicule_disponible"];
                                var vehicule_indispo = state.nombre["Vehicule_nondispo"];
                                //var vehicule_total = state.nombre["Vehicule_total"];
                                List tab = [
                                  //total,
                                  encours,
                                  valider,
                                  vehicule_dispo,
                                  vehicule_indispo,
                                  //vehicule_total

                                ];
                                List noms = [
                                  //"Total",
                                  "Encours",
                                  "Validée",
                                  "disponible",
                                  "indisponible",
                                  //"total"
                                ];
                                List entete = [
                                  "demande",
                                  "demande",
                                  "véhicule",
                                  "véhicule"
                                ];

                                return InkWell(
                                  onTap: (){},
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
                                        Text(entete[index]),
                                       Image.asset(imageData[index],width: 100,),

                                        Text("${tab[index]} ${noms[index]}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),),

                                      ],
                                    ),
                                  ),
                                );
                              }

                          ),

                        ],
                      ),


                    ),


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
      title: Center(child: Text("Stat demande")),
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

 }