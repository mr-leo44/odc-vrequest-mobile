import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odc_mobile_project/m_user/ui/pages/login/LoginCtrl.dart';
import 'package:odc_mobile_project/navigation/routers.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  var email=TextEditingController();
  var password=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // action initiale de la page et appel d'un controleur
      var ctrl = ref.read(loginCtrlProvider.notifier);
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
            print(email.text);
            print(password.text);
            var ctrl=ref.read(loginCtrlProvider.notifier);
         var resultat = await  ctrl.authenticate(email.text,password.text);
           if(resultat){
             context.pushNamed(Urls.test.name);
           }

          },
              child: Text("Envoyer"),
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
}
