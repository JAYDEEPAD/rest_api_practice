
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/PostModel.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<PostModel> list=[];
  Future<List<PostModel>> getPostApi() async{
    final response= await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){

      for(Map i in data){
          list.add(PostModel.fromJson(i));
      }
      return list;
    }
    else
    {
        return list;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      children: [
          Expanded(
            child: FutureBuilder(
                future: getPostApi(),
                builder: (context,snapshot){
              if(!snapshot.hasData){
                return Text("Loading");
              }
              else{
                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context,index){
                            return Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Title\n"+list[index].title.toString()),
                                  Text("Description\n"+list[index].body.toString()),
                                  Text("id\n"+list[index].id.toString()),
                                  Text("Userid\n"+list[index].userId.toString())
                                ],
                              ),
                            );
                });
              }
            }),
          )
      ],
    ));
  }
}
