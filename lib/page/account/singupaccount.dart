import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:showd_delivery/class/auth.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/page/account/accountContent.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpContent extends StatefulWidget {
  const SignUpContent({Key? key}) : super(key: key);
  @override
  State<SignUpContent> createState() => _SignUpContentState();
}

class _SignUpContentState extends State<SignUpContent>
    with TickerProviderStateMixin {
  final scrollController = ScrollController();
  final textFieldFocusNodePassword = FocusNode();
  final textFieldFocusNodeConfirm = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ckpasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();

  bool _obscuredPassword = true;
  bool _obscuredConfirmPassword = true;

  void _toggleObscuredPassword() {
    setState(() {
      _obscuredPassword = !_obscuredPassword;
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    ckpasswordController.dispose();
    nameController.dispose();
    lastnameController.dispose();
    textFieldFocusNodePassword.dispose();
    textFieldFocusNodeConfirm.dispose();
    super.dispose();
  }

  // Create Account Widget
  Widget _CreateAccount() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center, // Center vertically
      crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
      children: [
        Text(
          "Create Account",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5CABFF),
          ),
        ),
        Text(
          "Create A New Account",
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
          child: const Text("Name"),
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
                Icons.person,
                color: Color.fromARGB(255, 5, 128, 228),
              ),
            ),
          ),
        ),
      ],
    );
  }

//Email
  Widget _CreateEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: const Text("Email"),
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              prefixIcon: Icon(
                Icons.email_rounded,
                color: Color.fromARGB(255, 5, 128, 228),
              ),
            ),
          ),
        ),
      ],
    );
  }

//Phone
  Widget _CreateLastTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: const Text("Lastname"),
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: lastnameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              prefixIcon: Icon(
                Icons.person,
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

//LoginBtn
  Widget _CreateLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          String email = emailController.text;
          String name = nameController.text;
          String last = lastnameController.text;
          String password = passwordController.text;
          String cpassword = ckpasswordController.text;
          reg(email,name,last,password,cpassword);
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
        print('Your Account Has Been Successfully Created.');

        // Navigator.push(context, MaterialPageRoute(builder: (context) => , ));
        Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AccountContent()),
                    );
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: "Already have a account ?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            WidgetSpan(
              child: SizedBox(width: 10),
            ),
            TextSpan(
              text: "Login",
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
          _CreateEmailTF(),
          const SizedBox(height: 20),
          _CreateUsernameTF(),
          const SizedBox(height: 20),
          _CreateLastTF(),
          const SizedBox(height: 20),
          _CreatePasswordTF(),
          const SizedBox(height: 20),
          _CreateConfirmPw(),
          const SizedBox(height: 20),
          _CreateLoginBtn(),
          const SizedBox(height: 10),
          _LoginAccountBtn()
          // Add other signup elements/widgets here
        ],
      ),
    );
  }
}
