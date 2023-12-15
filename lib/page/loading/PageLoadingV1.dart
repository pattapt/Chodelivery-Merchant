import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class PageLoadingV1 extends StatefulWidget {
  const PageLoadingV1({Key? key}) : super(key: key);
  @override
  State<PageLoadingV1> createState() => _PageLoadingV1State();
}

class _PageLoadingV1State extends State<PageLoadingV1>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "assets/animation/97930-loading.json",
                      width: 200,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      "กำลังโหลดข้อมูล",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "กำลังโหลดข้อมูลอยู่ กรุณารอสักครู่",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
