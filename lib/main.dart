// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_local_database/language/lang.dart';
import 'package:notes_local_database/language/lang_controlllrt.dart';
import 'package:notes_local_database/screen/add_note.dart';
import 'package:notes_local_database/screen/edit_note.dart';
import 'package:notes_local_database/screen/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sPreferences;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 sPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LangController langController =  Get.put(LangController());
    return GetMaterialApp(
      locale: langController.inLang,
      translations: MyLang(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home:const HomeScreen(),
      routes: {
         "home" :  (context) => const HomeScreen(),
         "addnote" : (context) => const AddNote(),
         "editnote" : (context) => const EditNote(),
      } ,
      
    );
  }
}
 