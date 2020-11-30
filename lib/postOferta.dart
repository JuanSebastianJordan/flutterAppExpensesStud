import 'database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class PostOferta{
  String nombre;
  String autor;
  String descripcion;
  String codigo;
  Set userLiked = {};
  DatabaseReference _id;

  PostOferta(this.nombre, this.autor, this.descripcion, this.codigo);

  void likePost(FirebaseUser user){
    

    if(this.userLiked.contains(user.uid)){
      this.userLiked.remove(user.uid);

    } else {
      this.userLiked.add(user.uid);
    }
    this.update();

  }

  void update(){
    updatePost(this, this._id);
  }

  void setId(DatabaseReference id){
    this._id = id;
  }

  Map<String, dynamic> toJson(){
    return{
      'nombre': this.nombre,
      'author': this.autor,
      'descripcion': this.descripcion,
      'codigo': this.codigo,
      'userLiked' : this.userLiked.toList(),


    };

  }

}

PostOferta createOferta(record) {
    Map<String, dynamic> attributes = {
      'nombre' : '',
      'author' : '',
      'descripcion': '',
      'codigo': '',
      'userLiked' : []
    };

    record.forEach((key,value) => {attributes[key] = value});

    PostOferta oferta = new PostOferta(
      attributes['nombre'], 
      attributes['author'],
      attributes['descripcion'],
      attributes['codigo']);

    oferta.userLiked = new Set.from(attributes['userLiked']);
    return oferta;

  } 