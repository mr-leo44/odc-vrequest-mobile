import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/ChatPage.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_demande/ui/page/details_demande_page/DetailsDemandeCtrl.dart';
import 'package:odc_mobile_project/m_demande/ui/page/details_demande_page/DetailsDemandePageMap.dart';
import 'package:odc_mobile_project/navigation/routers.dart';
import 'package:odc_mobile_project/utils/colors.dart';

class DetailsDemandePage extends ConsumerStatefulWidget {
  final int id;

  const DetailsDemandePage({super.key, required this.id});

  @override
  ConsumerState createState() => _DetailsDemandePageState();
}

class _DetailsDemandePageState extends ConsumerState<DetailsDemandePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var ctrl = ref.read(detailsDemandeCtrlProvider.notifier);
      ctrl.recupererDemande(widget.id);
      ctrl.getMessages(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(detailsDemandeCtrlProvider);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          "Ma Demande",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                var ctrl = ref.watch(detailsDemandeCtrlProvider.notifier);
                ctrl.recupererDemande(widget.id);
              },
              icon: Icon(
                Icons.refresh_sharp,
                size: 30,
              )),
        ],
        backgroundColor: Couleurs.primary,
      ),
      body: Stack(
        children: [
          if (state.demande != null && !state.isLoading)
            _contenuPrincipale(context, ref),
          _chargement(context, ref)
        ],
      ),
    );
  }

  _contenuPrincipale(BuildContext context, WidgetRef ref) {
    var state = ref.watch(detailsDemandeCtrlProvider);
    var demande = state.demande;
    var dateDeplacement = demande?.dateDeplacement;
    var date = demande?.dateDemande;
    var size = MediaQuery.of(context).size;
    var screenWidth = size.width;

    print("demande ${demande?.motif}");

    var chatUsersModel = state.chatsUsers;

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.00),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${dateDeplacement!.day.toString().padLeft(2, '0')}-${dateDeplacement.month.toString().padLeft(2, '0')}-${dateDeplacement.year.toString().padLeft(4, '0')}",
                  style:
                      TextStyle(fontSize: 22.00, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Date de la course",
                  style: TextStyle(fontSize: 20.00),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text("Carte"),
              Container(
                child: DetailsDemandePageMap(
                  demande: demande,
                ),
              )
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.00),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${demande!.initiateur!.prenom} ${demande.initiateur!.nom}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            Text("${demande.ticket}")
                          ],
                        ),
                        Image.asset(
                          "images/voiture.png",
                          width: 50,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    ElevatedButton.icon(
                      onPressed: demande.status != '1' ? null : () {},
                      label: Text("Envoyer un message"),
                      icon: Icon(Icons.send),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF7900),
                          foregroundColor: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Détails de la demande",
                      style: TextStyle(
                          fontSize: 18.00, fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${date!.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(4, '0')}\n${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}",
                          style: TextStyle(
                              fontSize: 16.00, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "Date de la demande",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            demande.motif,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            style: TextStyle(
                                fontSize: 16.00, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Text(
                          "Motif",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${demande.nbrePassagers} passagers",
                      style: TextStyle(
                          fontSize: 16.00, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${_jourEnLettre(dateDeplacement!.weekday)}\n${dateDeplacement.day.toString().padLeft(2, '0')}-${dateDeplacement.month.toString().padLeft(2, '0')}-${dateDeplacement.year.toString().padLeft(4, '0')}\n${dateDeplacement.hour.toString().padLeft(2, '0')}:${dateDeplacement.minute.toString().padLeft(2, '0')}",
                          style: TextStyle(
                              fontSize: 16.00, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "Date de la course",
                          style: TextStyle(fontSize: 16.00),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${_getStatus(demande.status)}", style: TextStyle(
                          color: demande.status != '1' ? Colors.grey : Colors.green, fontWeight: FontWeight.w400, fontSize: 16.00
                        ),),
                        Text("status", style: TextStyle(fontSize: 16.00),)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.5, right: 16.5, bottom: 10),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: demande.status != '1'
                    ? () {
                        var ctrl =
                            ref.read(detailsDemandeCtrlProvider.notifier);
                        ctrl.annulerDemande(widget.id);
                        context.goNamed(Urls.listeDemandes.name);
                      }
                    : null,
                child: Text("Annuler"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getStatus(String status) {
    switch (status.toLowerCase()) {
      case '0':
        return "En attente";
      case '1':
        return "Traitée";
      default:
        return 'En attente';
    }
  }

  String _jourEnLettre(int i) {
    var jours = [
      "Lundi",
      "Mardi",
      "Mercredi",
      "Jeudi",
      "Vendredi",
      "Samedi",
      "Dimanche"
    ];

    return jours[i - 1];
  }

  _chargement(BuildContext context, WidgetRef ref) {
    var state = ref.watch(detailsDemandeCtrlProvider);

    return Visibility(
        visible: state.isLoading,
        child: Center(child: CircularProgressIndicator()));
  }

  _lieuInfo(lieu, label) {
    return Row(
      children: [
        Icon(Icons.location_on),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Text(
                  "$lieu",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
                child: Text(
                  "$label",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
