import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/app/app.dart';
import 'package:sigapp/blocs/programacion_bloc/bloc.dart';
import 'package:sigapp/widgets/lista_cursos_widget/curso_widget.dart';
import 'package:sigapp/widgets/lista_cursos_widget/lista_cursos_widget.dart';
import 'package:sigapp/widgets/simple_loading_body_widget.dart';

class ProgramacionPage extends StatefulWidget {
  const ProgramacionPage({super.key});

  @override
  State<StatefulWidget> createState() => ProgramacionPageState();
}

class ProgramacionPageState extends State<ProgramacionPage> {
  ProgramacionBloc? _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ProgramacionBloc>(context);
    App.browserController.programacionBloc = _bloc;
    App.browserController.programacionSolicitarInformeAcademico();
  }

  @override
  void dispose() {
    _bloc!.close();
    App.browserController.solicitudActiva = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgramacionBloc, ProgramacionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state is Loading
                ? 'Programación académica'
                : ' Programación ${_bloc!.modelo.semestre}'),
          ),
          body: state is Loading ? const SimpleLoadingBodyWidget() : _buildBody(),
        );
      },
    );
  }

  Widget _buildBody() {
    return ListaCursosWidget(
      leyenda: Text(
        ' Total de cursos:\t${_bloc!.modelo.cursos.length}',
        textAlign: TextAlign.start,
      ),
      cursos: List.generate(_bloc!.modelo.cursos.length, (int i) {
        return CursoWidget(
          enumerado: false,
          cursoModel: _bloc!.modelo.cursos[i],
        );
      }),
    );
  }
}
