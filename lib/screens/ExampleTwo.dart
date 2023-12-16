import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main(){
  runApp(MaterialApp(title: "Api With Custome Model Class",
   home: ExampleTwoScreen(),));
}

class ExampleTwoScreen extends StatefulWidget {
  const ExampleTwoScreen({Key? key}) : super(key: key);

  @override
  State<ExampleTwoScreen> createState() => _ExampleTwoScreenState();
}

class _ExampleTwoScreenState extends State<ExampleTwoScreen> {
  List<Photos> photolist=[];
  Future<List<Photos>> getPhotos() async{
    final response=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for (Map i in data){
        Photos photos=Photos(title: i['title'], url:i['url'] ,id:i['id'] );
        photolist.add(photos);
      }
      return photolist;
    }
    else{
      return photolist;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Api without modelclass"),),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getPhotos(),
                  builder: (context,AsyncSnapshot<List<Photos>>snapshot){
                return ListView.builder(
                    itemCount: photolist.length,
                    itemBuilder: (context,index){
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                    ),
                    subtitle: Text(snapshot.data![index].title.toString()),
                    title: Text("Notice id: "+snapshot.data![index].id.toString()),
                  );
                });
              }),
            )
          ],
        )
    );
  }
}


class Photos{

  String title,url;
  int id;

  Photos({required this.title,required this.url,required this.id});
}