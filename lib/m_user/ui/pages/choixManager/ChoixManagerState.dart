import '../../../business/model/User.dart';

class ChoixManagerState {

  User? user;
  List<dynamic> getname;
  String token;


  ChoixManagerState({

    this.user = null,
    this.getname = const [],
    this.token = ""

  });

 ChoixManagerState copyWith({

    User? user,
   List<dynamic> getname = const [],
   String token = ""

  }) =>
      ChoixManagerState(

        user: user ?? this.user,
        getname: getname ?? this.getname,
        token: token ?? this.token,

      );
}