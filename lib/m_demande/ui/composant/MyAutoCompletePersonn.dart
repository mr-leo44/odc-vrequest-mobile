import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_async_autocomplete/flutter_async_autocomplete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:odc_mobile_project/m_demande/business/model/Personn.dart';
import 'package:odc_mobile_project/m_demande/ui/page/demande/DemandeCtrl.dart';

import '../../api/api_autocomplete_open_map_street.dart';
import '../../business/model/Site.dart';

class MyAutoCompletePersonn extends ConsumerStatefulWidget {
  final String label;
  final IconData icon;
  Function(Personn personn) onTap;
  TextEditingController autoController;

  MyAutoCompletePersonn(
      {Key? key,
        required this.autoController,
        required this.icon,
        required this.label,
        required this.onTap,})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAutoCompletePersonnState();
}

class _MyAutoCompletePersonnState extends ConsumerState<MyAutoCompletePersonn> {
  var key = GlobalKey();
  String selectedLocation = "";

  Future<List<Personn>> getResult(search) async {
    List<Personn> result = [];

    var ctrl = ref.read(demandeCtrlProvider.notifier);
    result = await ctrl.getNameUser(search);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return AsyncAutocomplete<Personn>(
      controller: widget.autoController,
      inputKey: key,
      onTapItem: (Personn personn) {
        setState(() {
          widget.autoController.text = personn.nom;
       });
        widget.onTap(personn);
      },
      suggestionBuilder: (data) => ListTile(
        title: Text(data.nom),
        subtitle: Text(data.nom),
      ),
      asyncSuggestions: (searchValue) => getResult(searchValue),
      decoration: InputDecoration(
        focusColor: Colors.white,
        prefixIcon: Icon(widget.icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(width: 2.0),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),

        hintText: "Entrez un nom",

        //make hint text
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontFamily: "verdana_regular",
          fontWeight: FontWeight.w400,
        ),

        //create lable
        labelText: widget.label,
        //lable style
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: "verdana_regular",
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
