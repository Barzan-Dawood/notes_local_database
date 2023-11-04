
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notes_local_database/main.dart';

class LangController extends GetxController {
  
    Locale inLang = 
   sPreferences!.getString("lang") == null 
   ? Get.deviceLocale! 
   : Locale(sPreferences!.getString("lang")!);

  void changeLang(String codelang){
    Locale locale = Locale(codelang);
    sPreferences!.setString("lang", codelang);
    Get.updateLocale(locale);

  }
} 
