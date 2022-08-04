class MessagesRepository {
  final List<Message> messages = [
    Message("Merhaba", "Ali", DateTime.now().subtract(Duration(minutes: 2, seconds: 59))),
    Message("Merhaba", "Veli", DateTime.now().subtract(Duration(minutes: 2))),
    Message("Nasılsın", "Ali", DateTime.now().subtract(Duration(minutes: 1,seconds: 30))),
    Message("İyiydir", "Veli", DateTime.now().subtract(Duration(minutes: 1,seconds: 5))),
    Message("Sen?", "Veli", DateTime.now().subtract(Duration(minutes: 1))),
    Message("İyi", "Ali", DateTime.now().subtract(Duration(seconds: 5))),
    Message("Yaa kanka ne diyecektim", "Ali", DateTime.now()),

  ];
  int newMessageCount = 4;

}
class Message{
  String message;
  String sender;
  DateTime time;

  Message(this.message, this.sender, this.time);
}