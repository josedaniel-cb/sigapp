import 'package:flutter/material.dart';
import 'package:SIGApp/app/app.dart';
// import 'package:SIGApp/app/app.dart';
import 'package:SIGApp/models/curso_model/curso_model.dart';
// import 'package:SIGApp/widgets/basic/round_container.dart';

class CursoWidget extends StatelessWidget{
  final CursoModel cursoModel;
  final List<Widget> botones;
  final int index;
  final bool enumerado;
  
  static const double _tamFuente = 15;

  CursoWidget({
    @required this.cursoModel, 
    this.botones,
    this.index,
    this.enumerado = true,
  });


  @override
  Widget build(BuildContext context) {
    List<Widget> contenido = <Widget>[
      // _buildTitulo(),
      _buildCaracteristicas(),
    ];
    if(botones != null){
      contenido.add(_buildBotones());
    }
    return _buildCurso(contenido: contenido);
  }

  Widget _buildCurso({@required List<Widget> contenido}){
    return Container(
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(App.bordeRadio)
          )
        ),
        child: ExpansionTile(
          initiallyExpanded: false,
          // leading: enumerado && index != null ? _buildTituloNumero() : null,
          title: _buildTitulo(),
          children: <Widget>[            
            Container(
              padding: EdgeInsets.only(
                bottom: 18,
                left: 18,
                right: 18,
              ),
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: contenido,
              ),
            ),            
          ],
        ),
      ),
    );
  }

  Widget _buildTitulo(){
    List<Widget> title = [_buildTituloNombre()];
    if(enumerado && index != null){
      // title.add(_buildTituloNumero());
      title.insert(0, _buildTituloNumero());
    }
    return 
    Container(
      // color: Colors.red,
      padding: EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: title,
      ),
    )
    ;
  }

  Widget _buildTituloNombre(){
    const TextStyle cursoStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.blue,
    );
    const TextStyle codigoStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Colors.grey,
    );

    List<Widget> contenido = [
      Text(cursoModel.nombre, style: cursoStyle,),
      SizedBox(height: 10,),
    ];

    if(cursoModel.codigo != null){
      contenido.insert(
        1, 
        Text(
          cursoModel.codigo, 
          style: codigoStyle,
        ),
      );
    }
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: contenido,
      ),
    );
  }

  Widget _buildTituloNumero(){
    return Container(
      margin: EdgeInsets.only(right: 12, top: 2),
      // color: Colors.red,
      child: SizedBox(
        height: 18,
        width: 18,            
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black26,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$index',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCaracteristicas(){      
    final TextStyle _estiloItemTitle = TextStyle(
      fontSize: _tamFuente,
      fontWeight: FontWeight.w700,
    );
    final TextStyle _estiloItemContent = TextStyle(
      fontSize: _tamFuente,
    );
    return Column(
      children: List.generate(cursoModel.caracteristicas.length, (int i){
        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${cursoModel.caracteristicas[i].nombre}', style: _estiloItemTitle),
                Text('${cursoModel.caracteristicas[i].contenido}', style: _estiloItemContent, textAlign: TextAlign.end,),
              ]
            ),
            _buildDivisor(),
          ],
        );
      }),
    );
  }

  Widget _buildDivisor() {
    return Divider(
      color: Colors.black12,
      height: 3,
      thickness: 1,
    );
  }
  
  Widget _buildBotones(){
    return Container(
      // color: Colors.grey,
      padding: EdgeInsets.only(
        top: 10, 
        // right: 15, 
        // left: 15, 
        // bottom: 15
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(botones.length, (int i){
                // return botones[i];
                return Container(
                  margin: EdgeInsets.only(left: 17),
                  child: botones[i],
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}