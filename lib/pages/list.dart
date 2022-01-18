//Author said mmevela
import 'package:flutter/material.dart';

class ListItems extends StatefulWidget {
  const ListItems({ Key? key }) : super(key: key);

  @override
  _ListItemsState createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(
          child: Text("List Items",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
              ),
        ),
        backgroundColor: Colors.blue,
      ),
      body:Container(
      child: Center(child: Text("Lists"),),
      )
    );
  }
}
//Author said mmevela