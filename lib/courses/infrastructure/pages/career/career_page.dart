import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/error_state.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/loading_state.dart';
import 'package:sigapp/courses/domain/entities/academic_history_term.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';
import 'package:sigapp/courses/infrastructure/pages/career/career_page_cubit.dart';
import 'package:sigapp/shared/infrastructure/partials/user_avatar_button.dart';

class CareerPageView extends StatefulWidget {
  const CareerPageView({super.key});

  @override
  State<CareerPageView> createState() => _CareerPageViewState();
}

class _CareerPageViewState extends State<CareerPageView>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final CareerPageCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<CareerPageCubit>(context);
    _cubit.fetch();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CareerPageCubit, CareerPageState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Carrera'),
              UserAvatarButtonWidget(),
            ],
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                icon: Icon(MdiIcons.notebookOutline),
                text: 'Plan de estudios',
              ),
              Tab(
                icon: Icon(MdiIcons.fileChartOutline),
                text: 'Historial académico',
              ),
            ],
          ),
        ),
        body: state.map(
          loading: (_) => LoadingStateWidget(),
          success: _buildReadyState,
          error: (s) => ErrorStateWidget(message: s.message),
        ),
      );
    });
  }

  Widget _buildReadyState(CareerPageSuccessState state) {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildProgramCurriculum(
            state.programCurriculumProgress.programCurriculum),
        _buildAcademicHistory(state.programCurriculumProgress.academicHistory),
      ],
    );
  }

  Widget _buildProgramCurriculum(
      List<ProgramCurriculumTerm> programCurriculum) {
    return ListView(
      children: programCurriculum.map(
        (term) {
          return ExpansionTile(
            title: Text('Ciclo ${term.termRomanNumeral}'),
            children: term.courses.map(
              (course) {
                return ListTile(
                  title: Text(course.info.courseName),
                  subtitle: Text(course.info.courseCode),
                  trailing: course.isApproved == null
                      ? null
                      : course.isApproved!
                          ? Icon(Icons.check, color: Colors.green)
                          : Icon(Icons.close, color: Colors.red),
                );
              },
            ).toList(),
          );
        },
      ).toList(),
    );
  }

  Widget _buildAcademicHistory(List<AcademicHistoryTerm> academicHistory) {
    return ListView(
      children: academicHistory.map(
        (term) {
          return ExpansionTile(
            title: Text('Ciclo ${term.term.name}'),
            children: term.courses.map(
              (course) {
                return ListTile(
                  title: Text(course.courseName),
                  subtitle: Text(course.courseCode),
                  trailing: Text(course.grade.toString()),
                );
              },
            ).toList(),
          );
        },
      ).toList(),
    );
  }
}
