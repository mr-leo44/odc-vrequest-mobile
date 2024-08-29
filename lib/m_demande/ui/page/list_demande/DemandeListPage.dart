import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:odc_mobile_project/m_demande/ui/composant/MyListTile.dart';
import '../../../../navigation/routers.dart';
import '../../../business/model/Demande.dart';
import 'DemandeListCtrl.dart';

class DemandeListPage extends ConsumerStatefulWidget {
  const DemandeListPage({super.key});

  @override
  ConsumerState createState() => _DemandeListPageState();
}

class _DemandeListPageState extends ConsumerState<DemandeListPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // action initiale de la page et appel d'un controleur
      var ctrl = ref.read(demandeListCtrlProvider.notifier);
      ctrl.recupererListDemande();
    });
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(demandeListCtrlProvider);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          "(${state.nbreDemande}) Demandes",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFFF7900),
        actions: [
          IconButton(
              onPressed: () {
                var ctrl = ref.read(demandeListCtrlProvider.notifier);
                ctrl.recupererListDemande();
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
          if (!state.isEmpty) _contenuPrincipale(context, ref),
          _chargement(context, ref)
        ],
      ),
    );
  }

  _contenuPrincipale(BuildContext context, WidgetRef ref) {
    var state = ref.watch(demandeListCtrlProvider);

    List<Demande> _demandes = state.listDemandesSearch;

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
              var ctrl = ref.read(demandeListCtrlProvider.notifier);
              ctrl.filtre(e);
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 35),
            child: (state.notFound) ? ListView.separated(
              itemCount: _demandes.length,
              itemBuilder: (ctx, index) {
                var demande = _demandes[index];
                return MyListTile(demande: demande);
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
            ),
          ),
        ),
      ],
    );
  }

  _chargement(BuildContext context, WidgetRef ref) {
    var state = ref.watch(demandeListCtrlProvider);

    return Visibility(
        visible: state.isLoading,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 10,
              ),
              Text(
                "Aucune demande pour l'instant veillez rafraichir la page",
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
              )
            ],
          ),
        )));
  }
}
