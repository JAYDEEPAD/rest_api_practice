import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_practice/Models/UserModel.dart';


void main(){
  runApp(MaterialApp(title: "RestAPi with UserModel",home: ExampleThreeScreen(),));
}
class ExampleThreeScreen extends StatefulWidget {
  const ExampleThreeScreen({Key? key}) : super(key: key);

  @override
  State<ExampleThreeScreen> createState() => _ExampleThreeScreenState();
}

class _ExampleThreeScreenState extends State<ExampleThreeScreen> {

  List<UserModel> userList=[];

  Future<List<UserModel>> getuserApi() async{
    final response= await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map i in data){
        print(i['name']);
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }
    else{
      return userList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Nested object api"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getuserApi(),
                builder: (context,AsyncSnapshot<List<UserModel>>snapshot){
              if(!snapshot.hasData){
                return CircularProgressIndicator();
              }
              else{
                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context,index){
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ReuseableRow(name: "Name", value: snapshot.data![index].name.toString()),
                              ReuseableRow(name: "Email", value: snapshot.data![index].email.toString()),
                              ReuseableRow(name: "Address", value: snapshot.data![index].address.toString()),
                              ReuseableRow(name: "Company", value: snapshot.data![index].company.toString())
                            ],
                          ),
                        ),
                      );
                    });
              }
            }),
          )
        ],
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String name,value;
  ReuseableRow({Key? key, required this.name,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text(value)
        ],
      ),
    );
  }
}
