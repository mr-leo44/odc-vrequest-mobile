

import '../../../m_user/business/model/User.dart';

class StatState {

  Map<String,dynamic> nombre;
  User? user;
  List last;


  StatState({

    this.nombre = const {},
    this.user = null,
    this.last = const []

  });

  StatState copyWith({

    Map<String,dynamic>? nombre,
    User? user,
    List? last

  }) =>
      StatState(

          nombre: nombre ?? this.nombre,
          user: user ?? this.user,
          last: last ?? this.last

      );
}