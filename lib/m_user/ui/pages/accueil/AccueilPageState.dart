import '../../../business/model/User.dart';

class AccueilPageState {

  Map<String,dynamic> nombre;
  User? user;
  List last;


  AccueilPageState({

    this.nombre = const {},
    this.user = null,
    this.last = const []

  });

  AccueilPageState copyWith({

    Map<String,dynamic>? nombre,
    User? user,
    List? last

  }) =>
      AccueilPageState(

        nombre: nombre ?? this.nombre,
        user: user ?? this.user,
          last: last ?? this.last

      );
}