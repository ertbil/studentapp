import 'dart:math';

import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,

              itemBuilder: (context, index) {

              bool isAmI = Random().nextBool();
              return Align(
                alignment: isAmI? Alignment.centerRight: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color:Colors.black ,width: 2),
                      color: isAmI ? Colors.blue: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text("Lorem Ipsum",
                      style: TextStyle(color: isAmI? Colors.white: Colors.black ),),
                    ),
                  ),
                ),
              );
            },),
          ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: DecoratedBox(
             decoration: BoxDecoration(
               border: Border.all(),
                 color: Colors.grey.shade100,
                 borderRadius: BorderRadius.all(
                     Radius.circular(25)
                 )),
             child: Row(
               children: [
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none),

                ),
                    )),
                 IconButton(onPressed: (){}, icon: Icon(Icons.send,color: Colors.blue,))
               ],
             ),
           ),
         )
        ],
      )
    );
  }

}