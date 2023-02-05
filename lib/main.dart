import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_task/app/modules/home/binding.dart';
import 'package:getx_task/app/modules/home/view.dart';
import 'app/data/services/storage/services.dart';

void main() async {
  await GetStorage.init();
  // return storage service
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo List using GetX',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    );
  }
}
