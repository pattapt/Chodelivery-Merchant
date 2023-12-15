import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:showd_delivery/class/Merchant.dart';
import 'package:showd_delivery/class/auth.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/page/account/accountContent.dart';
import 'package:showd_delivery/page/home/GetFromZIp.dart';
import 'package:showd_delivery/struct/ProvModel.dart' as p;
import 'package:showd_delivery/struct/ProvModel.dart';
import 'package:url_launcher/url_launcher.dart';

class CreateStore extends StatefulWidget {
  const CreateStore({Key? key}) : super(key: key);
  @override
  State<CreateStore> createState() => _CreateStoreState();
}


class _CreateStoreState extends State<CreateStore>
    with TickerProviderStateMixin {
  final scrollController = ScrollController();
  final textFieldFocusNodePassword = FocusNode();
  final textFieldFocusNodeConfirm = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController storenameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ckpasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController amphoeController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController zipcodeController= TextEditingController();
  TextEditingController PhonenumController= TextEditingController();
  File? _image;
  bool showAmp = false;
  bool showProv = false;

  bool _obscuredPassword = true;
  bool _obscuredConfirmPassword = true;
  ProvModel datazip=ProvModel();
  int dis = 0;
  int amp = 0;
  int prov = 0;
  int selectedItem = 0;

  void _toggleObscuredPassword() {
    setState(() {
      _obscuredPassword = !_obscuredPassword;
    });
  }
  void _showAmp() {
    setState(() {
      showAmp = true;
    });
  }
  void _showProv() {
    setState(() {
      showProv = true;
    });
  }
  void reg(email,name,last,pass,cpass) async{
    if(pass==cpass){
      dynamic tt = await Auth.initRegisterEmail(email,pass,name,last);
    }
    else{
      Chodee.showDailogCSG(
          "ไม่สามารถทำรายการได้", "รหัสผ่านไม่ถูกต้อง", "ปิด");
    }
      }
  void _toggleObscuredConfirmPassword() {
    setState(() {
      _obscuredConfirmPassword = !_obscuredConfirmPassword;
    });
  }

  void _navigateToSelectItemPage(zip) async {
    ProvModel zipdata = await Merchant.getProv(zip);
    
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectItemPage(data: zipdata)),
    );

    if (result != null) {
      setState(() {
        selectedItem = result;
      });
    }
    districtController.text = zipdata.data![selectedItem].district!.nameTh!;
    amphoeController.text = zipdata.data![selectedItem].amphure!.nameTh!;
    provinceController.text = zipdata.data![selectedItem].province!.nameTh!;
    dis = zipdata.data![selectedItem].district!.districtId!;
    amp = zipdata.data![selectedItem].amphure!.amphureId!;
    prov = zipdata.data![selectedItem].province!.provinceId!;
  }
  @override
  void initState() {
    districtController.text = "เลือกตำบล/แขวง";
    amphoeController.text = "เลือกอำเภอ/เขต";
    provinceController.text = "เลือกจังหวัด";
    super.initState();
  }

  @override
  void dispose() {
    storenameController.dispose();
    passwordController.dispose();
    ckpasswordController.dispose();
    nameController.dispose();
    addressController.dispose();
    streetController.dispose();
    buildingController.dispose();
    districtController.dispose();
    amphoeController.dispose();
    provinceController.dispose();
    zipcodeController.dispose();
    PhonenumController.dispose();
    textFieldFocusNodePassword.dispose();
    textFieldFocusNodeConfirm.dispose();
    super.dispose();
  }
  void create(name,desc,tel,addr,st,buildi,dis,amp,prov,zip,img) async{
    Merchant.createStore(name,desc,tel,addr,st,buildi,dis,amp,prov,zip,img);
  }
  Future getImage() async {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _image = File(image.path);
        });
      }
    }
  // Create Account Widget
  Widget _CreateAccount() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center, // Center vertically
      crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
      children: [
        Text(
          "Create Store",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5CABFF),
          ),
        ),
        Text(
          "สร้างร้านค้าของคุณ",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

//Username
  Widget _CreateUsernameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: const Text("Description Store"),
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: nameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              prefixIcon: Icon(
                Icons.note_add,
                color: Color.fromARGB(255, 5, 128, 228),
              ),
            ),
          ),
        ),
      ],
    );
  }

//storename
  Widget _CreateStorenameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: const Text("Store name"),
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: storenameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              prefixIcon: Icon(
                Icons.store_mall_directory_rounded,
                color: Color.fromARGB(255, 5, 128, 228),
              ),
            ),
          ),
        ),
      ],
    );
  }

  


//Address
  Widget _Address() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: const Text("Address"),
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: addressController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              prefixIcon: Icon(
                Icons.location_on_outlined,
                color: Color.fromARGB(255, 5, 128, 228),
              ),
            ),
          ),
        ),
      ],
    );
  }
//street
 Widget _Street() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: const Text("Street"),
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: streetController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              prefixIcon: Icon(
                Icons.add_road_sharp,
                color: Color.fromARGB(255, 5, 128, 228),
              ),
            ),
          ),
        ),
      ],
    );
  }

//Building
 Widget _Building() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: const Text("Building"),
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: buildingController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              prefixIcon: Icon(
                Icons.domain,
                color: Color.fromARGB(255, 5, 128, 228),
              ),
            ),
          ),
        ),
      ],
    );
  }

  
 Widget _Amphoe() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: const Text("Amphoe"),
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: amphoeController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              prefixIcon: Icon(
                Icons.event_note,
                color: Color.fromARGB(255, 5, 128, 228),
              ),
            ),
          ),
        ),
      ],
    );
  }

 
 Widget _Province() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: const Text("Province"),
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: provinceController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              prefixIcon: Icon(
                Icons.event_note,
                color: Color.fromARGB(255, 5, 128, 228),
              ),
            ),
          ),
        ),
      ],
    );
  }

 Widget _Zipcode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: const Text("Zipcode"),
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: zipcodeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              prefixIcon: Icon(
                Icons.local_post_office_outlined,
                color: Color.fromARGB(255, 5, 128, 228),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
 Widget _Phonenum() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: const Text("Phone"),
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: PhonenumController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              prefixIcon: Icon(
                Icons.phone_android_rounded,
                color: Color.fromARGB(255, 5, 128, 228),
              ),
            ),
          ),
        ),
      ],
    );
  }


//district
 Widget _District() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: const Text("District"),
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: districtController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              prefixIcon: Icon(
                Icons.event_note,
                color: Color.fromARGB(255, 5, 128, 228),
              ),
            ),
          ),
        ),
      ],
    );
  }

//Password
  Widget _CreatePasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: const Text("Password"),
        ),
        Container(
          child: TextField(
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: _obscuredPassword,
            focusNode:
                textFieldFocusNodePassword, // Use the password-specific focus node
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Colors.grey.shade200,
              isDense: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.lock,
                color: Color.fromARGB(255, 5, 128, 228),
              ),
              suffixIcon: GestureDetector(
                onTap: _toggleObscuredPassword,
                child: Icon(
                  _obscuredPassword
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

//Confirm Password
  Widget _CreateConfirmPw() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: const Text("Confirm Password"),
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: ckpasswordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: _obscuredConfirmPassword,
            focusNode: textFieldFocusNodeConfirm,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Colors.grey.shade200,
              isDense: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.lock,
                color: Color.fromARGB(255, 5, 128, 228),
              ),
              suffixIcon: GestureDetector(
                onTap: _toggleObscuredConfirmPassword,
                child: Icon(
                  _obscuredConfirmPassword
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget createDist() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: const Text("District"),
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: GestureDetector(
            onTap: () {
              // Handle onTap event here

              String zip = zipcodeController.text;
              _navigateToSelectItemPage(zip);
              _showAmp();
              _showProv();
              // Add your custom logic here
            },
            child: AbsorbPointer(
              absorbing: true,
              child: TextField(
                controller: districtController,
                keyboardType: TextInputType.text,
                enabled: false, // Set this to false to make the TextField visually read-only
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  prefixIcon: Icon(
                    Icons.event_note,
                    color: Color.fromARGB(255, 5, 128, 228),
                  ),
                ),
              ),
            ),
          )
        ),
      ],
    );
  }

  Widget createAmp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: const Text("Amphoe"),
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: GestureDetector(
            onTap: () {
            },
            child: AbsorbPointer(
              absorbing: true,
              child: TextField(
                controller: amphoeController,
                keyboardType: TextInputType.text,
                enabled: false, // Set this to false to make the TextField visually read-only
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  prefixIcon: Icon(
                    Icons.event_note,
                    color: Color.fromARGB(255, 5, 128, 228),
                  ),
                ),
              ),
            ),
          )
        ),
      ],
    );
  }
  Widget createProv() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: const Text("Province"),
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: GestureDetector(
            onTap: () {
              // Handle onTap event here
              // print('TextField tapped!');
              // Add your custom logic here
            },
            child: AbsorbPointer(
              absorbing: true,
              child: TextField(
                controller: provinceController,
                keyboardType: TextInputType.text,
                enabled: false, // Set this to false to make the TextField visually read-only
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  prefixIcon: Icon(
                    Icons.event_note,
                    color: Color.fromARGB(255, 5, 128, 228),
                  ),
                ),
              ),
            ),
          )
        ),
      ],
    );
  }
  Widget InPutimg() {
  return Padding(
    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
    child: _image == null
        ? ElevatedButton(
            onPressed: () {
              // Call the function to get the image
              getImage();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue, // Set the button background color here
            ),
            child: Text(
              'เลือกรูปภาพ',
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
               // Set text color here
            ),
          )
        : Image.file(
            // Display the selected image
            _image!,
            height: 100,
            width: 100,
          ),
  );
}



//LoginBtn
  Widget _CreateLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          String name = storenameController.text;
          String desc = nameController.text;
          String tel = PhonenumController.text;
          String addr = addressController.text;
          String st = streetController.text;
          String buildi = buildingController.text;
          // int dis = zipdata;
          // int amp = amphoeController.text;
          // int prov = provinceController.text;
          String zip = zipcodeController.text;
          create(name,desc,tel,addr,st,buildi,dis,amp,prov,zip,_image);
        },
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          padding: const EdgeInsets.all(20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          primary: const Color.fromARGB(255, 5, 128, 228),
          onPrimary: Colors.white, // Text color
        ),
        child: const Text(
          'สร้างบัญชี',
          style: TextStyle(
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _LoginAccountBtn() {
    return GestureDetector(
      onTap: () {
        Auth.setIsLogin(false);
        Chodee.openPage("/Login", 1);
      },
      child: RichText(
        text: const TextSpan(
          children: [
            WidgetSpan(
              child: SizedBox(width: 10),
            ),
            TextSpan(
              text: "Logout",
              style: TextStyle(
                color: Color.fromARGB(255, 5, 128, 228),
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                _buildGradientBackground(),
                _buildContentSignup(),
              ],
            ),
          ),
        ),
      ),
    );
  }

   
  Widget _buildGradientBackground() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE3EFFF),
            Color(0xFFFFFFFF),
            Color(0xFFFFFFFF),
            Color(0xFFE3EFFF),
          ],
          stops: [0.1, 0.4, 0.7, 0.9],
        ),
      ),
    );
  }


  Widget _buildContentSignup() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
          horizontal: 40, vertical: 120.0), // Adjust the values as needed
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _CreateAccount(),
          const SizedBox(height: 40),
          _CreateStorenameTF(),
          const SizedBox(height: 20),
          _CreateUsernameTF(),
          const SizedBox(height: 10),
          _Phonenum(),
          const SizedBox(height: 20),
          InPutimg(),
          const SizedBox(height: 20),
          _Address(),
          const SizedBox(height: 20),
          _Street(),
          const SizedBox(height: 20),
          _Building(),
          const SizedBox(height: 20),
          _Zipcode(),
          const SizedBox(height: 20), 
          createDist(),
          const SizedBox(height: 20),
          showAmp
            ?createAmp()
            :const SizedBox(height: 0), 
          const SizedBox(height: 20), 
          showProv
            ?createProv()
            :const SizedBox(height: 0), 
          const SizedBox(height: 20), 
          _CreateLoginBtn(),
          const SizedBox(height: 10),
          // Add other signup elements/widgets here
          _LoginAccountBtn(),
        ],
      ),
    );
  }
}

