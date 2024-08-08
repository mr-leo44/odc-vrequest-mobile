import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';

class MyAutoCompletion extends StatelessWidget {
  String apiKey;
  String label;
  IconData icon;
  final _textController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  MyAutoCompletion({super.key, required this.apiKey, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: GooglePlacesAutoCompleteTextFormField(
        textEditingController: _textController,
        googleAPIKey: apiKey,
        decoration: InputDecoration(
          focusColor: Colors.white,
          suffixIcon: IconButton(onPressed: () {
            print("okay");
          },
            icon: Icon(Icons.location_searching_sharp,),
            iconSize: 25,
            
          ),
          prefixIcon: Icon(icon),
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
          labelText: '$label',
          //lable style
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Entrez du texte';
          }
          return null;
        },
        maxLines: 1,
        overlayContainer: (child) => Material(
          elevation: 1.0,
          color: Colors.orange,
          borderRadius: BorderRadius.circular(10.0),
          child: child,
        ),
        getPlaceDetailWithLatLng: (prediction) {
          print('placeDetails${prediction.lng}');
        },
        itmClick: (Prediction prediction) =>
            _textController.text = prediction.description!,
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('hint', label));
  }
}
