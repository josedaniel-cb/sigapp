import 'package:SIGApp/app/app.dart';
import 'package:SIGApp/browser/gestor_firebase.dart';
import 'package:SIGApp/widgets/simple_loading_body_widget.dart';
import 'package:flutter/material.dart';

class TerminosPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => TerminosPageState();
}

class TerminosPageState extends State<TerminosPage>{
  bool _waiting = true;
  String _contenido;

  @override
  void initState(){
    super.initState();
    App.browserController.gestorFirebase.registrarUso(CasosDeUso.TerminosYCondiciones);
    _solicitarTerminos();
  }

  Future<void> _solicitarTerminos() async {
    _contenido = await App.browserController.gestorFirebase.obtenerTerminosYCondiciones();
    setState(() => _waiting = false);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Términos y Condiciones de Uso'),
      ),
      body: _waiting ? SimpleLoadingBodyWidget() : _buildTerminos(),
    );
  }

  Widget _buildTerminos(){
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Text(
          _contenido,
          style: TextStyle(
            color: Colors.black45,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}