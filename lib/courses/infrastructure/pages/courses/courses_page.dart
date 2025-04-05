import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/error_state.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/loading_state.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/courses_page_cubit.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/partials/schedule_semester_select.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/tabs/enrolled_courses_tab.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/tabs/schedule_tab.dart';
import 'package:sigapp/shared/infrastructure/partials/user_avatar_button.dart';

class CoursesPageWidget extends StatefulWidget {
  // const CoursesPageWidget({super.key, required this.appBarTrailing});
  const CoursesPageWidget({super.key});

  // final Widget appBarTrailing;

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
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
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
            // widget.appBarTrailing,
            UserAvatarButtonWidget(),
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
          _Tab1(
            enrolledCourses: state.enrolledCourses,
            onRetry: () => _cubit.retryFetchEnrolledCourses(),
          ),
          _Tab2(
            coursesPageSuccessState: state,
            onRetry: () => _cubit.retryFetchEnrolledCourses(),
          ),
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

class _Tab1 extends StatefulWidget {
  const _Tab1({required this.enrolledCourses, required this.onRetry});

  final EnrolledCoursesState enrolledCourses;
  final void Function() onRetry;

  @override
  State<_Tab1> createState() => _Tab1State();
}

class _Tab1State extends State<_Tab1> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EnrolledCoursesTabWidget(
      enrolledCourses: widget.enrolledCourses,
      onRetry: widget.onRetry,
    );
  }
}

class _Tab2 extends StatefulWidget {
  const _Tab2({required this.coursesPageSuccessState, required this.onRetry});

  final CoursesPageSuccessState coursesPageSuccessState;
  final void Function() onRetry;

  @override
  State<_Tab2> createState() => _Tab2State();
}

class _Tab2State extends State<_Tab2> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ScheduleTabWidget(
      enrolledCoursesState: widget.coursesPageSuccessState.enrolledCourses,
      academicReport: widget.coursesPageSuccessState.academicReport,
      selectedSemester: widget.coursesPageSuccessState.selectedSemester,
      onRetry: widget.onRetry,
    );
  }
}
