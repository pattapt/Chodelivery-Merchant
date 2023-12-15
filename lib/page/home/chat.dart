import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showd_delivery/class/Chat.dart';
import 'package:showd_delivery/class/Merchant.dart';
import 'package:showd_delivery/page/home/InChat.dart';
// import '../../../assets/InChat.dart';
import 'package:showd_delivery/struct/ChatModel.dart';
import 'package:showd_delivery/struct/MerchantDetailModel.dart' as mt;



class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> with TickerProviderStateMixin {
  final scrollController = ScrollController();
  String StoreName = "";
  String StoreImage = "https://i.pinimg.com/564x/d7/fe/2f/d7fe2f9979320bb57a1e4676eeb3e91a.jpg";
  List<Datum> chatAll=[];
  

  @override
  void initState() {
    super.initState();
    initializeData();
  }
  
  void initializeData() async {
    try {
      mt.MerchantDetailModel Data = await Merchant.getMerchantDetail();
      ChatModel chatdata = await inChat.getAllChat();
      if (mounted) {
        if (chatdata.statusCode == 200) {
          setState(() {
            chatAll=chatdata.data!;
          });}
        if (Data.statusCode == 200) {
          setState(() {
            StoreName = Data.data!.name!;
            StoreImage = Data.data!.imageUrl!;
          });
        }
      }
    } catch (e) {
      // Handle exceptions here, log or display an error message.
      print('Error in initializeData: $e');
    }
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                        radius: 35, // Adjust the radius as needed
                        backgroundImage: NetworkImage(StoreImage),
                      ),
                    const SizedBox(width: 10),
                    Expanded(child: itemProfile('สวัสดี', StoreName))
                  ],
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: chatAll.length,
                  itemBuilder: (context, index) {
                    Datum data = chatAll[index];

                    return test(data,context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  test(Datum data, BuildContext context,) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: double.infinity,
      // height: 100,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: CircleAvatar(
                        radius: 25, // Adjust the radius as needed
                        backgroundImage: NetworkImage(data.customer!.profileImageUrl!),
                      ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "หมายเลขคำสั่งซื้อที่ ${data.orderId}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("${data.lastTalkDate} น."),
              ],
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              // Navigate to the next screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatApp(token: data.chatToken,id: data.chatId,name: data.customer!.username,image: data.customer!.profileImageUrl,orToken: data.orderToken,)),
              );
            },
            child: Icon(Icons.chat, size: 22),
          ),
          const SizedBox(height: 80),
        ],
      ),
    ),
  );
}
  }
  
  class InChat {
  }

  itemProfile(String title, String subtitle) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: const Color.fromARGB(255, 139, 139, 139).withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10)
          ]),
      child: ListTile(
        title: Text(
          title,
          style: GoogleFonts.prompt(), // ใช้ Prompt font ที่ต้องการ
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.prompt(), // ใช้ Prompt font ที่ต้องการ
        ),
        tileColor: Colors.white,
      ),
    );
  }
