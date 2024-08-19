import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_async_autocomplete/flutter_async_autocomplete.dart';
import 'package:http/http.dart' as http;

import '../../api/api_autocomplete_open_map_street.dart';
import '../../business/model/Site.dart';

class MyAutoCompleteLocation extends StatefulWidget {
  final String label;
  final IconData icon;
  Function(Site location) onTap;
  Function(int num) mouvement;
  TextEditingController autoController;
  int num;

  MyAutoCompleteLocation(
      {Key? key,
      required this.autoController,
      required this.icon,
      required this.label,
      required this.onTap,
      required this.mouvement,
      required this.num})
      : super(key: key);

  @override
  State<MyAutoCompleteLocation> createState() => _MyAutoCompleteLocationState();
}

class _MyAutoCompleteLocationState extends State<MyAutoCompleteLocation> {
  var key = GlobalKey();
  String selectedLocation = "";

  Future<List<Site>> getResult(search) async {
    var response = await http.get(getRouteUrl(search));
    List<Site> result = [];

    if (response.statusCode == 200) {
      print("Suucces " + response.body);
      var data = jsonDecode(response.body);

      data
          .map(
            (p) => result.add(Site(
                nom: p["display_name"],
                latitude: double.parse(p["lat"]),
                longitude: double.parse(p["lon"]))),
          )
          .toList();

      await Future.delayed(const Duration(microseconds: 500));
    } else {
      print("Error " + response.body);
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return AsyncAutocomplete<Site>(
      controller: widget.autoController,
      inputKey: key,
      onTapItem: (Site location) {
        setState(() {
          selectedLocation =
              "selected item : Lat (${location.latitude}), Lon (${location.longitude})";
        });
        widget.onTap(location);
      },
      suggestionBuilder: (data) => ListTile(
        title: Text(data.nom),
        subtitle: Text(data.nom),
      ),
      asyncSuggestions: (searchValue) => getResult(searchValue),
      decoration: InputDecoration(
        focusColor: Colors.white,
        suffixIcon: IconButton(
          onPressed: () {
            int numero = widget.num;
            widget.mouvement(numero);
            print("le nouveau mouvement est : $numero");
          },
          icon: Icon(
            Icons.location_searching_sharp,
          ),
          iconSize: 25,
        ),
        prefixIcon: Icon(widget.icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.orange, width: 2.0),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orange, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),

        hintText: "Entrez une adresse",

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
