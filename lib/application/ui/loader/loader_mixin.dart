import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin LoaderMixin on GetxController {
  void loaderListener(RxBool isLoading) {
    ever<bool>(isLoading, (loading) async {
      if (loading) {
        await Get.dialog(
          const Center(
            child: CircularProgressIndicator(),
          ),
          barrierDismissible: false,
        );
      } else {
        Get.back();
      }
    });
  }
}
