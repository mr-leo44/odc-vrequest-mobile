
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';
import 'package:odc_mobile_project/m_user/ui/framework/UserLocalServiceImpl.dart';

import 'm_user/business/model/Authenticate.dart';
import 'm_user/ui/framework/UserNetworkServiceImpl.dart';

class Test extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
       children: [
         SizedBox(height: 300),
         Center(child: ElevatedButton(
             onPressed: ()async{
           var baseUrlTest="http://10.252.252.20:8000";
           var impl=UserNetworkServiceImpl(baseUrlTest);
           var data= await AuthenticateRequestBody(email: "willbe@gmail.com", password: "azertyui");
           impl.authenticate(data);
         }, 
             child: Text('authenticate'))),
         
         SizedBox(height: 30),
         
         Center(child: ElevatedButton(
             onPressed: (){
           var storage = GetStorage();
           var impl = UserLocalServiceImpl(storage);
           var data = User(id: 4, emailVerifiedAt: DateTime.now(), createdAt: DateTime.now(), updatedAt:  DateTime.now());
           impl.saveUser(data);
         },
             child: Text('SaveUser'))),

         SizedBox(height: 30),

         Center(child: ElevatedButton(
             onPressed: (){
               var storage = GetStorage();
               var impl = UserLocalServiceImpl(storage);
              impl.getUser();

             },
             child: Text('getUser'))),
         SizedBox(height: 30),

         Center(child: ElevatedButton(
             onPressed: (){
               var storage = GetStorage();
               var impl = UserLocalServiceImpl(storage);
               impl.disconnect();
             },
             child: Text('Disconnect')))
       ],
     )
    );
  }

}