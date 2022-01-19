//Author said mmevela

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
    : id =json['id'],
      text=json['text'],
      image=json['image'],
      tags=json['tags'],
      likes=json['likes'],
      publishDate=json['publishDate'],
      owner=new Owner.fromJson(json['owner']);

}

class Comment{
  String message,id,publishDate,post;
  Owner owner;

  Comment.fromJson(Map json)
    : id =json['id'],
      message=json['message'],
      post=json['post'],
      publishDate=json['publishDate'],
      owner=new Owner.fromJson(json['owner']);

}