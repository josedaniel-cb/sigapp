import 'package:flutter/material.dart';
import 'package:sigapp/app/app.dart';
import 'package:sigapp/models/curso_model/curso_caracteristica.dart';
import 'package:sigapp/models/plan_model/plan_model.dart';
import 'package:sigapp/widgets/lista_cursos_widget/curso_widget.dart';
import 'package:sigapp/widgets/lista_cursos_widget/lista_cursos_widget.dart';

class ListaCursosPlanPage extends StatefulWidget {
  final String title;
  final List<CursoPlanModel>? cursos;
  final PlanModel? plan;
  final bool isRoot;

  const ListaCursosPlanPage({super.key, 
    required this.title,
    required this.cursos,
    required this.plan,
    required this.isRoot,
  });

  @override
  State<StatefulWidget> createState() => ListaCursosPlanPageState();
}

class ListaCursosPlanPageState extends State<ListaCursosPlanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListaCursosWidget(
        cursos: List.generate(widget.cursos!.length, (int i) {
          return CursoWidget(
            cursoModel: widget.cursos![i],
            index: i + 1,
            botones: widget.cursos![i].requisitos!.isNotEmpty
                ? _buildBotonRequisitos(i)
                : null,
          );
        }),
      ),
    );
  }

  List<Widget> _buildBotonRequisitos(int i) {
    List<Widget> botones;
    botones = [];
    botones.add(_buildBoton(
      text: 'Requisitos',
      onPressed: () => _tapRequisitos(i),
    ));
    return botones;
  }

  Widget _buildBoton({required String text, required Function onPressed}) {
    return ElevatedButton(
      onPressed: onPressed as void Function()?,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.blueAccent),
        elevation: WidgetStateProperty.all<double>(5.0),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(App.bordeRadio),
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  void _tapRequisitos(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ListaCursosPlanPage(
                isRoot: false,
                plan: widget.plan,
                title: 'Requisitos ${widget.cursos![index].nombre}',
                cursos: List.generate(widget.cursos![index].requisitos!.length,
                    (int i) {
                  int indexCiclo =
                      widget.cursos![index].requisitos![i].cicloIndex!;
                  int indexCurso =
                      widget.cursos![index].requisitos![i].cursoIndex!;
                  // if(!widget.isRoot){
                  CursoPlanModel cursoOriginal =
                      widget.plan!.ciclos[indexCiclo]!.cursos![indexCurso];
                  CursoPlanModel cursoTemporal = CursoPlanModel(
                      cursoOriginal.nombre, cursoOriginal.codigo);
                  cursoTemporal.requisitos = cursoOriginal.requisitos;
                  cursoTemporal.caracteristicas =
                      cursoOriginal.caracteristicas.toSet().toList();
                  cursoTemporal.caracteristicas.add(CursoCaracteristica('Ciclo',
                      widget.plan!.ciclos[indexCiclo]!.etiqueta.split(' ')[1]));
                  return cursoTemporal;
                  // } else {
                  //   return widget.plan.ciclos[indexCiclo].cursos[indexCurso];
                  // }
                }),
              )),
    );
  }
}
