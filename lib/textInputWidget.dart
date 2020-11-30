import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  final Function(String, int) callback;

  TextInputWidget(this.callback);

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState(); 
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();
  final controller2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  

  @override
  void dispose(){
    super.dispose();
    controller.dispose();
    controller2.dispose();
  } 

  void click(){
    widget.callback(controller.text, int.parse(controller2.text));
    FocusScope.of(context).unfocus();
    controller.clear();
    controller2.clear();
    
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: this.controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Tipo'),
            validator: (value) {
            if(value.isEmpty){
              return 'Escriba el tipo';
            }
            return null;
            } 
          ),
          TextFormField(
            controller: this.controller2,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Cantidad'),
            validator: (value) {
            if(value.isEmpty){
              return 'Escriba la cantidad';
            }
            return null;
            } 
          ),
          FlatButton(
            color: Colors.blue,
            onPressed:(){
              if(_formKey.currentState.validate()){
                //llamar funcion
                this.click();
                Scaffold.of(context)
                .showSnackBar(SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Transaccion agregada')));
              } else {
                Scaffold.of(context)
                .showSnackBar(SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text('Hubo un problema')));
              }
            }, 
            child: Text('Submit', 
              style: TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.bold)
            )
          )
        ]
      )
      
    );
  }

  //@override
  //Widget build(BuildContext context) {
    //return TextField(
      //controller: this.controller,
      //decoration: InputDecoration(
        //prefixIcon: Icon(Icons.message), 
        //labelText: "Ingrese su oferta",
         //suffixIcon: IconButton(
           //icon: Icon(Icons.send),
           //splashColor: Colors.blue,
           //tooltip: "Enviar mensaje",
            //onPressed: this.click,
         //)));
  //}
}