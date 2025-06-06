import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12))),
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Icon(
                    Icons.menu,
                    size: 28,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.offAllNamed("/home");
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      width: 200,
                      height: 50,
                      "assets/image/logo_cfc.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
