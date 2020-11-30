import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'transaccion.dart';
import 'package:intl/intl.dart';

class TransaccionList extends StatefulWidget {
  final List<Transaccion> ofertas;
  final FirebaseUser user;
 

  TransaccionList(this.ofertas, this.user);

  @override
  _TransaccionListState createState() => _TransaccionListState();
}

class _TransaccionListState extends State<TransaccionList> {

  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(child:Column(children: <Widget>[
        Text('Transacciones',
        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
        Expanded(child:ListView.builder(
      itemCount: this.widget.ofertas.length,
      itemBuilder: (context, index) {
        var post = this.widget.ofertas[index];
        return Card(child: Row(children: <Widget>[Expanded(
          child: ListTile(
            title: Text(post.tipo),
            subtitle: Text(post.autor),
            ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(NumberFormat.currency().format(post.cantidad))
            ),
          ]));
      },
    ))])));
  }
}