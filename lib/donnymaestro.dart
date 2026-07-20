import 'package:donnymaestro/routes/app_route.dart';
import 'package:donnymaestro/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';

class Donnymaestro extends StatelessWidget {
  const Donnymaestro({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '48 Date',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      builder: (context, child) {
        AppScreenUtil.init(context);
        return EasyLoading.init()(context, child);
      },
    );
  }
}
