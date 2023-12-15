// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showd_delivery/class/Merchant.dart';
import 'package:showd_delivery/class/Product.dart';
import 'package:showd_delivery/class/auth.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/page/home/addproduct1.dart';
import 'package:showd_delivery/struct/ListItem.dart';
import 'package:showd_delivery/struct/MerchantDetailModel.dart' as mt;

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);
  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> with TickerProviderStateMixin {
  final scrollController = ScrollController();
  List<Datum> itemList = [];
  String StoreName = "";
  String StoreImage = "https://i.pinimg.com/564x/d7/fe/2f/d7fe2f9979320bb57a1e4676eeb3e91a.jpg";
  int pageI =1;

  @override   
  void initState() {
    initializeData(pageI);
    super.initState();
  }
  void initializeData(int p) async {
    try {
      ListItemModel item = await Product.getListItem(p);
      mt.MerchantDetailModel Data = await Merchant.getMerchantDetail();
      if (mounted) {
        if (item.statusCode == 200) {
          setState(() {
            itemList = item.data!;
          });
        }
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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: _buildTheme(Brightness.light),
      home: Scaffold(
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
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    Datum data = itemList[index];

                    return test(data,context);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (pageI > 1)
                      ElevatedButton(
                        onPressed: () {
                          pageI -= 1;
                          initializeData(pageI);
                        },
                        child: Text('Back'),
                      ),
                    Spacer(), // This widget takes up any available space
                    if (itemList.length==20)
                      ElevatedButton(
                        onPressed: () {
                          pageI += 1;
                          initializeData(pageI);
                        },
                        child: Text('Next'),
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);
  
//   BuildContext? get context => null;

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }

 test(Datum data, [BuildContext? context]) {
  return GestureDetector(
    // onTap: () {
    //   // Handle the tap event here
    //   Navigator.push(
    //             context!,
    //             MaterialPageRoute(builder: (context) => AddProd()),
    //           );
    // },
    child: Padding(
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
              child: Image.network(data.imageUrl!, fit: BoxFit.cover),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name!,
                    style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "ราคา ${data.price} บาท",
                    style: GoogleFonts.prompt(),
                  ),
                  Text(
                    "รหัสสินค้า ${data.barcode}",
                    style: GoogleFonts.prompt(),
                  ),
                  Text("คงเหลือ ${data.quantity} ชิ้น",
                      style: GoogleFonts.prompt()),
                ],
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                // Handle the tap event for the icon
              Chodee.openPage("/Edit", data);
              },
              child: Icon(Icons.settings, size: 22),
            ),
          ],
        ),
      ),
    ),
  );
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
