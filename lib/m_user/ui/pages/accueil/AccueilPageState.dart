import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';

import '../../../business/model/User.dart';

class AccueilPageState {

  Map<String,dynamic> nombre;
  User? user;
  List<Demande> last;


  AccueilPageState({

    this.nombre = const {},
    this.user = null,
    this.last = const []

  });

  AccueilPageState copyWith({

    Map<String,dynamic>? nombre,
    User? user,
    List<Demande>? last

  }) =>
      AccueilPageState(

        nombre: nombre ?? this.nombre,
        user: user ?? this.user,
          last: last ?? this.last

      );
}