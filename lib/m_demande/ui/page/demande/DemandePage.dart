import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:odc_mobile_project/m_demande/business/model/Site.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:odc_mobile_project/m_demande/ui/page/map_page/MapCtrl.dart';
import 'package:odc_mobile_project/navigation/routers.dart';
import '../../../business/model/DemandeRequest.dart';
import '../../composant/MyTextField.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'DemandeCtrl.dart';

class DemandePage extends ConsumerStatefulWidget {
  const DemandePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DemandePageState();
}

class _DemandePageState extends ConsumerState<DemandePage> {
  DateTime _selectedDate = DateTime.now();
  var _date_ctrl = TextEditingController();
  var motif_ctrl = TextEditingController();
  int? index_switch = 0;
  var nbre_passagers_ctrl = TextEditingController();
  Site? lieuDepart;
  Site? destination;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // action initiale de la page et appel d'un controleur
      var ctrl = ref.read(demandeCtrlProvider.notifier);
      ctrl.recupereListSite();
      ctrl.getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Soumettre une demande",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          centerTitle: true,
          backgroundColor: Color(0xFFFF7900),
        ),
        body: SingleChildScrollView(child: _formulaire()),
      ),
    );
  }

  _formulaire() {
    var state = ref.watch(demandeCtrlProvider);
    var state2 = ref.watch(mapCtrlProvider);
    var lieuDepart_ctrl = TextEditingController(text: state2.lieuDepart?.nom);
    var destination_ctrl = TextEditingController(text: state2.destnation?.nom);
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        child: Column(
          children: [
            Text(
              "Formulaire de la course",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 35,
            ),
            MyTextField(
              ctrl: motif_ctrl,
              hint: "Quel est le motif de la course",
              label: "Motif*",
              icon: Icons.abc,
            ),
            SizedBox(
              height: 30,
            ),
            MyTextField(
              type: TextInputType.datetime,
              ctrl: _date_ctrl,
              hint: "La date de la course",
              label: 'Date du deplacement',
              icon: Icons.date_range,
              readOnly: true,
              selectDate: () => _selectDate(context),
            ),
            SizedBox(
              height: 30,
            ),
            MyTextField(
              type: TextInputType.number,
              ctrl: nbre_passagers_ctrl,
              hint: "Nombres des passagers de la course",
              label: "Nombre de passagers*",
              icon: Icons.numbers,
            ),
            SizedBox(
              height: 30,
            ),
            _buttonSwitch(),
            SizedBox(
              height: 10,
            ),
            if (state.switchCarte)
              _selectLieu("depart", 'Sélétionnez le lieu de départ'),
            SizedBox(
              height: 10,
            ),
            if (state.switchCarte)
              _selectLieu("destination", 'Sélétionnez la déstination'),
            if (!state.switchCarte)
              ElevatedButton.icon(
                onPressed: () {
                  context.pushNamed(Urls.carte.name);
                },
                label: Text(
                  "Afficher la carte",
                  style: TextStyle(fontSize: 20),
                ),
                icon: Icon(Icons.map),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Color(0xFFFF7900),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            if (!state.switchCarte)
            SizedBox(
              height: 15,
            ),
            if (!state.switchCarte)
            MyTextField(
                ctrl: lieuDepart_ctrl,
                hint: "Lieu du départ",
                label: "Départ",
                icon: Icons.map,
            readOnly: true,),
            if (!state.switchCarte)
            SizedBox(
              height: 15,
            ),
            if (!state.switchCarte)
            MyTextField(
                ctrl: lieuDepart_ctrl,
                hint: "Déstination",
                label: "Déstination",
                icon: Icons.map,
            readOnly: true,),
            SizedBox(
              height: 55,
            ),
            if (state.isLoading)
              CircularProgressIndicator(
                color: Color(0xFFFF7900),
                strokeWidth: 5,
              ),
            if (!state.isLoading)
              ElevatedButton.icon(
                onPressed: () {
                  if(!state.switchCarte){
                    lieuDepart = state2.lieuDepart;
                    destination = state2.destnation;
                  }
                  _submit(DemandeRequest(
                      motif: motif_ctrl.text ?? "",
                      ticket: _genererTicket(),
                      dateDeplacement: _selectedDate,
                      nbrePassagers: nbre_passagers_ctrl.text != ''
                          ? int.parse(nbre_passagers_ctrl.text)
                          : 0,
                      userId: state.user!.id,
                      managerId: state.user!.manager!.id,
                      lieuDepart: lieuDepart != null ? lieuDepart!.nom : "",
                      latitudeDepart:
                          lieuDepart != null ? lieuDepart!.latitude : 0.00,
                      longitudeDepart:
                          lieuDepart != null ? lieuDepart!.longitude : 0.00,
                      destination: destination != null ? destination!.nom : "",
                      latitudeDestination:
                          destination != null ? destination!.latitude : 0.00,
                      longitudeDestination:
                          destination != null ? destination!.longitude : 0.00,
                      date: DateTime.now()));
                },
                label: Text(
                  "Envoyer",
                  style: TextStyle(fontSize: 20),
                ),
                icon: Icon(Icons.send),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Color(0xFFFF7900),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
      );

      setState(() {
        _selectedDate = picked;
        if (selectedTime != null) {
          _selectedDate = DateTime(
            _selectedDate.year,
            _selectedDate.month,
            _selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
        }

        print(_selectedDate);
        _date_ctrl.text =
            DateFormat('EEEE, dd-MM-yyyy H:m').format(_selectedDate);
      });
    }
  }

  _submit(DemandeRequest data) async {
    var ctrl = ref.read(demandeCtrlProvider.notifier);
    if(data.lieuDepart == data.destination){
      _toast("La déstination ne doit pas être égal au départ veillez changer des lieux", Colors.red);
    }else{
      var reponse = await ctrl.demandeByForm(data);

      if (reponse == true) {
        context.goNamed(Urls.listeDemandes.name);
        _toast("Démande soumise avec succès", Colors.green);
      } else {
        _toast("Erreur veillez réessayer et remplir tous les champs", Colors.red);
      }
    }

  }

  _selectLieu(String lieu, String hint) {
    var state = ref.watch(demandeCtrlProvider);
    final List<Site> _site = state.site;

    return DropdownButtonFormField<Site>(
      value: lieu == "depart" ? lieuDepart : destination,
      onChanged: (Site? newValue) {
        setState(() {
          if (lieu == "depart") {
            lieuDepart = newValue;
            print(lieuDepart!.nom);
          } else {
            destination = newValue;
            print(destination!.nom);
          }
        });
      },
      items: _site.map<DropdownMenuItem<Site>>((Site site) {
        return DropdownMenuItem<Site>(
          value: site,
          child: Row(
            children: [
              Icon(Icons.location_on, color: Colors.black, size: 24),
              SizedBox(width: 8),
              Text(
                site.nom,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        );
      }).toList(),
      style: TextStyle(color: Colors.blue, fontSize: 18),
      hint: Text(hint),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFFF7900), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFFF7900), width: 1.5),
        ),
      ),
      padding: EdgeInsets.all(2.0),
      dropdownColor: Color(0xFFFF7900),
    );
  }

  _toast(String msg, color) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        backgroundColor: color,
        fontSize: 16.0);
  }

  _buttonSwitch() {
    var ctrl = ref.read(demandeCtrlProvider.notifier);
    return Container(
      child: // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
          Column(
        children: [
          Text(
            "Choisir un lieu",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ToggleSwitch(
            initialLabelIndex: index_switch,
            inactiveBgColor: Colors.grey,
            inactiveFgColor: Colors.grey[900],
            totalSwitches: 2,
            labels: ['Sur la liste', 'Sur la carte'],
            radiusStyle: true,
            onToggle: (i) {
              ctrl.switchCarte(i);
              index_switch = i;
              print("index choisie est $i");
            },
            minWidth: double.infinity,
            fontSize: 16,
            activeBgColor: [Color(0xFFFF7900)],
            activeFgColor: Colors.black,
          ),
        ],
      ),
    );
  }

  _genererTicket() {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    return getRandomString(12);
  }
}
