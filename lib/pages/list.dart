//Author said mmevela
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hossana/pages/dataformat.dart';
import 'package:http/http.dart' as http;

class ListItems extends StatefulWidget {
  const ListItems({ Key? key }) : super(key: key);

  @override
  _ListItemsState createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {

  List<Post> post=[];
  bool load=true;
  bool net=false;

  void getPost() async {

    var Url="https://dummyapi.io/data/v1/post?limit=10";
    
       
       try {
          var response =await http.get(Uri.parse(Url),headers:{'app-id': '61e6b80fb55ecf7337e92cf9'}).timeout(Duration(seconds: 30));
          var data = jsonDecode(response.body);
          var data1=data["data"];
          Iterable pst =data1;
          print('class1:${response.statusCode}');
          setState(() {
            post=pst.map((model)=>Post.fromJson(model)).toList();
            load=false;
            net=false;
          });
          
        }
        on SocketException{
         setState(() {
           load=false;
           net=true;
          });
        }
  }

 @override
  void initState() {
    super.initState();
    
    getPost();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(
          child: Text("Posts",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
              ),
        ),
        backgroundColor: Colors.blue,
      ),
      body:load? Center(child: CircularProgressIndicator()):
           net?Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                
                children: [
                  Text("No internet connection"),
                  RaisedButton(
                    onPressed: (){
                      getPost();
                    },
                    child:Text("Reload"),
                  )
                ],
              ),
            ):
          post.length==0?Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                
                children: [
                  Text("No Post"),
                  RaisedButton(
                    onPressed: (){
                      getPost();
                    },
                    child:Text("Reload"),
                  )
                ],
              ),
            ):
          ListView(
            children:List.generate(post.length, (index){
              var user=post[index].owner;
              var tag=post[index].tags;
              return
              Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8,bottom: 8),
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
                                              ) ,
                                    ]
                                      
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8,bottom: 8),
                                    child:Image.network(
                                            post[index].image,
                                    
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
                                          Text("${post[index].likes}"),
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
                                      post[index].text,
                                      style: TextStyle(
                                        fontSize: 15,
                                        
                                      ),
                                  ),
                                ),
                              ]
                      ),
                    ),
                  );
            }
            )
          )
    );
  }
}
//Author said mmevela