import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'postOferta.dart';

class OfertaList extends StatefulWidget {
  final List<PostOferta> ofertas;
  final FirebaseUser user;
 

  OfertaList(this.ofertas, this.user);

  @override
  _OfertaListState createState() => _OfertaListState();
}

class _OfertaListState extends State<OfertaList> {

  

  void like(Function callBack){
    this.setState(() {
      callBack();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(child:Column(children: <Widget>[
        Text('Ofertas',
        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
        Expanded(child:ListView.builder(
      itemCount: this.widget.ofertas.length,
      itemBuilder: (context, index) {
        var post = this.widget.ofertas[index];
        return Card(child: Row(children: <Widget>[Expanded(
          child: ListTile(
            title: Text(post.nombre),
            subtitle: Text(post.autor),
            ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(post.descripcion)
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(post.codigo)
            ),
            Row(
              children: <Widget>[
                Container(child: Text(post.userLiked.length.toString(),
                 style: TextStyle(fontSize: 20)),
                 padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                 ),
                IconButton(
                  icon: Icon(Icons.thumb_up),
                  onPressed: () => this.like(() => post.likePost(widget.user)),
                  color: post.userLiked.contains(widget.user.uid) ? Colors.green: Colors.black)
              ],
            )
          ]));
      },
    ))])));
  }
}