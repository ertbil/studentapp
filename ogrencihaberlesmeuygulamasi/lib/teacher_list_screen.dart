import 'package:flutter/material.dart';

class TeacherListpage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Center(


        child: Column(


          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0,horizontal: 32.0),
              child:   Text("10 Student"),
            ),
            Expanded(
              child: ListView.separated(itemBuilder:(context, index) => ListTile(
                leading: Text("🙎🏻‍♀🙎🏻‍♂"),
                title: Text("Ali"),


              ),
                separatorBuilder: (context, index) => Divider(),
                itemCount: 25,


              ),
            )





          ],
        ),
      ),
    );
  }
  
}