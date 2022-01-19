//Author said mmevela
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hossana/pages/dataformat.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {
  const Detail({ Key? key,required this.post }) : super(key: key);
  final Post post;
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  List<Comment> comments=[];

  void getComments()async{
    String id=widget.post.id;
    var Url="https://dummyapi.io/data/v1/post/${id}/comment?limit=10";
    

    try {
          var response =await http.get(Uri.parse(Url),headers:{'app-id': '61e6b80fb55ecf7337e92cf9'}).timeout(Duration(seconds: 30));
          var data = jsonDecode(response.body);
          var data1=data["data"];
          Iterable comnt =data1;
          print('class1:${response.statusCode}');
          print('class2:${response.body}');
          setState(() {
            comments=comnt.map((model)=>Comment.fromJson(model)).toList();
            
          });
          
        }
        on SocketException{
          
        }
  }

  @override
  void initState() {
    super.initState();
    var id=widget.post.id;
    getComments();

  }

  @override
  Widget build(BuildContext context) {
    var user=widget.post.owner;
    var tag=widget.post.tags;
    return Scaffold(
      appBar: AppBar(
        title:Center(
          child: Text("${widget.post.owner.title} ${widget.post.owner.firstname} Post",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
              ),
        ),
        backgroundColor: Colors.blue,
      ),
      body:Container(
        child:Padding(
          padding: const EdgeInsets.only(top: 4,bottom: 8),
          child: ListView(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4,bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8,left: 8),
                        child: Row(
                          children:[
                            CircleAvatar(
                              radius:20,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                    user.picture,
                                    height:50,
                                    fit: BoxFit.fill,
                                  
                                  ),
                                  ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                  "${user.title} ${user.firstname} ${user.lastname}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    
                                  ),
                              ),
                            ),
                          ]
                            
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 8,bottom: 8),
                          child:Image.network(
                                  widget.post.image,
                          
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8,left: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Icon(Icons.favorite,color: Colors.red,),
                                ),
                                Text("${widget.post.likes}"),
                              ]
                            ),
                            Row(
                              children:List.generate(tag.length, (index){
                                return
                                Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Container(
                                    decoration:BoxDecoration(
                                      color: Colors.pink,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(tag[index],style:TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                );
    
                              })
                            )
                            
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10,left: 10,top: 4),
                        child: Text(
                            widget.post.text,
                            style: TextStyle(
                              fontSize: 15,
                              
                            ),
                        ),
                      ),
                    ]
                  ),
                ),
              ),
              Column(
                children: List.generate(comments.length, (index){
                  var owner=comments[index].owner;
                  return
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration:BoxDecoration(
                        color: Colors.blueGrey[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius:20,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(50),
                                                child: Image.network(
                                              owner.picture,
                                              height:50,
                                              fit: BoxFit.fill,
                                            
                                            ),
                                            ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("${owner.title} ${owner.firstname} ${owner.lastname}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey[700])),
                                              Text(
                                                  comments[index].publishDate,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    
                                                  ),
                                              ),
                                             ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                    comments[index].message,
                                    style: TextStyle(
                                      fontSize: 15,
                                      
                                    ),
                                ),
                              ],
                            )
                          
                        ) ,
                      ),
                    );
                }
                )
              )
            ],
          ),
        )
      )
    );
  }
}
//Author said mmevela