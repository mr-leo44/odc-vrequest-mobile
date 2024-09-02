import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_demande/ui/composant/MyListTile.dart';
import 'package:odc_mobile_project/navigation/routers.dart';

import 'DemandeEnCoursCtrl.dart';

class DemandeEnCoursPage extends ConsumerStatefulWidget {
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
    var state = ref.watch(demandeEnCoursCtrlProvider);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          "(${state.nbrDemande}) Demandes en cours",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFFF7900),
        actions: [
          IconButton(
              onPressed: () {
                var ctrl = ref.read(demandeEnCoursCtrlProvider.notifier);
                ctrl.nombreDemande();
              },
              icon: Icon(
                Icons.refresh_sharp,
                size: 30,
              )),
          IconButton(
              onPressed: () {
                context.pushNamed(Urls.demande.name);
              },
              icon: Icon(
                Icons.add,
                size: 30,
              ))
        ],
      ),
      body: Stack(
        children: [
          if (!state.visible) _contenuPrincipal(context, ref),
          _chargement(context, ref)
        ],
      ),);
  }

  _contenuPrincipal(BuildContext context, WidgetRef ref) {
    var state = ref.watch(demandeEnCoursCtrlProvider);
    List<Demande> demande = state.listDemandesSearch;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 25, left: 25, top: 25),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Rechercher',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              suffixIcon: Icon(Icons.search),
            ),
            onChanged: (e){
              var ctrl = ref.read(demandeEnCoursCtrlProvider.notifier);
              ctrl.filtre(e);
            },
          ),
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 35),
              child: (state.notFound) ? ListView.separated(
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
              ) : Center(
                child: Text("Aucune demande correspondante", style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400
                ),),
              ) ,
          ),
        ),
      ],
    );
  }

  _chargement(BuildContext context, WidgetRef ref) {
    var state = ref.watch(demandeEnCoursCtrlProvider);

    return Visibility(
        visible: state.visible,
        child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(state.isLoading)
                    CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  if(state.isLoading)
                    Text(
                      "Chargement...",
                      style: TextStyle(fontSize: 18.0),
                      textAlign: TextAlign.center,
                    ),
                  if(state.isEmpty)
                    Text(
                      "Aucune demande trouvée veillez rafraichir la page",
                      style: TextStyle(fontSize: 18.0),
                      textAlign: TextAlign.center,
                    )
                ],
              ),
            )));
  }
}
