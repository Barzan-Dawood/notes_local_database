
 // ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_string_interpolations
 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_local_database/backend/sqldb.dart';
import 'package:notes_local_database/screen/home_page.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key, this.titleCons, this.subTitleCons, this.idCons});
 final titleCons;
 final subTitleCons;
 final idCons;
  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {

  final GlobalKey<FormState> formkey = GlobalKey();
   TextEditingController title = TextEditingController();
   TextEditingController subTitle = TextEditingController();

   SqlDb sqlDb = SqlDb();

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title.text = widget.titleCons;
    subTitle.text = widget.subTitleCons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurple,title: Text("Edit Note".tr,
      style: TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: true,
        actions: [
         Padding(
           padding: const EdgeInsets.all(8),
           child: ElevatedButton.icon(
            onPressed: ()async{
                 // طريقة الاولى
            //  int res = await sqlDb.updateData('''    
            //   UPDATE notes SET 
            //   title = "${title.text}",
            //   note = "${subTitle.text}"
            //   WHERE id = ${widget.idCons}
            //     ''');
           
            //طريقة الثانية
                  int res = await sqlDb.update("notes",
                   
           {
                   
                    "title" : "${title.text}",
                    "note" : "${subTitle.text}",
           },
                   "id = ${widget.idCons}"
            );
           
                if(res > 0){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
                    return const HomeScreen();
                  }), (route) => false);
                }
                print("=======================add=======");
                print(res);
            },
             icon: const Icon(Icons.check),
              label: Text("Save".tr)),
         )
        ],
      ),

      body:  Padding(
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
                maxLines: 18,
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
    );
  }
}