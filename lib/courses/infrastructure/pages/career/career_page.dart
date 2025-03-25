import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/error_state.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/loading_state.dart';
import 'package:sigapp/courses/infrastructure/pages/career/career_page_cubit.dart';
import 'package:sigapp/courses/infrastructure/pages/career/partials/academic_history.dart';
import 'package:sigapp/courses/infrastructure/pages/career/partials/program_curriculum.dart';
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
    _tabController = TabController(length: 2, vsync: this);
    _cubit = BlocProvider.of<CareerPageCubit>(context);
    _cubit.fetch();
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
                icon: Icon(MdiIcons.book),
                text: 'Plan de estudios',
              ),
              Tab(
                icon: Icon(MdiIcons.fileChart),
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
        CareerPageProgramCurriculumWidget(
          programCurriculum: state.programCurriculumProgress.programCurriculum,
        ),
        CareerPageAcademicHistoryWidget(
          academicHistory: state.programCurriculumProgress.academicHistory,
          report: state.academicReport,
        ),
      ],
    );
  }
}
