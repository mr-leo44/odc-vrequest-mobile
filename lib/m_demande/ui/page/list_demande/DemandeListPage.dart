import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
        title: Text(
          "Listes des demandes",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
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
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      leading: Icon(Icons.map),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Status:"),
                              Text("${demande.status}",
                                  style: TextStyle(
                                      color: _getStatusColor(demande.status)))
                            ],
                          ),
                          Text(
                              DateFormat('dd/MM/yyyy - HH:mm')
                                  .format(demande.dateDeplacement),
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        size: 30,
                        color: Colors.black,
                      ),
                      onTap: () {
                        context.pushNamed(Urls.detailsDemande.name,
                            extra: demande,
                            pathParameters: {"id": demande.id.toString()});
                      },
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

  Color _getStatusColor(String status) {
    print(status.toLowerCase());
    switch (status.toLowerCase()) {
      case ' en attente':
        return Colors.orange;
      case 'achevé':
        return Colors.green;
      case 'raté':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
