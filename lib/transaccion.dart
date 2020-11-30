
import 'package:firebase_database/firebase_database.dart';

class Transaccion{
  String tipo;
  String autor;
  int cantidad;
  DatabaseReference _id;

  Transaccion(this.tipo,this.autor, this.cantidad);

  void setId(DatabaseReference id){
    this._id = id;
  }

  Map<String, dynamic> toJson(){
    return{
      'tipo': this.tipo,
      'author': this.autor,
      'cantidad': this.cantidad,

    };

  }


}

Transaccion createTransaccion(record){

  Map<String, dynamic> attributes = {
      'tipo' : '',
      'author' : '',
      'cantidad': '',
  };

  record.forEach((key,value) => {attributes[key] = value});

  Transaccion tran = new Transaccion(
    attributes['tipo'],
    attributes['author'], 
    attributes['cantidad']);

  return tran;

}