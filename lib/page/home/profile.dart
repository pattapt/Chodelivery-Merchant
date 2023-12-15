import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showd_delivery/class/auth.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/class/Merchant.dart';
import 'package:showd_delivery/struct/MerchantDetailModel.dart' as mt;
import 'package:showd_delivery/struct/invokeaccesstoken.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  final scrollController = ScrollController();
  String StoreName = "";
  String StoreImage = "https://i.pinimg.com/564x/d7/fe/2f/d7fe2f9979320bb57a1e4676eeb3e91a.jpg";
  mt.Address StoreAddr=mt.Address();
  mt.MerchantDetailModel inf = mt.MerchantDetailModel();
  String idEmail = "";
  String idName = "";

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  void initializeData() async {
    try {
      mt.MerchantDetailModel Data = await Merchant.getMerchantDetail();
      InvokeAccessToken user = await Auth.grantAccessToken();

      if (mounted) {
        if(user.statusCode == 200){
          setState(() {;
            idEmail = user.data!.email!;
            idName = user.data!.name!;
          });
        }
        if(Data.statusCode == 200){
          setState(() {
            inf=Data;
            StoreName = Data.data!.name!;
            StoreImage = Data.data!.imageUrl!;
            StoreAddr = Data.data!.address!;
            idEmail = user.data!.email!;
            idName = user.data!.name!;
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
    // Dispose of resources, cancel timers, etc.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfileScreen(name: StoreName,image: StoreImage,addr: StoreAddr,email: idEmail,uname: idName,Data: inf),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final String name;
  final String image;
  final mt.Address addr;
  final String email;
  final String uname;
  final Data;
  const ProfileScreen({Key? key,required this.name,required this.image,required this.addr ,required this.uname,required this.email,required this.Data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
                radius: 70, // Adjust the radius as needed
                backgroundImage: NetworkImage(image),
              ),
            const SizedBox(height: 20),
            itemProfile(
                'ชื่อร้านค้า', name, CupertinoIcons.shopping_cart),
            const SizedBox(height: 20),
            itemProfile('ชื่อผู้ใช้', uname, CupertinoIcons.person),
            const SizedBox(height: 20),
            itemProfile(
                'Address',
                "${addr.address} ${addr.street} ${addr.building} ${addr.district} ${addr.amphure} ${addr.province} ${addr.zipcode}",
                CupertinoIcons.location),
            const SizedBox(height: 20),
            itemProfile('Email', email, CupertinoIcons.mail),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    Auth.setIsLogin(false);
                    Chodee.openPage("/Login", 1);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text('Logout')),
            )
          ],
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    bool showAdditionalIcon = title == 'ชื่อร้านค้า';
      return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: const Color.fromARGB(255, 66, 66, 66).withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          )
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          style: GoogleFonts.prompt(),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.prompt(),
        ),
        leading: Icon(iconData),
        trailing: showAdditionalIcon
            ? GestureDetector(
                onTap: () {
                    Chodee.openPage("/EditStore", Data.data);
                },
                child: Icon(
                  Icons.edit,
                  color: const Color.fromARGB(255, 103, 103, 103),
                ),
              )
            : null, // Set to null if you don't want to show the icon
        tileColor: Colors.white,
      ),
    );
  }
}
