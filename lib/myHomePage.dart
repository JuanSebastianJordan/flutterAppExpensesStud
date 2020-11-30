import 'package:studentexpenses/balance.dart';
import 'package:studentexpenses/transaccion.dart';
import 'package:studentexpenses/transaccionList.dart';

import 'auth.dart';
import 'database.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'postOferta.dart';
import 'ofertaList.dart';
import 'profile.dart';
 
class MyHomePage extends StatefulWidget {
  final FirebaseUser user;

  
  MyHomePage(this.user);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<PostOferta> ofertas = [];
  List<Transaccion> trans = [];

  void addTransaccion(Transaccion oferta){
    this.trans.add(oferta);
  }

  void newTransaccion(String tipo, int cantidad){
    var post = new Transaccion(tipo, widget.user.displayName, cantidad);
    
    post.setId(saveTransaccion(post)); 
    this.setState(() {
      trans.add(post);

    });
  }

  void updateTransaccion() {
    getAllTransacciones().then((ofertas) => {
      this.setState(() {
        this.trans = ofertas;
      })
    });

  }

  void updateOfertas() {
    getAllOfertas().then((ofertas) => {
      this.setState(() {
        this.ofertas = ofertas;
      })
    });

  }

  @override
  void initState() {
    updateOfertas();
    updateTransaccion();
    super.initState();
  }

  int selected = 0;
  drawerItem(int pos){
    switch(pos){
      case 0: return OfertaList(this.ofertas, widget.user);
                      
      case 1: return Profile(widget.user, this.addTransaccion);

      case 2: return TransaccionList(this.trans, widget.user);

      case 3: return Balance(this.trans);

      case 4: {signOutGoogle();
                return LoginPage();}
    }
  }

  onSelected(int pos){
    Navigator.of(context).pop();
    setState(() {
      
    selected = pos;
    });
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(title: Text('Expenses')),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(widget.user.displayName) , 
              accountEmail: Text(widget.user.email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(widget.user.photoUrl),
                backgroundColor: Colors.blue,
              )
              ),
            ListTile(
              title: Text('FEED'),
              leading: Icon(Icons.people_alt),
              selected: (0 == selected),
              onTap: (){
                //Navigator.of(context).pop();
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (BuildContext context) => MyHomePage(widget.user)));
                onSelected(0);
              }
            ),
            ListTile(
              title: Text('PERFIL'),
              leading: Icon(Icons.person),
              selected: (1 == selected),
              onTap:(){
                //Navigator.of(context).pop();
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (BuildContext context) => Profile())); 
                onSelected(1);
              } 
            ),
            ListTile(
              title: Text('TRANSACCIONES'),
              leading: Icon(Icons.monetization_on),
              selected: (2 == selected),
              onTap:(){
                //Navigator.of(context).pop();
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (BuildContext context) => Profile())); 
                onSelected(2);
              } 
            ),
            ListTile(
              title: Text('BALANCE'),
              leading: Icon(Icons.monetization_on),
              selected: (3 == selected),
              onTap:(){
                //Navigator.of(context).pop();
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (BuildContext context) => Profile())); 
                onSelected(3);
              } 
            ),
            ListTile(
              title: Text('LOGOUT'),
              leading: Icon(Icons.logout),
              selected: (4 == selected),
              onTap:(){
                //Navigator.of(context).pop();
                //Navigator.of(context).push(MaterialPageRoute(
                //builder: (BuildContext context) => Profile())); 
                onSelected(4);
              } 
            ),
          ]
        ),
      ),
      body: drawerItem(selected));
  }


}