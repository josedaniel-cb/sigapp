import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/core/injection/get_it.dart';
import 'package:sigapp/core/widgets/error_state.dart';
import 'package:sigapp/core/widgets/loading_state.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/courses_page_cubit.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/partials/schedule_semester_select.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/tabs/enrolled_courses.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/tabs/enrolled_courses_cubit.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/tabs/schedule.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/tabs/schedule_cubit.dart';

class CoursesPageWidget extends StatefulWidget {
  const CoursesPageWidget({super.key});

  @override
  State<CoursesPageWidget> createState() => _CoursesPageWidgetState();
}

class _CoursesPageWidgetState extends State<CoursesPageWidget>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final CoursesPageCubit _cubit;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _cubit = BlocProvider.of<CoursesPageCubit>(context);
    _cubit.init();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesPageCubit, CoursesPageState>(
      builder: (context, state) {
        return state.map(
          loading: (_) => const LoadingStateWidget(),
          error: (state) => ErrorStateWidget(
            message: state.message,
            onRetry: () => _cubit.init(),
          ),
          success: _buildSuccessState,
        );
      },
    );
  }

  Widget _buildSuccessState(CoursesPageSuccessState state) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Semestre'),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                _showModalBottomSheet(state);
              },
              child: Row(
                children: [
                  Text(state.selectedSemester.name),
                  const Icon(Icons.arrow_drop_down, size: 20),
                ],
              ),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.book), text: 'Cursos'),
            Tab(icon: Icon(Icons.schedule), text: 'Horario'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          EnrolledCoursesTabWrapperWidget(),
          ScheduleTabWrapperWidget(),
        ],
      ),
    );
  }

  void _showModalBottomSheet(CoursesPageSuccessState state) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: ScheduleSemesterSelect(
            onSemesterSelected: (semester) {
              _cubit.changeSemester(semester);
              Navigator.pop(context);
            },
            semesterList: [...state.semesterContext.availableSemesters],
            selectedSemester: state.selectedSemester,
          ),
        );
      },
    );
  }
}

class EnrolledCoursesTabWrapperWidget extends StatefulWidget {
  const EnrolledCoursesTabWrapperWidget({super.key});

  @override
  State<EnrolledCoursesTabWrapperWidget> createState() =>
      _EnrolledCoursesTabWrapperWidgetState();
}

class _EnrolledCoursesTabWrapperWidgetState
    extends State<EnrolledCoursesTabWrapperWidget>
    with AutomaticKeepAliveClientMixin {
  final _cubit = getIt<EnrolledCoursesTabCubit>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CoursesPageCubit, CoursesPageState>(
      builder: (context, state) {
        if (state is CoursesPageSuccessState) {
          _cubit.fetch(state.selectedSemester);
        }
        return BlocProvider.value(
          value: _cubit,
          child: EnrolledCoursesTabWidget(),
        );
      },
    );
  }
}

class ScheduleTabWrapperWidget extends StatefulWidget {
  const ScheduleTabWrapperWidget({super.key});

  @override
  State<ScheduleTabWrapperWidget> createState() =>
      _ScheduleTabWrapperWidgetState();
}

class _ScheduleTabWrapperWidgetState extends State<ScheduleTabWrapperWidget>
    with AutomaticKeepAliveClientMixin {
  final _cubit = getIt<ScheduleTabCubit>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CoursesPageCubit, CoursesPageState>(
      builder: (context, state) {
        if (state is CoursesPageSuccessState) {
          _cubit.fetch(state.selectedSemester);
        }
        return BlocProvider.value(
          value: _cubit,
          child: ScheduleTabWidget(),
        );
      },
    );
  }
}
