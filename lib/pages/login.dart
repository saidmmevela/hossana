//Author said mmevela
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hossana/pages/list.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey =GlobalKey<FormState>();

   //formfield controller variables;
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  void login()async{
      Map log={
        "email":_username.text,
        "password":_password.text
      };
    var  Url="https://reqres.in/api/login";
    try {
      var response =await http.post(Uri.parse(Url), body:log).timeout(Duration(seconds: 30));
      var data = jsonDecode(response.body);
      var bytess = response.body;
      print('class1:${response.statusCode}');
      print('class1:${bytess}');

      if(response.statusCode == 200){
          Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context)=>
                        ListItems()
                      )
                    );
      }else{
        var err=data["error"];
        showDialog(
            context: context, 
            barrierDismissible: false,
            builder: (BuildContext context){
              return AlertDialog(
                title: Center(child:  Text(err,textAlign: TextAlign.center,style: TextStyle(),)),
                actions: <Widget>[
                  TextButton(
                  onPressed:(){
                    Navigator.of(context).pop();
                  }, 
                  child: const Text("ok")),
                ],
              );
            }
          );
      }
      
      
    }
    on SocketException{
        showDialog(
            context: context, 
            barrierDismissible: false,
            builder: (BuildContext context){
              return AlertDialog(
                title: Center(child:  Text("Check your internet connection",textAlign: TextAlign.center,style: TextStyle(),)),
                actions: <Widget>[
                  TextButton(
                  onPressed:(){
                    Navigator.of(context).pop();
                  }, 
                  child: const Text("ok")),
                ],
              );
            }
        );
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            
            children: [
              SizedBox(height: MediaQuery.of(context).size.height/4),
              Center(child: Text("Login",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey[900],fontSize: 20),)),
              SizedBox(height: 35),
              Form(
                key:_formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/1.3,
                      decoration:BoxDecoration(
                        color: Colors.blueGrey[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _username,
                        decoration: const InputDecoration(
                            hintText: "Username",
                            enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          
                          ),
                        validator:(username){
                          if(username!.isEmpty){
                            return "Please enter username";
                          }
                          return null;
                        }
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width/1.3,
                      decoration:BoxDecoration(
                        color: Colors.blueGrey[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _password,
                        decoration: const InputDecoration(
                          hintText: "password",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10)
                          ),
                          
                        obscureText: true,
                        validator:(password){
                          if(password!.isEmpty){
                            return "Please enter password";
                          }
                          return null;
                        }
                      ),
                    ),
                    SizedBox(height: 15),
                    OutlinedButton(
                      child: Container(
                        width:MediaQuery.of(context).size.width/1.5,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(child: Text("Login")),
                        )
                      ),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        onSurface: Colors.red,
                        
                        backgroundColor: Colors.blue,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                        )
                      ),
                      
                      onPressed: () async {
                        if(_formKey.currentState!.validate()){
                            
                          login();
                        }
                        
                      }
                      
                    ), 
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
//Author said mmevela