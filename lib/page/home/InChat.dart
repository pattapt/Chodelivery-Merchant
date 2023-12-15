import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:showd_delivery/class/Imagepri.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/class/transaction.dart';
import 'package:showd_delivery/struct/InOrderModel.dart';
import 'package:showd_delivery/struct/MessageModel.dart';
import 'package:showd_delivery/class/Chat.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

const String API_KEY = "8dbaa73ce7ec51885a7e";
const String API_CLUSTER = "ap1";

class ChatApp extends StatelessWidget {
  final token; 
  final id;
  final name;
  final image;
  final orToken;
  ChatApp({Key? key, required this.token,required this.id,required this.name,required this.image,required this.orToken}) : super(key: key);
  
  ThemeData _buildTheme(Brightness brightness) {
    var baseTheme = ThemeData(
      primaryColor: Colors.redAccent,
      primaryColorDark: Colors.red,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 255, 255, 255),
        secondary: const Color.fromARGB(255, 255, 255, 255),
      ),
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        titleTextStyle: GoogleFonts.prompt(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
      ),
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.promptTextTheme(baseTheme.textTheme),
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: _buildTheme(Brightness.light),
      debugShowCheckedModeBanner: false,
      home: ChatScreen(token: token,id: id,name: name,image: image,orToken: orToken,),
    );
  }
}

class ChatMessage {
  final String text;
  final String sender;
  final String type;

  ChatMessage({required this.text, required this.sender,required this.type});
}

class ChatScreen extends StatefulWidget {
  final token;
  final id;
  final name;
  final image;
  final orToken;
  ChatScreen({Key? key, required this.token,required this.id,required this.name,required this.image,required this.orToken}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  List<ChatMessage> _messages = [];
  File? _image;
  String memId = "";
  int i = 0;
  get args => null;

  
  @override
  void initState() {
    initializeData();
    super.initState();
  }
  
   void initializeData() async {
    try {
      InOrderModel order = await transaction.getInOrder(widget.orToken);
      MessageModel mess = await inChat.getMessage(widget.token);
      if (mounted) {
        if (order.statusCode == 200) {
          memId= order.data!.chatProfile!.memberUuid!;
          scribe(widget.token, memId, onMessageReceived);
          
        }
        if (mess.statusCode == 200) {
          i = mess.data!.length-1;
          for(i;i>=0;i--){
            setChat(mess.data![i].message!.message!, mess.data![i].type!, mess.data![i].source!.accountName!, mess.data![i].message!.messageType!);
          }
        }
      }
    } catch (e) {
      // Handle exceptions here, log or display an error message.
      print('Error in initializeData: $e');
    }
  }
  
  void onMessageReceived(Datum message) {
    // Handle the received message in your ChatScreen
    // You can update the UI or take any other actions here
    // Datum x = jsonEncode(message);
    print(message.message!.messageType);
    setState(() {
      if(message.message!.message!.startsWith("https")){
        setChat(message.message!.message!,message.type!,message.source!.accountName!,"Image");
      }
      // if(message.message!.message!.startsWith("https")){
      //   inChat.getImage(widget.token, message.message!.messageToken!);
      // }
      else{
        setChat(message.message!.message!,message.type!,message.source!.accountName!,message.message!.messageType);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  void setChat(String message,String type,String name,msgType){
    setState(() {
        if(type == "messageSend"){
            _messages.add(ChatMessage(text: message, sender: "You", type:msgType ));
        }
        else{
            _messages.add(ChatMessage(text: message, sender: name, type:msgType ));
        }
      });
  }
  void _sendMessage(String message) {
    inChat.sendMessag(widget.id,message,widget.token);
    _textController.clear();
  }
  void _sendimage(img) {
    inChat.sendImage(img, widget.token);
    setState(() {
      _image=null;
    });
  }
  Future getImage() async {
          var image = await ImagePicker().pickImage(source: ImageSource.gallery);

          if (image != null) {
            setState(() {
              _image = File(image.path);
            });
          }
        }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
            children: [
              // Insert your image here
              CircleAvatar(
                        radius: 25, // Adjust the radius as needed
                        backgroundImage: NetworkImage(widget.image),
                      ),
              SizedBox(width: 10), // Add some spacing between the image and title
              Text(widget.name),
            ],
          ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Chodee.openPage("/home", 1);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return ChatBubble(
                  message: _messages[index],
                );
              },
            ),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  
                  child: 
                  _image == null
                    ?TextField(
                      controller: _textController,
                      onChanged: (String text) {},
                      onSubmitted: _sendMessage,
                      decoration: InputDecoration(
                      hintText: 'Type a message...',
                      )
                    )
                    :Image.file(
                          _image!,
                          height: 100,
                          width: 100,
                        ),
                  ),
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () {
                    getImage();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_image != null)
                      _sendimage(_image);
                    else
                      _sendMessage(_textController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.sender == 'You'
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (message.sender != 'You')
            CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.blue,
              child: Text(
                message.sender[0],
                style: TextStyle(color: Colors.white),
              ),
            ),
          SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.sender,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: message.type == 'Image'
                  ? GetImagePrivateV2(imageUrl: message.text,)
                  : Text(message.text),
              ),
            ],
          ),
          if (message.sender == 'You')
            SizedBox(width: 20.0), // Add spacing for owner's messages
        ],
      ),
    );
  }
}

class ChatBubbleLeft extends StatelessWidget {
  final ChatMessage message;

  ChatBubbleLeft({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.blue,
            child: Text(
              message.sender[0],
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.sender,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(message.text),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


Future<void> scribe(token, memid, void Function(Datum) onMessageReceived) async {
  final pusher = PusherChannelsFlutter.getInstance();
  await pusher.init(
    apiKey: API_KEY,
    cluster: API_CLUSTER,
  );
  final myChannel = await pusher.subscribe(
    channelName: token,
    onEvent: (event) {
      if (event.eventName == memid) {
        String x = event.data;
        Datum msgNew = messageDetaillFromJson(x);
        print(jsonEncode(msgNew));

        // Call the callback function with the received message
        onMessageReceived(msgNew);
      }
    },
  );
  await pusher.connect();
}
// Future<void> scribe() async{
//   final pusher = PusherChannelsFlutter.getInstance();
//   final channels = {};
//   await pusher.init(
//     apiKey: API_KEY,
//     cluster: API_CLUSTER,
//     authEndPoint: "https://your-server.com/pusher/auth"
//   );
//   final myChannel = await pusher.subscribe(channelName:'Chodelivery',
//     onSubscriptionSucceeded: (channelName, data) {
//       print("Subscribed to $channelName");
//       print("I can now access me: ${myChannel.me}")
//       print("And here are the channel members: ${myChannel.members}")
//     },
//     onMemberAdded: (member) {
//       print("Member added: $member");
//     },
//     onMemberRemoved: (member) {
//       print("Member removed: $member");
//     },
//     onEvent: (event) {
//       print("Event received: $event");
//     },
//   );
// }
