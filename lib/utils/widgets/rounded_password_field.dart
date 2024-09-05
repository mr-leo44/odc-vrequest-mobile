import 'package:flutter/material.dart';
import 'package:odc_mobile_project/utils/widgets/widgets.dart';

class RoundedPasswordField extends StatelessWidget {
  RoundedPasswordField({
    Key? key,
    required this.password,
    required this.obscureText,
    required this.obscure,
  }) : super(key: key);
  TextEditingController password;
  bool obscureText;
  void Function() obscure;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: password,
        obscureText: this.obscureText,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            icon: Icon(
              Icons.lock,
              color: Colors.grey,
            ),
            hintText: "Mot de passe",
            hintStyle: TextStyle(fontFamily: 'OpenSans'),
            suffixIcon: IconButton(
                onPressed: () {
                  this.obscure();
                },
                icon: (this.obscureText)
                    ? Icon(
                        Icons.visibility,
                        color: Colors.grey,
                      )
                    : Icon(
                        Icons.visibility_off,
                        color: Colors.grey,
                      )),
            border: InputBorder.none),
      ),
    );
  }
}
