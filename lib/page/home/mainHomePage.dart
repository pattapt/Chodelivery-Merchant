import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:showd_delivery/class/Merchant.dart';
import 'package:showd_delivery/page/home/addproduct.dart';
import 'package:showd_delivery/page/home/chat.dart';
import 'package:showd_delivery/page/home/homeContent.dart';
import 'package:showd_delivery/page/home/order.dart';
import 'package:showd_delivery/page/home/profile.dart';
import 'package:showd_delivery/page/loading/PageLoadingV1.dart';

class HomePage extends StatefulWidget {
  final int? index;
  final bool requestCheckMerchant;
  const HomePage({Key? key, required this.index, this.requestCheckMerchant = false}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool isLoading = true;
  List<Widget> pageList = [
    const PageLoadingV1(),
  ];
  int currentIndexPage = 0;
  int notiId = 0;

  void changePageIndex(int index) {
    setState(() {
      currentIndexPage = index;
    });
  }

  @override
  void initState() {
    currentIndexPage = widget.index ?? 0;
    initializeGeneric();
    super.initState();
    if(widget.requestCheckMerchant && widget.index == 0){
      getMerchantFromLogin();
    }
  }

  void getMerchantFromLogin() async{
    await Merchant.getMerchant(1, 50);
  }

  void initializeGeneric() async {
    setState(() {
      isLoading = false;
      pageList = [
        const HomeContent(),
        const Chat(),
        const Order(),
        const AddProd(),
        const Profile(),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true ? const PageLoadingV1() : pageList[currentIndexPage],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 12,
        selectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        onTap: changePageIndex,
        currentIndex: currentIndexPage,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "ร้านค้า"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "แชท"),
          BottomNavigationBarItem(icon: Icon(Icons.my_library_books_outlined), label: "รายการสินค้า"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: "เพิ่มรายการ"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "โปรไฟล์"),
        ],
      ),
    );
  }
}
