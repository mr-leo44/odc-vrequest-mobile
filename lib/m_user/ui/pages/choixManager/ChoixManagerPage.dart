
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odc_mobile_project/m_user/ui/pages/choixManager/ChoixManagerCtrl.dart';

import '../../../../navigation/routers.dart';

class ChoixManagerPage extends ConsumerStatefulWidget{
  @override
  ConsumerState createState() => _ChoixManagerPageState();
}

class _ChoixManagerPageState extends ConsumerState<ChoixManagerPage> {
  var managerValue = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // action initiale de la page et appel d'un controleur



    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 40,),
              Image.asset("images/manager.png"),

          Padding(
            padding: const EdgeInsets.all(10.0),

            child: Autocomplete<String>(

              optionsBuilder: (TextEditingValue managerTextEditValue) async {
                if (managerTextEditValue.text.length < 1) {
                  return const Iterable<String>.empty();
                }

                var ctrl = ref.read(choixManagerCtrlProvider.notifier);
                var res = await ctrl.getNameUser(managerTextEditValue.text);
                return res.where((String option) {
                  return option.toLowerCase().contains(managerTextEditValue.text.toLowerCase());
                });
              },
              onSelected: (String value) {
                debugPrint('You just selected $value');
                managerValue.text =value;

              },
              fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                return TextField(
                  controller: textEditingController,

                  focusNode: focusNode,

                  decoration: InputDecoration(
                    hintText: 'Rechercher un manager',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    suffixIcon: Icon(Icons.search),
                  ),
                );
              },
              optionsViewBuilder: (context, onSelected, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    child: SizedBox(
                      width: 300, // Largeur de la liste d'options
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final option = options.elementAt(index);
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
          SizedBox(height: 40,),
          ElevatedButton(onPressed: () async{
            var res = ref.read(choixManagerCtrlProvider.notifier);
            res.getToken();
            var rep = await res.getUser();
            var id = rep.id;


            var soumetmanager = await res.soumettreManager(managerValue.text, id);
            if(soumetmanager){
             await res.getNetworkUser();

             context.goNamed(Urls.profil.name);
            }



          },
            child: Text("Enregistrer"),
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 150),
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white
            ),),
        ],
      ),
    );
  }
}