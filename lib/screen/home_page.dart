
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_local_database/backend/sqldb.dart';
import 'package:notes_local_database/language/lang_controlllrt.dart';
import 'package:notes_local_database/screen/edit_note.dart';
 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

 bool isloding = true;
 List notess = [];

 SqlDb sqlDb = SqlDb();
 Future  readData()async{

    // طريقة الاولى
  // List<Map> res = await sqlDb.read("SELECT * FROM notes");

    //طريقة الثانية
     List<Map> res = await sqlDb.read("notes");

   notess.addAll(res);
   isloding = false;
   if(this.mounted){
    setState(() {
    });
   }
 }

 @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    LangController langController = Get.find();
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Home Page".tr,style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),

       drawer:   Drawer(
        backgroundColor: Colors.purple,
           child:   Column(
            children: [
              const SizedBox(height: 100),
              Text("Note App".tr,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
        const SizedBox(height: 50),
              ListTile(
                title: ElevatedButton.icon(onPressed: () {
                   if(Get.isDarkMode){
                    Get.changeTheme(ThemeData.light());
                   }
                   else{
                     Get.changeTheme(ThemeData.dark());
                   }
                },
                 icon: const Icon(Icons.dark_mode),
                  label:   Text("Theme".tr)),
              ),
 
               ListTile(
                title: ElevatedButton.icon(onPressed: () {
                   
                     showDialog(context: context, builder: (context){
              return   Expanded(
                child: AlertDialog(
                  backgroundColor: Colors.greenAccent,
                
                  actions: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
              
                      Center(child: TextButton(onPressed: (){
                           langController.changeLang("ar");
                            Get.back();
                      }, child:  Text("Arbic".tr,
                      style: const TextStyle(color: Colors.black,fontSize: 20),))),
            const Divider(color: Colors.red,),
                      Center(child: TextButton(onPressed: (){
                           langController.changeLang("en");
                              Get.back();
                      }, child:  Text("English".tr,
                      style: const TextStyle(color: Colors.black,fontSize: 20),))),
                      
                      ],
                    ),
                   
                  ],
                ),
              );
            });
                },
                 icon: const Icon(Icons.language),
                  label:   Text("Language".tr)),
              ),
               ListTile(
                title: ElevatedButton.icon(onPressed: () {
                 
                },
                 icon: const Icon(Icons.help_outline_rounded),
                  label:   Text("about".tr)),
              ),

             
            ],
          ),
       ),

            floatingActionButton: FloatingActionButton(backgroundColor: Colors.blue,
              onPressed: (){
            
           Navigator.of(context).pushNamed("addnote");
                    
            }, child: const Icon(Icons.add),),
     
      body: isloding == true ?  Center(child: CircularProgressIndicator()) :  Padding(
        padding:  const EdgeInsets.all(10),
        child:  Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                reverse: true,
                itemCount: notess.length,
                itemBuilder: (context , i){
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.purple
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.only(top: 8,bottom: 20),
                      child: Column(
                        children: [
                         
                      InkWell(
                        onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context){
                          return EditNote(
                            
                            titleCons: notess[i]['title'],
                            subTitleCons: notess[i]['note'],
                            idCons: notess[i]['id'],
            
                          );   
                        })
                      );
                        },
                        child:  Container(
                          height: 44,
                          
                          child: ListTile( 
                             
                              title: Text("${notess[i]['title']}"),
                              subtitle:  Text("${notess[i]['note']}"),
                              trailing: IconButton(onPressed: ()async{
                         // طريقة الاولى
                        //  int res = await sqlDb.deleteData
                        //  ("DELETE FROM notes WHERE id = ${notess[i]['id']}");
              
              //طريقة الثانية
                        int res = await sqlDb.delete("notes", "id = ${notess[i]['id']}");
                  
                    if(res > 0){
                      notess.removeWhere((el) => el['id'] == notess[i]['id']);
                      setState(() {
                        
                      });
                    }
                              }, icon: const Icon(Icons.delete)),
                            ),
                        ),
                      ),
                      //  Padding(
                      //   padding:  EdgeInsets.only(left: 180),
                      //   child: Text("${DateTime.now().hour}"),
                      // )
                    ],
                  ),
                    ),
                  ),
                );
                }),
               
          ],
        ),
      ),
    );
  }
}
