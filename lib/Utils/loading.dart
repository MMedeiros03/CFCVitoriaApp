import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingController extends GetxController {
  var isLoading = false.obs;

  void showLoading() {
    isLoading.value = true;
  }

  void hideLoading() {
    isLoading.value = false;
  }
}

class GlobalLoading extends StatelessWidget {
  const GlobalLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final loadingController = Get.find<LoadingController>();

      return loadingController.isLoading.value
          ? Container(
              color: Colors.black38,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : const SizedBox.shrink();
    });
  }
}
