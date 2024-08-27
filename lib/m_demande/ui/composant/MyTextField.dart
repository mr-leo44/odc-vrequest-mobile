import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  TextInputType type;
  TextEditingController ctrl;
  String hint;
  String label;
  IconData icon;
  bool readOnly;
  dynamic selectDate;

  MyTextField(
      {super.key,
      this.type = TextInputType.text,
      required this.ctrl,
      required this.hint,
      required this.label,
      required this.icon,
      this.readOnly = false,
      this.selectDate = null});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: type,
        controller: ctrl,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        onChanged: (value) {},
        decoration: InputDecoration(
          focusColor: Colors.white,
          //add prefix icon
          prefixIcon: Icon(icon),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Color(0xFFFF7900), width: 2.0),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFFF7900), width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),

          hintText: "$hint",

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
      readOnly: readOnly,
      onTap: (){
        selectDate();
      },
    );
  }
}


