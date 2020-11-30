import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'transaccion.dart';
import 'package:random_color/random_color.dart';


class Balance extends StatefulWidget {
  final List<Transaccion> ofertas;
  final Widget child;


  Balance(this.ofertas,{Key key, this.child}) : super(key: key);

  @override
  _BalanceState createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
    List<charts.Series<Task,String>> _datos;

    _generarDatos(List<Transaccion> lista){

      List<Task> pieData = [];
      RandomColor _randomColor = RandomColor();

     
      for(var i=0;i<lista.length;i++){
        Transaccion t= lista[i];
        Color _color = _randomColor.randomColor(colorHue: ColorHue.blue);
        pieData.add(new Task(t.tipo,t.cantidad,_color));
      }
     

      _datos.add(
        charts.Series(
          data: pieData,
          domainFn: (Task task,_) => task.task,
          measureFn: (Task task,_) => task.taskValue,
          colorFn: (Task task,_) => 
            charts.ColorUtil.fromDartColor(task.color),
          id: 'Balance',
          labelAccessorFn: (Task row,_) => '${row.taskValue}',
        ),
      );

    }
    @override
    void initState(){
      super.initState();
      _datos = List<charts.Series<Task,String>>();
      _generarDatos(this.widget.ofertas);
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[Expanded(child:
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Balance segun transacciones',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Expanded(
                      child: charts.PieChart(
                        _datos,
                        animate: true,
                        animationDuration: Duration(seconds:5),
                        behaviors: [
                          new charts.DatumLegend(
                            outsideJustification: charts.OutsideJustification.endDrawArea,
                            horizontalFirst: false,
                            desiredMaxRows: 2,
                            cellPadding: new EdgeInsets.only(right:4.0, bottom: 4.0),
                            entryTextStyle: charts.TextStyleSpec(
                              color: charts.MaterialPalette.black.darker,
                              fontFamily: 'Georgia',
                              fontSize: 11 
                            ) 
                          )
                        ],
                        defaultRenderer: new charts.ArcRendererConfig(
                          arcWidth: 100,
                          arcRendererDecorators: [
                            new charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.inside
                            )
                          ]
                        ), 
                      )
                      )
                  ],
                ),
              ),
            ),
          )
        )],
        ),
    );
  }
}

class Task{

  String task;
  int taskValue;
  Color color;

  Task(this.task,this.taskValue, this.color);

}