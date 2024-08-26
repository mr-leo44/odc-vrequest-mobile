

import '../../../../m_user/business/model/User.dart';

class DemandeEnCoursState {

  Map<String,dynamic> nombre;
  User? user;
  Map<String,dynamic> demande;


  DemandeEnCoursState({

    this.nombre = const {},
    this.user = null,
    this.demande = const {}

  });

  DemandeEnCoursState copyWith({

    Map<String,dynamic>? nombre,
    User? user,
    Map<String,dynamic>? demande

  }) =>
      DemandeEnCoursState(

          nombre: nombre ?? this.nombre,
          user: user ?? this.user,
          demande: demande ?? this.demande

      );
}