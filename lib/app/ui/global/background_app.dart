import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackGroundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: MyCustomClipper(),
          child: Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft, end: Alignment.centerRight,
                    // colors: [Color(0xFF546E7A), Color(0xFF35454d)]
                    colors: [Colors.grey[800], Colors.grey[400]])),
          ),
        ),
        ClipPath(
          clipper: MyCustomClipperBottom(),
          child: Container(
              width: Get.width,
              height: Get.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.grey[800], Colors.grey[400]]))),
        ),
      ],
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.25);
    path.quadraticBezierTo(size.width * 0.01, size.height * 0.30,
        size.width * 0.1, size.height * 0.33);
    path.lineTo(size.width * 0.90, size.height * 0.53);
    path.quadraticBezierTo(
        size.width * 0.98, size.height * 0.54, size.width, size.height * 0.51);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MyCustomClipperBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, Get.height * 0.8);
    path.quadraticBezierTo(Get.width * 0.02, Get.height * 0.76,
        Get.width * 0.13, Get.height * 0.8);
    path.lineTo(Get.width * 0.57, size.height * 0.96);
    path.quadraticBezierTo(
        Get.width * 0.61, Get.height * 0.98, Get.width * 0.57, Get.height);

    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
