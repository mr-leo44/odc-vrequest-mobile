import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:odc_mobile_project/m_user/ui/pages/login/LoginCtrl.dart';
import 'package:odc_mobile_project/navigation/routers.dart';
import 'package:odc_mobile_project/utils/components/components.dart';
import 'package:odc_mobile_project/utils/widgets/widgets.dart';
import 'package:odc_mobile_project/utils/colors.dart';
import 'package:odc_mobile_project/utils/size_config.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  var email = TextEditingController(text: "sjayes0");
  var password = TextEditingController(text: "123456");
  bool _obscureText = true;
  final _loginFormKey = GlobalKey<FormState>();

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

  Future<void> submit() async {
    var ctrl = ref.read(loginCtrlProvider.notifier);
    var resultat = await ctrl.authenticate(email.text, password.text);

    if (resultat?.id != 0) {
      if (resultat?.manager?.id == 0) {
        context.goNamed(Urls.choix_manager.name);
      } else {
        context.goNamed(Urls.accueil.name);
      }
    } else {
      _showMessageBox(context);
    }
  }

  void obscure(){
    setState((){
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Upside(
                imgUrl: "assets/auth.png",
                scale: 2.5,
              ),
              PageTitleBar(title: 'Authentification'),
              Padding(
                padding: const EdgeInsets.only(top: 350.0),
                child: Container(
                  height: AppSizes.screenHeight * 0.62,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          
                          const SizedBox(
                            height: 55,
                          ),
                          iconButton(context),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "ou utiliser votre identifiant",
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'OpenSans',
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Form(
                            key: _loginFormKey,
                            child: Column(
                              children: [
                                RoundedInputField(
                                  hintText: "Email ou Nom d'utilisateur",
                                  icon: Icons.email,
                                  controller: email,
                                ),
                                RoundedPasswordField(
                                  password: password,
                                  obscureText: _obscureText,
                                  obscure: obscure,
                                ),
                                // switchListTile(),
                                SizedBox(
                                  height: 22,
                                ),
                                RoundedButton(text: 'Se connecter', press: submit),
                                const SizedBox(
                                  height: 20,
                                ),
                                // UnderPart(
                                //   title: "Don't have an account?",
                                //   navigatorText: "Register here",
                                //   onTap: () {
                                //     Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) =>
                                //                 const SignUpScreen()));
                                //   },
                                // ),
                                // const SizedBox(
                                //   height: 20,
                                // ),
                                // Text(
                                //   'Forgot password?',
                                //   style: TextStyle(
                                //       color: Colors.grey,
                                //       fontFamily: 'OpenSans',
                                //       fontWeight: FontWeight.w600,
                                //       fontSize: 13),
                                // ),
                                
                              ],
                            ),
                          ),
                        ],
                      ),
                      _chargement(context, ref),
                    ],
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

switchListTile() {
  return Padding(
    padding: const EdgeInsets.only(left: 50, right: 40),
    child: SwitchListTile(
      dense: true,
      title: const Text(
        'Se souvenir de moi',
        style: TextStyle(fontSize: 16, fontFamily: 'OpenSans'),
      ),
      value: true,
      activeColor: Couleurs.primary,
      onChanged: (val) {},
    ),
  );
}

iconButton(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      RoundedIcon(imageUrl: "assets/images/facebook.png"),
      SizedBox(
        width: 20,
      ),
      RoundedIcon(imageUrl: "assets/images/twitter.png"),
      SizedBox(
        width: 20,
      ),
      RoundedIcon(imageUrl: "assets/images/google.jpg"),
    ],
  );
}

_chargement(BuildContext context, WidgetRef ref) {
  var state = ref.watch(loginCtrlProvider);
  return Visibility(
    visible: state.isLoading,
    child: Center(
      child: LoadingAnimationWidget.dotsTriangle(
        color: Couleurs.primary,
        size: 40,
      ),
    ),
  );
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
