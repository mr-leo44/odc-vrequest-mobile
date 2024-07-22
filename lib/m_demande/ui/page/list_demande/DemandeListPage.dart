import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // action initiale de la page et appel d'un controleur
      var ctrl = ref.read(demandeListCtrlProvider.notifier);
      ctrl.recupererListDemande();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listes des demandes"
          , style:Theme.of(context).textTheme.titleLarge,),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Stack(
        children: [_contenuPrincipale(context, ref), _chargement(context, ref)],
      ),

    );
  }



  _contenuPrincipale(BuildContext context, WidgetRef ref) {
    var state = ref.watch(demandeListCtrlProvider);

   List<Demande> _demandes = state.listDemandes;


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
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 35),
            child: ListView.separated(
              itemCount: _demandes.length,
              itemBuilder: (ctx, index) {
                var demande = _demandes[index];
                return SizedBox(
                  height: 100,
                  child: Card(
                    shadowColor: Colors.black,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      title: Text(
                        demande.motif,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headlineSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      leading: Icon(Icons.map),
                      subtitle: Text(
                        DateFormat('dd/MM/yyyy - HH:mm')
                            .format(demande.dateDeplacement),
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium,
                      ),
                      trailing: Icon(Icons.chevron_right,
                        size: 30,
                        color: Colors.black,),
                      /*onTap: () {
                      context.pushNamed(Urls.detailsDemande.name, pathParameters: {
                        'id':demande.id.toString()
                      });
                       },*/
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10.0,
                );
              },
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
        child: Center(child: CircularProgressIndicator()));
  }
}


