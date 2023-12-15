import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html_v3/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showd_delivery/class/Merchant.dart';
import 'package:showd_delivery/class/transaction.dart';
import 'package:showd_delivery/struct/InOrderModel.dart';
import 'package:showd_delivery/struct/MerchantDetailModel.dart' as mt;
import 'package:showd_delivery/struct/SumModel.dart';
import 'package:showd_delivery/struct/TransactionModel.dart' as ts;

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);
  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>
    with TickerProviderStateMixin {
  final scrollController = ScrollController();
  String StoreName = "";
  String totalAmount = "";
  String lastWeekSales = "";
  String StoreImage = "https://i.pinimg.com/564x/d7/fe/2f/d7fe2f9979320bb57a1e4676eeb3e91a.jpg";
  List<ts.Datum> orderData = [];
  
  @override
  void initState() {
    super.initState();
    initializeData();
  }


  void initializeData() async {
    try {
      // void asd = await Merchant.getMerchant(1,50);
      SumModel sum = await Merchant.getSum();
      ts.TransactionModel ord = await transaction.getOrder();
      mt.MerchantDetailModel Data = await Merchant.getMerchantDetail();

      if (mounted) {
        if (sum.statusCode == 200) {
          setState(() {
            totalAmount = sum.data!.totalAmount!.toString();
            lastWeekSales = sum.data!.lastWeekSales!.toString();
          });
        }
        if (ord.statusCode == 200) {
          setState(() {
            orderData = ord.data!;
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
    // Dispose of resources, cancel timers, etc.
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
                const SizedBox(height: 30),
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 5),
                        color: const Color.fromARGB(255, 139, 139, 139).withOpacity(.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage('assets/images/promotion.gif'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 31, 149, 240),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 5),
                                  color:
                                      const Color.fromARGB(255, 139, 139, 139)
                                          .withOpacity(.2),
                                  spreadRadius: 2,
                                  blurRadius: 10)
                            ]),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(
                                  27.0), // คุณสามารถเปลี่ยนค่าตามที่คุณต้องการ
                              child: Text(
                                'ยอดขาย / วัน      '+totalAmount+" บาท",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 5),
                                  color:
                                      const Color.fromARGB(255, 139, 139, 139)
                                          .withOpacity(.2),
                                  spreadRadius: 2,
                                  blurRadius: 10)
                            ]),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(
                                  27.0), // คุณสามารถเปลี่ยนค่าตามที่คุณต้องการ
                              child: Text(
                                'ยอดขายรวม       '+ lastWeekSales +" บาท",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text('ประวัติการสั่งซื้อ',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: orderData.length,
                  itemBuilder: (context, index) {
                    ts.Datum data = orderData[index];
                    
                    return OrderTransactionCard(context,data);
                  },
                ),
              ],
            ),
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


}

OrderTransactionCard(BuildContext context,ts.Datum dataTransaction) {
  return GestureDetector(
    onTap: () {
        // print(or);
      // _showProductDetailsDialog(context, data);
      _showModal(context,dataTransaction.orderToken.toString(),dataTransaction.status.toString());
    },
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
              child: Image.network(dataTransaction.customer!.profileImageUrl!, fit: BoxFit.cover),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   "หมายเลขคำสั่งซื้อ ${dataTransaction.orderId} ",
                    style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  Text("ราคารวม ${dataTransaction.totalPay} บาท",
                      style: GoogleFonts.prompt()),
                ],
              ),
            ),
            const SizedBox(width: 10),
            
            Icon(
              _getTransactionIcon(dataTransaction),
              size: 22),
          ],
        ),
      ),
    ),
  );
}
IconData _getTransactionIcon(dataTransaction) {
              if (dataTransaction.status=="done") {
                return Icons.check_circle_outline_outlined;
              } else if (dataTransaction.status=="preparing") {
                return Icons.shopping_cart_outlined;
              } else if (dataTransaction.status=="waiting_for_delivery") {
                return Icons.shopping_cart_checkout_outlined;
              } else if (dataTransaction.status=="on_the_way") {
                return Icons.motorcycle_outlined;
              } else {
                return Icons.cancel_outlined; // Replace with the icon for other conditions
              }
            }
// test(ProductsData data, BuildContext context,List<ts.Datum> or) {
//   return GestureDetector(
//     onTap: () {
//         print(or);
//       // _showProductDetailsDialog(context, data);
//       _showModal(context,data);
//     },
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         width: double.infinity,
//         // height: 100,
//         child: Row(
//           children: [
//             Container(
//               width: 50,
//               height: 50,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Image.network(data.imageURL, fit: BoxFit.cover),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                    "รายการสินค้าที่ ${data.productOrder} ",
//                     style: GoogleFonts.prompt(
//                       textStyle: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
                  
//                   Text("จำนวน ${data.stockAmount} ชิ้น",
//                       style: GoogleFonts.prompt()),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 10),
//             Icon(Icons.check_circle_outline_outlined, size: 22),
//           ],
//         ),
//       ),
//     ),
//   );
// }

void upStat(token,id,status) async{
  ts.TransactionModel test = await transaction.updateStatus(token,id,status);
}
testr(Cart data, BuildContext context) {
  return GestureDetector(
    onTap: () {
      // _showProductDetailsDialog(context, data);
    },
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
              child: Image.network(data.product!.imageUrl!, fit: BoxFit.cover),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   "${data.product!.name!}",
                    style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  Text("จำนวน ${data.amount} ชิ้น",
                      style: GoogleFonts.prompt()),
                ],
              ),
            ),
            const SizedBox(width: 10),
            if (data.note != "")
              Text(
                "Note: ${data.note}",
                style: GoogleFonts.prompt(),
              ),
          ],
        ),
      ),
      
    ),
  );
}
// popupdata(ProductsData data) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Container(
//       width: double.infinity,
//       // height: 100,
//       child: Row(
//         children: [
//           Container(
//               width: 50,
//               height: 50,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Image.network(data.imageURL, fit: BoxFit.cover)),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   data.productName,
//                   style: GoogleFonts.prompt(
//                     textStyle: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   "ราคา ${data.price} บาท",
//                   style: GoogleFonts.prompt(),
//                 ),
//                 Text("จำนวน ${data.stockAmount} ชิ้น",
//                     style: GoogleFonts.prompt()),
//               ],
//             ),
//           ),
//           const SizedBox(width: 10)
//         ],
//       ),
//     ),
//   );
// }
  Future<void> _showModal(BuildContext context, String Token, String status) async {
    InOrderModel orderDetail = await transaction.getInOrder(Token);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'หมายเลขคำสั่งซื้อ ${orderDetail.data!.orderId!}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(orderDetail.data!.customer!.profileImageUrl!),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        child: ListTile(
                          title: Text(
                            orderDetail.data!.customer!.username!,
                          ),
                          subtitle: Text(
                            orderDetail.data!.destination!.name!+" "+orderDetail.data!.destination!.address!+" "+orderDetail.data!.destination!.street!+" "+orderDetail.data!.destination!.building!+" "+orderDetail.data!.destination!.district!+" "+orderDetail.data!.destination!.amphure!+" "+orderDetail.data!.destination!.province!+" "+orderDetail.data!.destination!.zipcode!+" "+orderDetail.data!.destination!.phoneNumber!,
                            style: GoogleFonts.prompt(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(), // Disable scrolling for this ListView.builder
                    shrinkWrap: true,
                    itemCount: orderDetail.data!.items!.cart!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Cart data = orderDetail.data!.items!.cart![index];
                      return testr(data, context);
                    },
                  ),
                ),
                Text(
                  "Note : ${orderDetail.data!.note!}",
                ),
                Center(
                  child: (() {
                    switch (status) {
                      case "preparing":
                        return but(orderDetail, status);
                      case "waiting_for_delivery":
                        return but(orderDetail, status);
                      case "on_the_way":
                        return but(orderDetail, status);
                      default:
                        return null;
                    }
                  })(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

 





  // Future<void> _showModal(BuildContext context, String Token, String status) async {
  //   InOrderModel orderDetail = await transaction.getInOrder(Token);
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SingleChildScrollView(
  //         child: Container(
  //           padding: EdgeInsets.all(16),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Text(
  //                 'หมายเลขคำสั่งซื้อ ${orderDetail.data!.orderId}',
  //                 style: TextStyle(
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               SizedBox(height: 16),
  //               Row(
  //                 children: [
  //                   CircleAvatar(
  //                     radius: 35,
  //                     backgroundImage: NetworkImage(orderDetail.data!.customer!.profileImageUrl!),
  //                   ),
  //                   const SizedBox(width: 10),
  //                   Expanded(
  //                     child: Container(
  //                       child: ListTile(
  //                         title: Text(
  //                           orderDetail.data!.customer!.username!,
  //                         ),
  //                         subtitle: Text(
  //                           orderDetail.data!.destination!.name!+" "+orderDetail.data!.destination!.address!+" "+orderDetail.data!.destination!.street!+" "+orderDetail.data!.destination!.building!+" "+orderDetail.data!.destination!.district!+" "+orderDetail.data!.destination!.amphure!+" "+orderDetail.data!.destination!.province!+" "+orderDetail.data!.destination!.zipcode!+" "+orderDetail.data!.destination!.phoneNumber!,
  //                           style: GoogleFonts.prompt(), // ใช้ Prompt font ที่ต้องการ
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Container(
  //               height: 200, // Adjust the height as needed
  //               child: ListView.builder(
  //                     shrinkWrap: true,
  //                     itemCount: orderDetail.data!.items!.cart!.length,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       Cart data = orderDetail.data!.items!.cart![index];
  //                       return testr(data, context);
  //                     },
  //                   ),
  //               ),
  //               // _buildItemList(orderDetail),
  //               Text(
  //                 "Note : ${orderDetail.data!.note!}",
  //               ),
  //               Center(
  //                 child: (() {
  //                   switch (status) {
  //                     case "preparing":
  //                       return but(orderDetail, status);
  //                     case "waiting_for_delivery":
  //                       return but(orderDetail, status);
  //                     case "on_the_way":
  //                       return but(orderDetail, status);
  //                     default:
  //                       return null;
  //                   }
  //                 })(),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

//  Future<void> _showModal(BuildContext context,String Token,String status) async {
//     InOrderModel orderDetail = await transaction.getInOrder(Token);
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'หมายเลขคำสั่งซื้อ ${orderDetail.data!.orderId}',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 16),
//               Row(
//                 children: [
//                   CircleAvatar(
//                             radius: 35, // Adjust the radius as needed
//                             backgroundImage: NetworkImage(orderDetail.data!.customer!.profileImageUrl!),
//                           ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: Container(
//                         child: ListTile(
//                           title: Text(
//                             orderDetail.data!.customer!.username!,
//                             style: GoogleFonts.prompt(), // ใช้ Prompt font ที่ต้องการ
//                           ),
//                           subtitle: Text(
//                             orderDetail.data!.destination!.name!+" "+orderDetail.data!.destination!.address!+" "+orderDetail.data!.destination!.street!+" "+orderDetail.data!.destination!.building!+" "+orderDetail.data!.destination!.district!+" "+orderDetail.data!.destination!.amphure!+" "+orderDetail.data!.destination!.province!+" "+orderDetail.data!.destination!.zipcode!+" "+orderDetail.data!.destination!.phoneNumber!,
//                             style: GoogleFonts.prompt(), // ใช้ Prompt font ที่ต้องการ
//                           ),
//                           // tileColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                 ]
//               ),
//               _buildItemList(orderDetail),
//               Text(
//                 "Note : "+orderDetail.data!.note!,
//                 style: GoogleFonts.prompt(), // ใช้ Prompt font ที่ต้องการ
//               ),
//               Center(
//                   child: (() {
//                     switch (status) {
//                       case "preparing":
//                         return but(orderDetail,status);
//                       case "waiting_for_delivery":
//                         return but(orderDetail,status);
//                       case "on_the_way":
//                         return but(orderDetail,status);
//                       default:
//                         return null;
//                     }
//                   })(),
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }
  but(orderDetail,status){
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: ElevatedButton(
        onPressed: () {
          switch (status) {
            case "preparing":
              return upStat(orderDetail.data!.orderToken,orderDetail.data!.orderId,"waiting_for_delivery");
            case "waiting_for_delivery":
              return upStat(orderDetail.data!.orderToken,orderDetail.data!.orderId,"on_the_way");
            case "on_the_way":
              return upStat(orderDetail.data!.orderToken,orderDetail.data!.orderId,"done");
            default:
              return null;
          }
        },
        child: (() {
          switch (status) {
            case "preparing":
              return Text("เตรียมของเสร็จเรียบร้อย");
            case "waiting_for_delivery":
              return Text("ไรเดอร์มารับเรียบร้อย");
            case "on_the_way":
              return Text("ส่่งสำเร็จเรียบร้อย");
            default:
              return null;
          }
        })(),
      ),
    );
  }
  Widget _buildItemList(InOrderModel orderDetail) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: orderDetail.data!.items!.cart!.length,
      itemBuilder: (BuildContext context, int index) {
        Cart data = orderDetail.data!.items!.cart![index];
        return testr(data, context);
      },
    );
  }
// void _showProductDetailsDialog(BuildContext context, ProductsData data) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text("รายการสินค้าที่ ${data.productOrder}"),
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             popupdata((data))
//             // Add more details as needed
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//             },
//             child: Text('Close'),
//           ),
//         ],
//       );
//     },
//   );
// }