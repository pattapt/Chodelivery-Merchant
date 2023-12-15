import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:showd_delivery/class/auth.dart';
import 'package:showd_delivery/page/account/singupaccount.dart';
import 'package:showd_delivery/struct/MerchantLoginModel.dart';
import 'package:showd_delivery/struct/invokeaccesstoken.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountContent extends StatefulWidget {
  const AccountContent({Key? key}) : super(key: key);
  @override
  State<AccountContent> createState() => _AccountContentState();
}

class _AccountContentState extends State<AccountContent>
    with TickerProviderStateMixin {
  final scrollController = ScrollController();
  final textFieldFocusNode = FocusNode();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _rememberME = false;
  bool _obscured = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  void log(email,pass) async{
    dynamic tt = await Auth.initLoginEmail(email,pass);
      }
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return;
      textFieldFocusNode.canRequestFocus = false;
    });
  }

  //ชื่อแอพ+รูปภาพ
  Widget _ChoDelivery() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.shopping_basket_rounded, // Replace with the desired icon
              color: Colors.lightBlue, // Set the icon's color
              size: 45.0, // Set the icon's size
            ),
            SizedBox(width: 5), // Adjust the width as needed
            Text(
              "ChoDelivery",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Image.asset(
          'assets/images/logo/freehomedelivery.png', // Replace with your image path
          width: 250,
          height: 250,
        ),
      ],
    );
  }

//Username
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 10.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.blue, // Change the color of the icon
              ),
              hintText: "Email",
            ),
          ),
        ),
      ],
    );
  }

//Password
  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: _obscured,
            focusNode: textFieldFocusNode,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: "Password",
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
                color: Colors.blue,
              ),
              hintText: "Password",
              suffixIcon: GestureDetector(
                onTap: _toggleObscured,
                child: Icon(
                  _obscured
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

//ForgotPassword
  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(right: 0.0), // Add right padding here
        child: TextButton(
          onPressed: () {
            print('Forgot Password Button Pressed');
            // Add your action here
          },
          child: const Text('Forgot Password?'),
        ),
      ),
    );
  }

//RememberMe
  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.blue),
            child: Checkbox(
              value: _rememberME,
              checkColor: Colors.white,
              activeColor: Colors.blueAccent,
              onChanged: (Value) {
                setState(() {
                  _rememberME = Value!;
                });
              },
            ),
          ),
          const Text('Remember me')
        ],
      ),
    );
  }
//LoginBtn
  Widget _buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          String email = _emailController.text;
          String password = _passwordController.text;
          log(email,password);
        },
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          primary: const Color.fromARGB(255, 92, 171, 255),
          onPrimary: Colors.white, // Text color
        ),
        child: const Text(
          'LOGIN',
          style: TextStyle(
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _SingInWithText() {
    return const Column(
      children: <Widget>[
        Text(
          '-or-',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Text('Sing in with')
      ],
    );
  }

//SocialButton
  Widget _buildSocialButton(VoidCallback onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color.fromARGB(255, 255, 255, 255),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // Widget _buildSocialButtonBtnRow() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 10.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: <Widget>[
  //         _buildSocialButton(loginWithFacebook,
  //             const AssetImage('assets/images/logo/facebook.png')),
  //         _buildSocialButton(loginWithGoogle,
  //             const AssetImage('assets/images/logo/google.png')),
  //         // Other widgets and buttons hereÍ
  //       ],
  //     ),
  //   );
  // }

//SigupBtn
  Widget _buildSigupBtn() {
    return GestureDetector(
      onTap: () {
        print('Sign Up Button Pressed');

        // Navigator.push(context, MaterialPageRoute(builder: (context) => , ));
        Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpContent()),
                    );
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: "Don't have an Account?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            WidgetSpan(
              child: SizedBox(width: 10), // Adds space between the text spans
            ),
            TextSpan(
              text: "Sign Up",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14.0,
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: null,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                _buildGradientBackground(),
                _buildContent(),
              ],
            ),
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
            Color.fromARGB(255, 227, 239, 255),
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 227, 239, 255),
          ],
          stops: [0.1, 0.4, 0.7, 0.9],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _ChoDelivery(),
          _buildEmailTF(),
          const SizedBox(height: 10), // Replaced const SizedBox with SizedBox
          _buildPasswordTF(),
          _buildForgotPasswordBtn(),
          _buildRememberMeCheckbox(),
          _buildLoginBtn(),
          const SizedBox(height: 5), // Replaced const SizedBox with SizedBox
          _buildSigupBtn(),
        ],
      ),
    );
  }
}
