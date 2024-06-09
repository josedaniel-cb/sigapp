import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/app/app.dart';
import 'package:sigapp/blocs/plan_bloc/bloc.dart';
import 'package:sigapp/widgets/lista_semestres_widget.dart';
import 'package:sigapp/widgets/simple_loading_body_widget.dart';

import 'lista_cursos_plan_page.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  State<StatefulWidget> createState() => PlanPageState();
}

class PlanPageState extends State<PlanPage> {
  PlanBloc? _planBloc;

  @override
  void initState() {
    super.initState();
    _planBloc = BlocProvider.of<PlanBloc>(context);
    App.browserController.planBloc = _planBloc;
    App.browserController.planSolicitarPlanDeEstudios();
  }

  @override
  void dispose() {
    _planBloc!.close();
    App.browserController.solicitudActiva = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanBloc, PlanState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Plan de estudios${state is Ready ? ' ${_planBloc!.modelo!.etiqueta}' : ''}'),
          ),
          body: state is Ready ? _buildPlan() : const SimpleLoadingBodyWidget(),
        );
      },
    );
  }

  Widget _buildPlan() {
    return ListaSemestresWidget(
      icono: const Icon(
        Icons.book,
        color: Colors.red,
      ),
      children: List.generate(_planBloc!.modelo!.ciclos.length, (int i) {
        return ElementoListaSemestresWidget(
          numero: _planBloc!.modelo!.ciclos[i]!.cursos!.length,
          onPressed: () => _lanzarCicloPage(i),
          titulo: _planBloc!.modelo!.ciclos[i]!.etiqueta,
        );
      }),
    );
  }

  void _lanzarCicloPage(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ListaCursosPlanPage(
                isRoot: true,
                title: _planBloc!.modelo!.ciclos[index]!.etiqueta,
                cursos: _planBloc!.modelo!.ciclos[index]!.cursos,
                plan: _planBloc!.modelo,
              )),
    );
  }
}
