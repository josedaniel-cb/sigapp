import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/core/injection/get_it.dart';
import 'package:sigapp/core/pages/home_page_cubit.dart';
import 'package:sigapp/core/widgets/error_state.dart';
import 'package:sigapp/core/widgets/loading_state.dart';
import 'package:sigapp/courses/infrastructure/pages/career/career_page.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/courses_page.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/courses_page_cubit.dart';
import 'package:sigapp/courses/infrastructure/pages/schedule/schedule_cubit.dart';
import 'package:sigapp/courses/infrastructure/pages/schedule/schedule_page.dart';
import 'package:sigapp/student/infrastructure/pages/student_cubit.dart';
import 'package:sigapp/student/infrastructure/pages/student_page_view.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  @override
  void initState() {
    // final cubit = BlocProvider.of<HomePageCubit>(context);
    // cubit.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final cubit = BlocProvider.of<HomePageCubit>(context);

    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        return state.map(
          // loading: (_) => Scaffold(body: const LoadingStateWidget()),
          // error: (state) => Scaffold(
          //   body: ErrorStateWidget(
          //     message: state.message,
          //     // onRetry: () => cubit.init(),
          //   ),
          // ),
          success: (state) => HomePageSuccessStateWidget(state: state),
        );
      },
    );
  }
}

class HomePageSuccessStateWidget extends StatefulWidget {
  const HomePageSuccessStateWidget({super.key, required this.state});

  final HomePageSuccessState state;

  @override
  HomeStateReadyStateStatefulWidgetState createState() =>
      HomeStateReadyStateStatefulWidgetState();
}

class HomeStateReadyStateStatefulWidgetState
    extends State<HomePageSuccessStateWidget>
    with AutomaticKeepAliveClientMixin {
  final PageController _pageController = PageController();
  // late final HomePageCubit _cubit;

  @override
  bool get wantKeepAlive => true;

  // @override
  // void initState() {
  //   super.initState();
  //   // _cubit = BlocProvider.of<HomePageCubit>(context);
  //   // _cubit.init();
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = BlocProvider.of<HomePageCubit>(context);

    return BlocListener<HomePageCubit, HomePageState>(
      child: Scaffold(
        appBar: AppBar(
          title: (() {
            switch (widget.state.selectedTabIndex) {
              case 0:
                return Text(
                  'Sigapp',
                  style: TextStyle(fontWeight: FontWeight.w500),
                );
              case 1:
                return Text('Horario');
              case 2:
                return Text('Carrera');
              case 3:
                return Text('Estudiante');
              default:
                return Container();
            }
          })(),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'logout') {
                  cubit.logout();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Cerrar sesión'),
                ),
              ],
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) => cubit.changeTab(index),
          children: <Widget>[
            BlocProvider(
              create: (_) => getIt<CoursesPageCubit>(),
              child: CoursesPageWidget(
                  // semesterContext: widget.state.semesterContext,
                  ),
            ),
            BlocProvider<ScheduleCubit>(
              create: (_) => getIt<ScheduleCubit>(),
              child: SchedulePage(),
            ),
            CareerPage(),
            BlocProvider<StudentPageViewCubit>(
              create: (_) => getIt<StudentPageViewCubit>(),
              child: StudentPageView(),
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.book),
              label: 'Cursos',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_today),
              label: 'Horario',
            ),
            NavigationDestination(
              icon: Icon(Icons.school),
              label: 'Carrera',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Estudiante',
            ),
          ],
          selectedIndex: widget.state.selectedTabIndex,
          onDestinationSelected: (index) => cubit.changeTab(index),
        ),
      ),
      listener: (context, state) {
        if (state is! HomePageSuccessState) return;

        if (_pageController.hasClients &&
            _pageController.page != state.selectedTabIndex) {
          _pageController.jumpToPage(state.selectedTabIndex);
        }
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              action: SnackBarAction(
                label: 'OK',
                onPressed: () => cubit.markErrorAsRead(),
              ),
            ),
          );
        }
      },
    );
  }
}
