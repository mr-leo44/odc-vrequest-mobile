import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:odc_mobile_project/m_user/ui/pages/choixManager/ChoixManagerCtrl.dart';
import 'package:odc_mobile_project/utils/components/page_title_bar.dart';
import 'package:odc_mobile_project/utils/components/upside.dart';
import 'package:odc_mobile_project/utils/widgets/rounded_button.dart';
import 'package:odc_mobile_project/utils/colors.dart';
import 'package:odc_mobile_project/utils/size_config.dart';

import '../../../../navigation/routers.dart';

class ChoixManagerPage extends ConsumerStatefulWidget {
  @override
  ConsumerState createState() => _ChoixManagerPageState();
}

class _ChoixManagerPageState extends ConsumerState<ChoixManagerPage> {
  var managerValue = TextEditingController();
  final _managerFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // action initiale de la page et appel d'un controleur
    });
  }

  Future<void> submit() async {
    var res = ref.read(choixManagerCtrlProvider.notifier);
    res.getToken();
    var rep = await res.getUser();
    var id = rep.id;

    var soumetmanager = await res.soumettreManager(managerValue.text, id);
    if (soumetmanager) {
      await res.getNetworkUser();

      context.goNamed(Urls.accueil.name);
    }
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
                imgUrl: "images/intro.png",
                scale:6,
              ),
              PageTitleBar(title: 'Choix Manager'),
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
                          Form(
                            key: _managerFormKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top:38.0, left: 20, right: 20),
                                  child: Autocomplete<String>(
                                    optionsBuilder: (TextEditingValue
                                        managerTextEditValue) async {
                                      if (managerTextEditValue.text.length < 1) {
                                        return const Iterable<String>.empty();
                                      }
                                  
                                      var ctrl = ref.read(
                                          choixManagerCtrlProvider.notifier);
                                      var res = await ctrl
                                          .getNameUser(managerTextEditValue.text);
                                      return res.where((String option) {
                                        return option.toLowerCase().contains(
                                            managerTextEditValue.text
                                                .toLowerCase());
                                      });
                                    },
                                    onSelected: (String value) {
                                      debugPrint('You just selected $value');
                                      managerValue.text = value;
                                    },
                                    fieldViewBuilder: (context,
                                        textEditingController,
                                        focusNode,
                                        onFieldSubmitted) {
                                      return TextField(
                                        controller: textEditingController,
                                        focusNode: focusNode,
                                        decoration: InputDecoration(
                                          hintText: 'Rechercher un manager',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          suffixIcon: Icon(Icons.search),
                                        ),
                                      );
                                    },
                                    optionsViewBuilder:
                                        (context, onSelected, options) {
                                      return Align(
                                        alignment: Alignment.topLeft,
                                        child: Material(
                                          elevation: 4.0,
                                          child: SizedBox(
                                            width:
                                                300, // Largeur de la liste d'options
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              itemCount: options.length,
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                final option =
                                                    options.elementAt(index);
                                                return ListTile(
                                                  title: Text(option),
                                                  onTap: () => onSelected(option),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 22,
                                ),
                                RoundedButton(
                                    text: 'Enregistrer', press: submit),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
