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
          ElevatedButton(
              onPressed: () {
                context.pushNamed(Urls.test.name);
              },
              child: Text("Naviguer"))
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
