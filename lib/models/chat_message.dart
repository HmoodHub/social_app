class ChatMessage {
  late String dateTime, senderId, receiverId, message;

  ChatMessage({
    required this.dateTime,
    required this.senderId,
    required this.receiverId,
    required this.message,
  });

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = <String, dynamic>{};
     map['dateTime'] = dateTime ;
     map['senderId'] = senderId ;
     map['receiverId'] = receiverId;
     map['message'] = message  ;
    return map;
  }

  ChatMessage.fromMap(Map<String, dynamic> map){
   dateTime =  map['dateTime'] ;
   senderId =  map['senderId'] ;
    receiverId = map['receiverId'];
    message = map['message'];
  }
}
