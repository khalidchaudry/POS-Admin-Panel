import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplecashier/provider/theme_provider.dart';
import 'package:simplecashier/view/screens/home_screen/home_screen.dart';
import 'package:simplecashier/view/utils/constants.dart';

class SearchDelegateWidget extends SearchDelegate{
  final searchFireStore=firestore.collection('products').snapshots();
  String name='';
  String image='';
  @override
  List<Widget>? buildActions(BuildContext context) =>[IconButton(onPressed: (){
   query='';
  }, icon: const Icon(Icons.clear,color: Colors.red,))];

  @override
  Widget? buildLeading(BuildContext context) =>IconButton(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context)=>InkWell(
                      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>const HomeScreen())),
                      child: 
                      Center(
                        child: SingleChildScrollView(
                          child: Container(   
                                        width: double.infinity,
                          decoration: BoxDecoration(
                                            
                                      
                                        borderRadius: BorderRadius.circular(15),
                                ),
                                    child:  Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:  [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                                        child: Image.network(image,
                                      
                                          height: MediaQuery.of(context).size.height*.8,
                                         
                                        ),
                                      ),
                                      const SizedBox(height: 8,),
                                      Text(name,textAlign: TextAlign.center,
                                      style: Provider.of<ThemeProvider>(context).darkTheme? const TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20):const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20)),
                                      
                                    ],)),
                        ),
                      ),
                    );

  @override
  Widget buildSuggestions(BuildContext context) {
    
    return StreamBuilder<QuerySnapshot>(
      stream: searchFireStore,
      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasData) {
       
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 16.0),
            child: ListTile(
              
              onTap: (){
                name=snapshot.data!.docs[index]['ProductName'];
                 image=snapshot.data!.docs[index]['ProductImage'];
                query=name;
                showResults(context);
              },
              
             dense: true,
                enabled: true,
                tileColor: Colors.white,
                shape: const StadiumBorder(),
                
             
              title:Text(snapshot.data!.docs[index]['ProductName'],textAlign: TextAlign.center,style: const TextStyle(color: Colors.black),)),
          );
        });
      }
      else{
        return const Center(child: CircularProgressIndicator(backgroundColor: Colors.green,),);
      }
    });
  }
  
}