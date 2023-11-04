
// ignore_for_file: unnecessary_brace_in_string_interps, use_build_context_synchronously, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_local_database/backend/sqldb.dart';
import 'package:notes_local_database/screen/home_page.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

   final GlobalKey<FormState> formkey = GlobalKey();
   TextEditingController title = TextEditingController();
   TextEditingController subTitle = TextEditingController();

   SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurple,title: Text("Add Note".tr,
      style: TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: true,
       actions: [
           Padding(
             padding: const EdgeInsets.all(8),
             child: ElevatedButton.icon(
                       onPressed: ()async{
                  // طريقة الاولى
                // int res = await sqlDb.insertData('''
                //  INSERT INTO notes ('title' , 'note')
                //  VALUES ("${title.text}","${subTitle.text}")
                // ''');
             
                   //طريقة الثانية
                int res = await sqlDb.insert("notes",{
                   
                   "title" : "${title.text}",
                   "note" : "${subTitle.text}"
             
                });
             
                if(res > 0){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
                    return const HomeScreen();
                  }), (route) => false);
                }
                print("=======================add=======");
                print(res);
                       
                       },
             icon: const Icon(Icons.add,),
              label:  Text("Add".tr)),
           )
       ],
      ),

      body:  Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: ListView(
            children: [
                TextFormField(
                 controller: title,
                  maxLines: 1,
                  decoration:InputDecoration(
                    hintText: "Title".tr,
                    border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(20) 
                    ),
                  )
                ),
                
                const SizedBox(height: 20),
                 TextFormField(
                 controller: subTitle,
                  maxLines: 16,
                  decoration:InputDecoration(
                    hintText: "Note".tr,
                    border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(20) 
                    ),
                  )
                ),
                
            
            ],
          ),
        ),
      ),
    );
  }
}