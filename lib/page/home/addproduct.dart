import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:showd_delivery/class/Product.dart';


class AddProd extends StatefulWidget {
  const AddProd({Key? key}) : super(key: key);

  @override
  State<AddProd> createState() => _AddProdState();
}

class _AddProdState extends State<AddProd> with TickerProviderStateMixin {
  final scrollController = ScrollController();
  final nameProductController = TextEditingController();
  final serialProductController = TextEditingController();
  final stockAmountController = TextEditingController();
  final priceController = TextEditingController();
  final descProductController = TextEditingController();
  final List<String> items = ['นม หรือของหวาน', 'น้ำดื่มหรือกาแฟ', 'ขนม ของอร่อย', 'ของใช้ภายในบ้าน','เครื่องครัว', 'ขนมปัง', 'อาหารพร้อมทาน', 'ครีม/เครื่องสำอาง'];
  String selectedItem = 'นม หรือของหวาน';
  
  File? _image;

  get args => null;

  @override
  void dispose() {
    nameProductController.dispose();
    super.dispose();
  }
  void create(name,desc,quantity,price,barcode,cat,img) async{
      dynamic tt = await Product.createItem(name,desc,quantity,price,barcode,cat,img);
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('เพิ่มรายการสินค้า')
          ),
        body: SingleChildScrollView(
          controller: scrollController,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-0.06, -0.83),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Container(
                        width: 371,
                        height: 1050,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Color(0x33000000),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1.00, -1.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    30, 20, 0, 0),
                                child: Text(
                                  'ชื่อรายการสินค้า',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1.00, -1.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 30, 20, 0),
                                child: TextFormField(
                                  controller: nameProductController,
                                  decoration: InputDecoration(
                                    labelText: 'ชื่อรายการสินค้า',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1.00, -1.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    30, 20, 0, 0),
                                child: Text(
                                  'รายละเอียดสินค้า',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1.00, -1.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 30, 20, 0),
                                child: TextFormField(
                                  controller: descProductController,
                                  decoration: InputDecoration(
                                    labelText: 'รายละเอียดสินค้า',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1.00, -1.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    30, 30, 0, 0),
                                child: Text(
                                  'Serial Number',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1.00, -1.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 0),
                                child: TextFormField(
                                  controller: serialProductController,
                                  decoration: InputDecoration(
                                    labelText: 'รหัสสินค้า',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1.00, -1.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    30, 20, 0, 0),
                                child: Text(
                                  'เพิ่มรูปภาพสินค้า',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                              child: _image == null
                                  ? ElevatedButton(
                                      onPressed: () {
                                        getImage();
                                      },
                                      child: Text('เลือกรูปภาพ'),
                                    )
                                  : Image.file(
                                      _image!,
                                      height: 100,
                                      width: 100,
                                    ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1.00, -1.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    30, 30, 0, 0),
                                child: Text(
                                  'จำนวนสินค้า',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1.00, -1.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 0),
                                child: TextFormField(
                                  controller: stockAmountController,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'จำนวน',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1.00, -1.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    30, 30, 0, 0),
                                child: Text(
                                  'ราคาสินค้า',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1.00, -1.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 0),
                                child: TextFormField(
                                  controller: priceController,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'ราคาสินค้า',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [ 
                                    SizedBox(width: 5),
                                    DropdownButton<String>(
                                      value: selectedItem,
                                      onChanged: (String? newValue) {
                                        if (newValue != null) {
                                          setState(() {
                                            selectedItem = newValue;
                                          });
                                        }
                                      },
                                      items: items.map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.all(30.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  String  name = nameProductController.text;
                                  int  quantity = int.parse(stockAmountController.text);
                                  int  price= int.parse(priceController.text);
                                  String  barcode = serialProductController.text;
                                  String descrip = descProductController.text;
                                  int cat=0;
                                  switch(selectedItem){
                                    case 'นม หรือของหวาน':
                                      cat=1;
                                    case 'น้ำดื่มหรือกาแฟ':
                                      cat=2;
                                    case 'ขนม ของอร่อย':
                                      cat=3;
                                    case 'ของใช้ภายในบ้าน':
                                      cat=4;
                                    case 'เครื่องครัว':
                                      cat=5;
                                    case 'ขนมปัง':
                                      cat=6;
                                    case 'อาหารพร้อมทาน':
                                      cat=7;
                                    case 'ครีม/เครื่องสำอาง':
                                      cat=8;
                                  }
                                  create(name,descrip,quantity,price,barcode,cat,_image);
                                },
                                child: Text('เพิ่มรายการสินค้า'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Add more widgets here
                ],
              ),
            ),
          ),
        ),
      ),
      
    );
  }
 
}

