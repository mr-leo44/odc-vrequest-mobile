import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:odc_mobile_project/m_user/ui/pages/compte/CompteProfilPageCtrl.dart';
import 'package:odc_mobile_project/m_user/ui/pages/profil/ProfilPageCtrl.dart';
import 'package:odc_mobile_project/navigation/routers.dart';
import 'package:odc_mobile_project/utils/size_config.dart';
import 'package:odc_mobile_project/utils/bottom_nav.dart';
import 'package:odc_mobile_project/utils/colors.dart';
import 'package:odc_mobile_project/utils/layouts/header.dart';
import 'package:odc_mobile_project/utils/logout.dart';

class Profilpage extends ConsumerStatefulWidget {
  const Profilpage({super.key});

  @override
  ConsumerState createState() => _TestpageState();
}

class _TestpageState extends ConsumerState<Profilpage> {
  final PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // action initiale de la page et appel d'un controleur
      var ctrl = ref.read(profilPageCtrlProvider.notifier);
      ctrl.getUser();
    });
  }

  // void logout() async {
  //   var dis = ref.read(profilPageCtrlProvider.notifier);
  //   var rep = await dis.disconnect();
  //   if (rep) {
  //     context.goNamed(Urls.auth.name);
  //   }
  // }

  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _enteteProfil(),
      body: Container(
        height: AppSizes.screenHeight,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: [
              Container(
                height: AppSizes.screenHeight * 0.89,
                width: AppSizes.screenWidth,
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Center(child: photoProfil()),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                            ),
                            child: _infoProfil(),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          _card(),
                          SizedBox(
                            height: 40,
                          ),
                          // _buildActionButtons(logout),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Bottom_nav.bottomNav(
                    context, ref, _currentIndex, pageController),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _enteteProfil() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Header.header(
        context,
        Text(
          "Profil",

        ),
      ),
      foregroundColor: Colors.black,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () async {
            Logout.logout(context, ref);
          },
          icon: Icon(Icons.logout),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.sync),
        )
      ],
    );
  }

  Widget photoProfil() {
    return Center(
      child: CircleAvatar(
        radius: 50.0,
        // backgroundImage: NetworkImage(
        //   'https://static.vecteezy.com/system/resources/thumbnails/012/986/755/small/abstract-circle-logo-icon-free-png.png',
        // ),
        backgroundImage: Image.asset("assets/images/avatar.jpeg").image,
      ),
    );
  }

  Widget _infoProfil() {
    var state = ref.watch(profilPageCtrlProvider);
    // var res = ctrl.getUser();
    var nom = state.user?.nom ?? ""; // res.name;
    var prenom = state.user?.prenom ?? "";
    var email = state.user?.email ?? ""; // res.email;
    var roles = state.user?.role ?? []; //.toString() ?? "";
    //List<String> roleName = role.replaceAll("[[[[", "").replaceAll("]]]]", "").split(",");
    // var taille = role?.length;
    var rolesJoined = roles.join(",");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
            child: Text(
          prenom + " " + nom,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 35, color: Colors.black),
        )),
        SizedBox(height: 8.0),
        Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.mail_outline,
              size: 17,
            ),
            SizedBox(
              width: 3,
            ),
            Text(email),
          ],
        )),
        SizedBox(height: 6.0),
        Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconlyLight.category,
              size: 17,
              weight: 2,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              rolesJoined,
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
          ],
        )),
      ],
    );
  }

  Widget _card() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: TextButton(
                onPressed: () {
                  context.pushNamed(Urls.compte.name);
                },
                style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                ),
                child: Text(
                  'Mon compte',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ),
              leading: Icon(Icons.people),
              trailing: Icon(Icons.arrow_right),
            ),
            Divider(),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text("Synchroniser"),
              ),
              leading: Icon(Icons.sync),
            ),
            Divider(),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text("Version 1.0"),
              ),
              leading: Icon(Icons.dock),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () async {
            Logout.logout(context, ref);
          },
          child: Text('Se déconnecter'),
        ),
      ],
    );
  }
}
