import 'package:flutter/material.dart';
import 'package:odc_mobile_project/utils/widgets/widgets.dart';

class RoundedInputField extends StatelessWidget {
  RoundedInputField({Key? key, this.hintText, this.icon = Icons.person, required this.controller})
      : super(key: key);
  final String? hintText;
  final IconData icon;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
                  controller: controller,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: Colors.grey,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(fontFamily: 'OpenSans'),
            border: InputBorder.none),
      ),
    );
  }
}
