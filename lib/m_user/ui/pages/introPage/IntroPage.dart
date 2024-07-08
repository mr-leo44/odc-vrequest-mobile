import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../navigation/routers.dart';

class IntroPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 0, width: double.infinity,),
            Container(
              padding: const EdgeInsets.only(top:150),
              child: Image.asset("images/intro.png",
                width: 300,
              ),
            ),
            SizedBox(height: 20,),
            Text("Vrequest", style: TextStyle(
                color:Colors.orange,
                fontSize: 25,
                fontWeight: FontWeight.bold )
            ),
            Spacer(),
            Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton.icon(

                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white
                  ),
                  onPressed: (){
                    /*Navigator.push(context,
                    MaterialPageRoute(builder:(ctx)=> LoginPage() ));*/
                    context.goNamed(Urls.auth.name);
                  },
                  icon: Icon(Icons.check),
                  label: const Text('Demarrer', style:TextStyle(fontSize: 20)),
                )
            ),


            SizedBox(height: 80,),


          ],
        )
    );
  }
}