import 'package:flutter/material.dart';
import 'package:studentapp/repostory/message_repo.dart';

class MessagePage extends StatefulWidget{
  MessagesRepository messagesRepository;

  MessagePage(this.messagesRepository, {Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  void initState() {
    widget.messagesRepository.newMessageCount = 0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: widget.messagesRepository.messages.length,
              itemBuilder: (context, index) {
              return MessageView( widget.messagesRepository.messages[widget.messagesRepository.messages.length-index-1]);
            },),
          ),
         Padding(
           padding: const EdgeInsets.all(4.0),
           child: DecoratedBox(
             decoration: BoxDecoration(
               border: Border.all(),
                 color: Colors.grey.shade100,
                 borderRadius: const BorderRadius.all(
                     Radius.circular(25)
                 )),
             child: Row(
               children: [
                const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none),

                ),
                    )),
                 IconButton(onPressed: (){}, icon: const Icon(Icons.send,color: Colors.blue,))
               ],
             ),
           ),
         )
        ],
      )
    );
  }
}

class MessageView extends StatelessWidget {
  final Message message;
  const MessageView(this.message, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.sender == "Veli" ? Alignment.centerRight: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color:Colors.black ,width: 2),
            color: message.sender == "Veli" ? Colors.blue: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20))
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(message.message,
            style: TextStyle(color: message.sender == "Veli" ? Colors.white: Colors.black ),),
          ),
        ),
      ),
    );
  }
}