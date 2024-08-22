import 'dart:async';

import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odc_mobile_project/m_user/ui/pages/login/LoginCtrl.dart';
import 'package:odc_mobile_project/m_user/ui/pages/profil/ProfilPageCtrl.dart';
import 'package:odc_mobile_project/navigation/routers.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  var email=TextEditingController(text: "sjayes0");
  var password=TextEditingController(text: "123456");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // action initiale de la page et appel d'un controleur
      var ctrl = ref.read(loginCtrlProvider.notifier);
      ctrl.readLocalToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [_contenuPrincipale(context), _chargement(context)],
      ),
    );
  }

  _contenuPrincipale(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(),
            child: Image.asset("images/login.png"),
            width: 300,
          ),

          SizedBox(height: 20,),
          Text("Authentification",
            style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 25
            ),),
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: email,
              decoration: InputDecoration(label: Text("Email"),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange, // Définir la couleur de la bordure
                      width: 2.0, // Définir l'épaisseur de la bordure
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange, // Définir la couleur de la bordure lorsque le TextField est en focus
                      width: 2.0,
                    ),
                  ),

                  prefixIcon: Icon(Icons.verified_user)),
            ),
          ),
          SizedBox(height: 7,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(label: Text("Mot de passe"),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: Icon(Icons.visibility_off),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange, // Définir la couleur de la bordure
                    width: 2.0, // Définir l'épaisseur de la bordure
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange, // Définir la couleur de la bordure lorsque le TextField est en focus
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 50,),

          ElevatedButton(onPressed: () async{

            var ctrl=ref.read(loginCtrlProvider.notifier);
            var resultat = await  ctrl.authenticate(email.text,password.text);

            if(resultat?.id!=0){
              if(resultat?.manager?.id==0){
                context.goNamed(Urls.choix_manager.name);
              }
              else{
                context.goNamed(Urls.accueil.name);
              }

            }
            else{
              _showMessageBox(context);
            }



          },
            child: Text("Se connecter"),
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 150),
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white
            ),),
          /*
          ElevatedButton(
              onPressed: () {
                context.pushNamed(Urls.test.name);
              },
              child: Text("Naviguer"))

           */
        ],
      ),
    );
  }

  _chargement(BuildContext context) {
    var state = ref.watch(loginCtrlProvider);
    return Visibility(
        visible: state.isLoading, child: CircularProgressIndicator());
  }
  void _showMessageBox(BuildContext context) {
    showDialog(
      context: context, // Provide the context of your widget
      builder: (_) {
        return AlertDialog(
          title: const Text("Resultat"),
          content: const Text("username or password incorrect"),
          actions: [
            ElevatedButton(
              onPressed: Navigator.of(context).pop,
              child: const Text("Close"),

            ),
          ],
        );
      },
    );
  }
}
