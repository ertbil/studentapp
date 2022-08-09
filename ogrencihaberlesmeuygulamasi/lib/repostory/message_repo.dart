import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studentapp/models/message.dart';

class MessagesRepository extends ChangeNotifier {
  final List<Message> messages = [
    Message("Merhaba", "Ali", DateTime.now().subtract(Duration(minutes: 2, seconds: 59))),
    Message("Merhaba", "Veli", DateTime.now().subtract(Duration(minutes: 2))),
    Message("Nasılsın", "Ali", DateTime.now().subtract(Duration(minutes: 1,seconds: 30))),
    Message("İyiydir", "Veli", DateTime.now().subtract(Duration(minutes: 1,seconds: 5))),
    Message("Sen?", "Veli", DateTime.now().subtract(Duration(minutes: 1))),
    Message("İyi", "Ali", DateTime.now().subtract(Duration(seconds: 5))),
    Message("Yaa kanka ne diyecektim", "Ali", DateTime.now()),

  ];

}
class NewMessageCount extends StateNotifier<int>{
  NewMessageCount(int state): super (state);

  void reset(){
    state = 0;
  }

}
final newMessageCountProvider = StateNotifierProvider((ref) => NewMessageCount(4));

final messageProvider = ChangeNotifierProvider((ref){
  return MessagesRepository();
});
