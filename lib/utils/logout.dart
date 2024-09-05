import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odc_mobile_project/m_user/ui/pages/profil/ProfilPageCtrl.dart';
import 'package:odc_mobile_project/navigation/routers.dart';

class Logout {
  static void logout(BuildContext context, WidgetRef ref) async {
    var dis = ref.read(profilPageCtrlProvider.notifier);
    var rep = await dis.disconnect();
    if (rep) {
      context.goNamed(Urls.auth.name);
    }
  }
}
