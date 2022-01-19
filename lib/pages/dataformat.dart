//Author said mmevela
import 'dart:convert';

class Owner{
  String id,title,firstname,lastname,picture;
  Owner(this.id,this.title,this.firstname,this.lastname,this.picture);
  Owner.fromJson(Map<String, dynamic> json)
    :id=json['id'],
     title=json['title'],
     firstname=json['firstName'],
     lastname=json['lastName'],
     picture=json['picture'];
  
}

class Post{
  String text,image,id,publishDate;
  int likes;
  List<dynamic> tags=[];
  Owner owner;

  Post.fromJson(Map json)
    : id =json['_id'],
      text=json['text'],
      image=json['image'],
      tags=json['tags'],
      likes=json['likes'],
      publishDate=json['publishDate'],
      owner=new Owner.fromJson(json['owner']);

      Map toJson(){
        return {'_id':id,'text':text,'image':image,'likes':likes,'publishDate':publishDate};
      }
  
}