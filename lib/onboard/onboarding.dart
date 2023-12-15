import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});
  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late PageController _pageController;

  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: false);
    _pageController.addListener(onPageChanged);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged() async {
    final index = _pageController.page!.toInt();
    if (index == 3) {
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled) {
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            // User Always denoed permission
          }
        }
        if (permission == LocationPermission.deniedForever) {
          // User has denied permission forever
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: onboardData.length,
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  pageIndex = index;
                });
              },
              itemBuilder: (context, index) => OnboardContent(
                image: onboardData[index].image,
                animation: onboardData[index].animation,
                title: onboardData[index].title,
                description: onboardData[index].description,
              ),
            ),
          ),
          Row(
            children: [
              ...List.generate(
                onboardData.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Dotindicator(isActive: index == pageIndex),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 60,
                width: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    if (pageIndex == onboardData.length - 1) {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool('onboard', true);
                      await Navigator.pushNamed(context, "/Login");
                    }
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 300), curve: Curves.ease);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Icon(Icons.arrow_forward, size: 30),
                ),
              ),
            ],
          ),
        ],
      ),
    )));
  }
}

class Dotindicator extends StatelessWidget {
  const Dotindicator({
    super.key,
    this.isActive = false,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.primary.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class Onboard {
  final String image;
  final String animation;
  final String title;
  final String description;

  Onboard(
      {required this.image,
      required this.animation,
      required this.title,
      required this.description});
}

final List<Onboard> onboardData = [
  Onboard(
    title: 'สวัสดีนี่คือ ChoDelivery',
    description: 'แอพพลิเคชั่นสั่งของจากร้านโชห่วยใกล้บ้านคุณ แบบสับๆ',
    image: 'assets/images/emergency_icon/SOS.png',
    animation: 'assets/animation/42618-welcome.json',
  ),
  Onboard(
    title: 'เลือกซื้อสินค้าสบายๆ',
    description:
        'สั่งซื้อสินค้าง่ายๆแล้วรอรับสินค้าที่บ้านได้เลย ไม่ต้องเสียเวลาออกมาซื้อเองอีกต่อไปแล้ว',
    image: 'assets/images/emergency_icon/SOS.png',
    animation: 'assets/animation/animation1697692696735.json',
  ),
  Onboard(
    title: 'ติดต่อร้านค้าได้ง่ายๆ แค่แชท',
    description:
        'หากคุณพบปัญหาในการสั่งซื้อ ก็สามารถติดต่อร้านค้าได้ง่ายๆผ่านเมนูแชทภายในแอพพลิเคชั่น',
    image: 'assets/images/emergency_icon/SOS.png',
    animation: 'assets/animation/animation1697693011763.json',
  ),
  Onboard(
    title: 'ให้สิทธิ์การเข้าถึงตำแหน่งกับเรา',
    description:
        'เราจำเป็นต้องใช้ตำแหน่งที่ตั้งของคุณในการระบุสถานที่จัดส่งให้กับคุณ โปรดอนุญาติให้เราสามารถเข้าถึงตำแหน่งที่ตั้งของคุณได้ เพื่อเริ่มต้นใช้งาน',
    image: 'assets/images/emergency_icon/SOS.png',
    animation: 'assets/animation/animation1697693228878.json',
  ),
];

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.animation,
  });

  final String image, animation, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Lottie.asset(
          animation,
          width: 350,
          fit: BoxFit.fill,
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.prompt(
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: GoogleFonts.prompt(
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}