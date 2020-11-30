import 'transaccion.dart';
import 'package:firebase_database/firebase_database.dart';
import 'postOferta.dart';

final databaseReference = FirebaseDatabase.instance.reference();

void updatePost(PostOferta oferta, DatabaseReference id){
   id.update(oferta.toJson());
}

DatabaseReference saveTransaccion(Transaccion post) {
  var id = databaseReference.child('transacciones/').push();
  id.set(post.toJson());
  return id;
}

Future<List<Transaccion>> getAllTransacciones() async {
  
  DataSnapshot dataSnapshot = await databaseReference.child('transacciones/').once();
  List<Transaccion> ofertas = [];
  if(dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      Transaccion oferta = createTransaccion(value);
      oferta.setId(databaseReference.child('transacciones/' + key));
      ofertas.add(oferta);
    });
  }
  return ofertas;
}

Future<List<PostOferta>> getAllOfertas() async {
  
  DataSnapshot dataSnapshot = await databaseReference.child('ofertas/').once();
  List<PostOferta> ofertas = [];
  if(dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      PostOferta oferta = createOferta(value);
      oferta.setId(databaseReference.child('ofertas/' + key));
      ofertas.add(oferta);
    });
  }
  return ofertas;
}